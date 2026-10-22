#!/usr/bin/env bash
# 새 문제 폴더 만들기
# 사용법: ./new.sh <분류> <문제 제목>
# 예시  : ./new.sh 스택 점진적과부하
set -e
cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
  echo "사용법: ./new.sh <분류> <문제 제목>"
  echo "예시  : ./new.sh 스택 점진적과부하"
  exit 1
fi

category="$1"; shift
title="$*"
# 패키지 이름에 쓸 수 없는 문자(공백, 괄호, 기호)는 _ 로 바꿈
safe=$(printf '%s' "$title" | sed -E 's/[^[:alnum:]_가-힣]+/_/g; s/^_+|_+$//g')

last=$(find src -mindepth 2 -maxdepth 2 -type d -name '문제[0-9][0-9][0-9][0-9]_*' 2>/dev/null \
       | sed -E 's#.*/문제([0-9]{4})_.*#\1#' | sort -n | tail -1)
no=$(printf '%04d' $((10#${last:-0} + 1)))

dir="src/$category/문제${no}_$safe"
pkg="$category.문제${no}_$safe"
today=$(date +%Y-%m-%d)

mkdir -p "$dir"
for f in Solution.java SolutionTest.java README.md; do
  sed -e "s|{{PACKAGE}}|$pkg|g" -e "s|{{TITLE}}|$title|g" -e "s|{{NO}}|$no|g" \
      -e "s|{{CATEGORY}}|$category|g" -e "s|{{DATE}}|$today|g" \
      "templates/$f.tpl" > "$dir/$f"
done

echo "| $no | [$title]($dir/README.md) | $category | $today | ⬜ |" >> 문제목록.md

echo "✅ 생성 완료: $dir"
echo "   1) README.md 에 문제 붙여넣기"
echo "   2) Solution.java 풀기"
echo "   3) SolutionTest.java 에 입출력 예 적기"
echo "   4) ./run.sh $((10#$no)) 로 채점"
