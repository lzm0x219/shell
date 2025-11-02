#!/bin/bash

# 替换为你的仓库名称
REPO="OWNER/REPO"

# 定义标签数组
LABELS=(
  # 类型（Type）
  "bug:#d73a4a:A bug or issue in the project"
  "feature:#a2eeef:Request for a new feature or functionality"
  "enhancement:#84b6eb:Improvements or feature enhancements"
  "documentation:#0075ca:Documentation-related tasks or issues"
  "refactor:#fbca04:Code refactoring without functional changes"
  "test:#c5def5:Tasks related to testing"
  "chore:#fef2c0:Routine tasks or maintenance work"
  "question:#d876e3:Questions or developer inquiries"

  # 优先级（Priority）
  "priority: high:#b60205:High priority, requires immediate attention"
  "priority: medium:#f9d0c4:Medium priority"
  "priority: low:#d4c5f9:Low priority, not urgent"

  # 状态（Status）
  "status: in progress:#0e8a16:Task is currently in progress"
  "status: blocked:#e11d21:Task is blocked and cannot proceed"
  "status: review:#fbca04:Task is under code review"
  "status: done:#1d76db:Task is completed"
  "status: duplicate:#cfd3d7:Duplicate of an existing issue"
  "status: wontfix:#ffffff:Issue will not be fixed"
  "status: invalid:#e4e669:Invalid issue or request"

  # 难度（Difficulty）
  "difficulty: easy:#94d3a2:Simple tasks suitable for beginners"
  "difficulty: medium:#f9d0c4:Moderate difficulty tasks"
  "difficulty: hard:#e99695:Tasks with high complexity"

  # 影响范围（Impact）
  "impact: critical:#b60205:Critical impact on the project"
  "impact: major:#d93f0b:Major impact on the project"
  "impact: minor:#0e8a16:Minor impact on the project"

  # 社区（Community）
  "good first issue:#7057ff:Good tasks for newcomers"
  "help wanted:#008672:Tasks needing community help"
  "hacktoberfest:#ff751a:Tasks for Hacktoberfest participants"

  # 范围（Scope）
  "scope: frontend:#1d76db:Tasks related to the frontend"
  "scope: backend:#d4c5f9:Tasks related to the backend"
  "scope: api:#8dd3c7:Tasks related to APIs"
  "scope: database:#fdb462:Tasks related to the database"
  "scope: devops:#80b1d3:Tasks related to DevOps or deployment"

  # 时间（Timeline）
  "timeline: urgent:#e11d21:Tasks requiring immediate attention"
  "timeline: this week:#d93f0b:Tasks to complete this week"
  "timeline: next week:#fbca04:Tasks planned for next week"
  "timeline: future:#cfd3d7:Tasks planned for the future"

  # 安全（Security）
  "security:#ff0000:Security-related tasks or issues"
  "vulnerability:#d73a4a:Security vulnerabilities"

  # 其他（Others）
  "breaking change:#b60205:Introduces breaking changes"
  "performance:#c2e0c6:Tasks related to performance optimization"
  "design:#ffa07a:Tasks related to design"
  "accessibility:#a2eeef:Tasks related to accessibility"
  "localization:#d4c5f9:Tasks related to internationalization or localization"
)

# 循环创建标签
for LABEL in "${LABELS[@]}"; do
  # 分割标签的名称、颜色和描述
  IFS=":" read -r NAME COLOR DESCRIPTION <<< "$LABEL"

  # 使用 GitHub CLI 创建标签
  echo "Creating label: $NAME (Color: $COLOR, Description: $DESCRIPTION)"
  gh label create "$NAME" \
    --color "$COLOR" \
    --description "$DESCRIPTION" \
    --repo "$REPO" || echo "Failed to create label: $NAME (It might already exist)"
done

echo "All labels have been processed!"
