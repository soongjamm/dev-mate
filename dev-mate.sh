#!/bin/bash
# dev-mate

# 스크립트가 위치한 디렉토리
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

check_gemini_error() {
  if grep -q "429" "$1"; then
    echo "[오류] Gemini API 요청 한도(429 Too Many Requests)에 도달했습니다."
    echo "잠시 후 다시 시도하거나, 요금제/쿼터를 확인하세요."
    exit 1
  fi
}

case "$1" in
  code-review)
    TEMPLATE="$SCRIPT_DIR/template.html"
    PROMPT="$SCRIPT_DIR/code-review/prompt.txt"
    DIFF_FILE="/tmp/diff.txt"
    OUT_FILE="$SCRIPT_DIR/code-review/review.html"

    git diff > "$DIFF_FILE"

    cat "$TEMPLATE" | gemini /code -y -p "$(cat "$PROMPT"; echo; cat "$DIFF_FILE")" 2> /tmp/gemini_error.log > "$OUT_FILE"
    check_gemini_error /tmp/gemini_error.log
    ;;
  # 다른 기능도 여기에 추가 가능
  *)
    echo "사용법: dev-mate code-review"
    ;;
esac