#!/bin/bash

# 替换为你的仓库名称
REPO="OWNER/REPO"

# 获取所有标签列表并逐行处理
gh label list --repo "$REPO" --json name -q '.[].name' | while IFS= read -r label; do
  echo "正在删除标签: $label"
  # 删除标签
  gh label delete "$label" --repo "$REPO" --confirm || echo "删除失败: $label"
done

echo "所有标签已删除！"
