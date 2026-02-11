#!/usr/bin/env bash
set -euo pipefail

echo "提交笔记内容..."

comment="${1-}"

script_path="$(cd "$(dirname "$0")" && pwd)"
root_path="$(cd "$(dirname "$script_path")" && pwd)"
datetime="$(date +"%Y-%m-%d %H:%M:%S")"

cd "$root_path"

#php "${script_path}/generate.php"

git add --all

# 暂存区无变更则退出
git diff --cached --quiet && { echo "没有变更，无需提交"; exit 0; }

if [ -z "$comment" ]; then
  comment="新增/修改笔记内容: ${datetime}"
fi

git commit -m "$comment"

current_branch="$(git rev-parse --abbrev-ref HEAD)"
git push -u origin "$current_branch"