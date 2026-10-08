# Quiz permissions

Defined in `quiz.permissions.yml`. Quiz entities also use **bundle-level** permission
granularity (`permission_granularity = "bundle"`), so core generates per-quiz-type and
per-question-type CRUD permissions (e.g. "create quiz content", "edit any <type> quiz") in
addition to these module-defined ones.

| Permission | Gates |
|---|---|
| `administer quiz configuration` | The global `quiz.settings` form and overall behaviour. |
| `administer quiz result types` | Managing quiz result types and their fields. |
| `access quiz` | Take (attempt) all available quizzes. Quiz adds a **`take`** entity operation. |
| `view results for own quiz` | Quiz authors can view results for quizzes they created. |
| `delete results for own quiz` | Quiz authors can delete results for their own quizzes. |
| `score own quiz` | Quiz authors can update/score results for their own quizzes. |
| `view any quiz question correct response` | See the correct answer when a question is viewed outside a quiz. |
| `edit question titles` | Set question titles manually (otherwise auto-generated from the text). |
| `override quiz revisioning` | Edit quizzes/questions without creating revisions. WARNING: can break reporting. |

Notes:
- Many admin routes (`/admin/quiz…`) require the generated `administer quiz` permission.
- `take` access is resolved through `quiz_quiz_access()` and `hook_quiz_access()` (see
  [../hooks/hooks.md](../hooks/hooks.md)), combined with `access quiz`.
