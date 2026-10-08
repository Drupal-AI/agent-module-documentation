<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO Workflow Transition (vbo_workflow_transition) — agent index

**Views Bulk Operations action** applying a workflow transition to selected entities.
Version **1.0.0**. Core `^10 || ^11`.
Depends on `content_moderation`, `views`, `views_bulk_operations`, `workflows`.

**Two good properties of going through moderation** rather than writing states directly:
per-entity **transition access is still checked**, so a bulk operation cannot do what the user
could not do singly; and the transition's **side effects still run** (notifications, hooks,
revisions).

**The risk is the selection, not the action.** VBO can apply to every row matching a View,
including rows on pages nobody looked at. Filter deliberately, check the count, and prefer a View
that *shows* what will be affected.