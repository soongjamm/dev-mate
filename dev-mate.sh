#!/bin/bash
# dev-mate

# 스크립트가 위치한 디렉토리
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 실행 시간 측정 및 로그 함수 (구조적 변경)
time_log_start() {
  export START_TIME=$(date +%s)
  echo "[로그] $1 시작: $(date '+%Y-%m-%d %H:%M:%S')"
}

time_log_end() {
  local END_TIME=$(date +%s)
  local ELAPSED_TIME=$((END_TIME - START_TIME))
  echo "[로그] $1 종료: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "[완료] '$1' 전체 소요 시간: ${ELAPSED_TIME}초"
}

check_gemini_error() {
  if grep -q "429" "$1"; then
    echo "[오류] Gemini API 요청 한도(429 Too Many Requests)에 도달했습니다."
    echo "잠시 후 다시 시도하거나, 요금제/쿼터를 확인하세요."
    time_log_end "Gemini 코드리뷰"
    exit 1
  fi
}

case "$1" in
  code-review)
    TEMPLATE="$SCRIPT_DIR/code-review/template.html"
    PROMPT="$SCRIPT_DIR/code-review/prompt.txt"
    DIFF_FILE="/tmp/diff.txt"
    OUT_FILE="$SCRIPT_DIR/code-review/review.html"

    git diff > "$DIFF_FILE"

    time_log_start "Gemini 코드리뷰"
    cat "$TEMPLATE" | gemini /code -y -p "$(cat "$PROMPT"; echo; cat "$DIFF_FILE")" 2> /tmp/gemini_error.log > "$OUT_FILE"
    check_gemini_error /tmp/gemini_error.log
    time_log_end "Gemini 코드리뷰"
    ;;
  # 다른 기능도 여기에 추가 가능
  *)
    echo "사용법: dev-mate code-review"
    ;;
esac