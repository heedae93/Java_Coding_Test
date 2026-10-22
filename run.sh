#!/usr/bin/env bash
# 문제 채점 실행
# 사용법: ./run.sh <문제 번호>      예) ./run.sh 12
#         ./run.sh <문제 폴더 경로>  예) ./run.sh src/스택/문제0012_점진적과부하
set -e
cd "$(dirname "$0")"

if [ $# -lt 1 ]; then
  echo "사용법: ./run.sh <문제 번호 또는 폴더 경로>"
  exit 1
fi

if [[ "$1" =~ ^[0-9]+$ ]]; then
  no=$(printf '%04d' $((10#$1)))
  dir=$(find src -mindepth 2 -maxdepth 2 -type d -name "문제${no}_*" | head -1)
  if [ -z "$dir" ]; then echo "❌ ${no}번 문제 폴더를 찾을 수 없습니다."; exit 1; fi
else
  dir="${1%/}"
fi

rel="${dir#src/}"
pkg="${rel//\//.}"

rm -rf out && mkdir -p out
javac -encoding UTF-8 -d out src/judge/Judge.java "$dir"/*.java
echo "▶ $rel"
echo
java -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 -cp out "$pkg.SolutionTest"
