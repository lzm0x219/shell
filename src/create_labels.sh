#!/bin/bash

# 替换为你的仓库名称
REPO="OWNER/REPO"

# 定义完整标签数组
LABELS=(
  "bug|#d73a4a|项目中的错误或问题"
  "feature|#a2eeef|请求新功能或特性"
  "enhancement|#84b6eb|功能改进或增强"
  "documentation|#0075ca|与文档相关的任务或问题"
  "refactor|#fbca04|代码重构，无功能性变化"
  "test|#c5def5|与测试相关的任务"
  "chore|#fef2c0|日常事务或维护工作"
  "question|#d876e3|开发者提出的问题或疑问"
  "dependencies|#ededed|与项目依赖相关的工作"

  # 优先级（Priority）
  "priority: high|#b60205|高优先级，需要立即处理"
  "priority: medium|#f9d0c4|中等优先级"
  "priority: low|#d4c5f9|低优先级，不紧急"

  # 状态（Status）
  "status: in progress|#0e8a16|任务正在进行中"
  "status: blocked|#e11d21|任务被阻塞，无法继续"
  "status: review|#fbca04|任务处于代码审查阶段"
  "status: done|#1d76db|任务已完成"
  "status: duplicate|#cfd3d7|与现有问题重复"
  "status: wontfix|#ffffff|问题不会被修复"
  "status: invalid|#e4e669|无效的问题或请求"

  # 难度（Difficulty）
  "difficulty: easy|#94d3a2|适合初学者的简单任务"
  "difficulty: medium|#f9d0c4|中等难度任务"
  "difficulty: hard|#e99695|高复杂度任务"

  # 影响范围（Impact）
  "impact: critical|#b60205|对项目有重大影响"
  "impact: major|#d93f0b|对项目有较大影响"
  "impact: minor|#0e8a16|对项目影响较小"

  # 社区（Community）
  "good first issue|#7057ff|适合新手的任务"
  "help wanted|#008672|需要社区帮助解决的问题"
  "hacktoberfest|#ff751a|适合 Hacktoberfest 活动的任务"

  # 范围（Scope）
  "scope: frontend|#1d76db|与前端相关的任务"
  "scope: backend|#d4c5f9|与后端相关的任务"
  "scope: api|#8dd3c7|与 API 相关的任务"
  "scope: database|#fdb462|与数据库相关的任务"
  "scope: devops|#80b1d3|与 DevOps 或部署相关的任务"

  # 时间（Timeline）
  "timeline: urgent|#e11d21|需要立即处理的任务"
  "timeline: this week|#d93f0b|本周需要完成的任务"
  "timeline: next week|#fbca04|下周需要完成的任务"
  "timeline: future|#cfd3d7|未来计划处理的任务"

  # 安全（Security）
  "security|#ff0000|与安全相关的任务或问题"
  "vulnerability|#d73a4a|安全漏洞问题"

  # 其他（Others）
  "breaking change|#b60205|引入了重大更改"
  "performance|#c2e0c6|与性能优化相关的任务"
  "design|#ffa07a|与设计相关的任务"
  "accessibility|#a2eeef|与无障碍功能相关的任务"
  "localization|#d4c5f9|与国际化或本地化相关的任务"
)

# 循环创建标签
for LABEL in "${LABELS[@]}"; do
  # 使用自定义分隔符 | 分割标签的名称、颜色和描述
  IFS="|" read -r NAME COLOR DESCRIPTION <<< "$LABEL"

  # 检查标签名称是否符合 GitHub 规则
  if [[ ${#NAME} -gt 50 ]]; then
    echo "标签名称过长，跳过: $NAME"
    continue
  fi

  # 检查颜色是否是有效的 6 位十六进制代码
  if ! [[ "$COLOR" =~ ^#[a-fA-F0-9]{6}$ ]]; then
    echo "标签颜色格式错误，跳过: $NAME (颜色: $COLOR)"
    continue
  fi

  # 检查描述是否过长
  if [[ ${#DESCRIPTION} -gt 1000 ]]; then
    echo "标签描述过长，跳过: $NAME"
    continue
  fi

  # 检查标签是否已存在
  if gh label list --repo "$REPO" --json name -q '.[].name' | grep -q "^$NAME$"; then
    echo "标签已存在，跳过: $NAME"
    continue
  fi

  # 创建标签
  echo "正在创建标签: $NAME (颜色: $COLOR, 描述: $DESCRIPTION)"
  gh label create "$NAME" \
    --force \
    --color "$COLOR" \
    --description "$DESCRIPTION" \
    --repo "$REPO" || echo "创建标签失败: $NAME"

  # 延迟 1 秒，避免触发 API 限制
  sleep 1
done

echo "所有标签已处理完成！"
