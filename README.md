# DevMate

DevMate는 로컬 개발 환경에서 개발자의 생산성을 극대화하기 위한 CLI 도구입니다. 코드 리뷰 자동화, 테스트 코드 생성, 에러 원인 분석 등 반복적이고 시간이 많이 소요되는 작업을 자동화하여 개발자의 효율적인 개발을 지원합니다.

---

## 주요 기능

- **코드 리뷰 자동화**: 변경사항(diff) 기준으로 예상 리뷰 질문, 휴먼 에러, 누락된 테스트 등을 분석하여 리뷰 코멘트를 생성합니다. 리뷰 결과는 HTML 파일로 저장할 수 있습니다.
- **테스트 코드 자동 생성**: 변경된 코드에 대한 테스트 코드를 자동으로 생성합니다.
- **에러 원인 분석**: stacktrace 파일을 입력받아 코드베이스를 분석하고, 에러의 원인과 관련된 정보를 제공합니다.

---

## 설치 방법

1. 저장소 클론 및 의존성 설치
   ```bash
   git clone https://github.com/your-org/dev-mate.git
   cd dev-mate
   npm install
   ```
2. 실행 파일 준비 및 권한 부여
   ```bash
   chmod +x bin/dev-mate
   ```
3. 명령어 등록 (아래 중 하나 선택)
   - **npm link (Node.js 표준)**
     ```bash
     npm link
     ```
   - **$PATH에 직접 복사**
     ```bash
     sudo cp bin/dev-mate /usr/local/bin/
     ```

---

## 사용법

아래와 같이 명령어를 입력해 DevMate의 각 기능을 사용할 수 있습니다:

```bash
dev-mate review [대상 경로]
dev-mate testgen [대상 경로]
dev-mate analyze-error <stacktrace 파일> [대상 경로]
```
- `[대상 경로]`는 생략 시 현재 디렉토리가 기본값입니다.

---

## 필수/권장 소프트웨어

- **운영체제**: macOS, Linux, Windows(WSL 포함)
- **필수 소프트웨어**:
  - **Git** (최소 2.x 이상)
  - **Node.js** (최소 18.x 이상 권장)
  - **npm** (Node.js 설치 시 기본 포함)
  - **gemini-cli** (Google Gemini 기능 사용을 위해 필수)
- **인터넷 연결** (최초 설치, gemini-cli 및 LLM API 호출 시 필요)
- **외부 서비스**:
  - **Google Gemini API 키** (Gemini 기반 기능 사용 시 필수)

---

## Google Gemini 연동 설정

1. [Google AI Studio](https://aistudio.google.com/app/apikey) 또는 Google Cloud Console에서 Gemini API 키를 발급받으세요.
2. 환경 변수로 등록:
   ```bash
   export GEMINI_API_KEY="발급받은-API-키"
   ```
   - `.bashrc`, `.zshrc` 등에 추가하면 영구적으로 적용됩니다.
   - Windows의 경우 시스템 환경 변수에 추가하거나, PowerShell에서 `$env:GEMINI_API_KEY="..."`로 설정

---

## 설치 후 확인

설치가 완료되면 아래 명령어로 정상 설치 여부를 확인하세요.

```bash
dev-mate --version
gemini-cli --version
node --version
npm --version
git --version
echo $GEMINI_API_KEY  # (API 키가 정상적으로 설정되었는지 확인)
```

---

## pre-commit hook 예시 (gemini-cli 연동 포함)

```bash
#!/bin/sh

if [ -z "$GEMINI_API_KEY" ]; then
  echo "GEMINI_API_KEY 환경 변수가 설정되어 있지 않습니다. Google Gemini API 키를 등록하세요."
  exit 1
fi

if ! command -v gemini-cli >/dev/null 2>&1; then
  echo "gemini-cli가 설치되어 있지 않습니다. 'npm install -g gemini-cli'로 설치하세요."
  exit 1
fi

dev-mate review
dev-mate testgen
```

---

## 참고

- DevMate는 npm에 배포되지 않았으므로, 반드시 GitHub에서 직접 클론하여 사용해야 합니다.
- `npm link` 또는 $PATH 복사 방식 중 편한 방법을 사용하세요.
- gemini-cli가 PATH에 포함되어 있어야 하며, 최신 버전 사용을 권장합니다.
- API 키 노출에 주의하세요. (공개 저장소, 공유 문서 등에 올리지 않기)
- Gemini API 사용량에 따라 요금이 발생할 수 있으니, [Google Cloud Billing](https://console.cloud.google.com/billing)에서 사용량을 확인하세요.

---

추가로, 실제 저장소 주소, 실행 방식, 더 구체적인 사용 예시가 필요하다면 말씀해 주세요!
문서에 바로 반영해드릴 수 있습니다. 