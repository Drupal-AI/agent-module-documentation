# Configure Quiz

Two layers: **global** `quiz.settings` (site-wide defaults/behaviour) and **per-quiz** base
fields (behaviour of one quiz). Plus config-entity bundles for quiz/result/feedback types.

## Global settings — `quiz.settings`

Form: `/admin/quiz/config/quiz` (route `quiz.admin.settings`, `QuizAdminForm`), permission
`administer quiz configuration`. Read/write with `drush cget/cset quiz.settings <key>`.

Shipped defaults (`config/install/quiz.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `revisioning` | `false` | Create a new revision when a quiz/question is edited |
| `durod` | `true` | Delete results on user delete |
| `default_close` | `0` | Days after today to default a quiz's close date |
| `use_passfail` | `true` | Enable pass/fail (pass-rate) behaviour |
| `remove_partial_quiz_record` | `null` | Days after which partial attempts are pruned (null = never) |
| `remove_invalid_quiz_record` | `86400` | Seconds after which invalid attempts are pruned |
| `autotitle_length` | `128` | Length of auto-generated question titles |
| `pager_start` / `pager_siblings` | `50` / `5` | When/how the question jumper pager appears |
| `time_limit_buffer` | `5` | Grace seconds at end of a timed quiz |
| `has_timer` | `false` | Show a countdown timer |
| `timer_format` | `'%-H h %M min %S sec'` | Timer display format |
| `admin_review_options_end` | (map of bools) | What the taker sees **after the quiz** (attempt, choice, correct, score, answer_feedback, question_feedback, solution, quiz_feedback, …) |
| `admin_review_options_question` | (map of bools) | Same options, shown **after each question** |
| `override_admin_feedback` | `false` | Let per-quiz feedback override the admin review options |

Pruning of expired/invalid results runs on `quiz_cron()`.

## Per-quiz behaviour — base fields on the `quiz` entity

Set on the quiz add/edit form (`entity.quiz.add_form`) or in code. Notable fields:
`randomization` (0 none / 1 random order / 2 random from this quiz / 3 categorized random),
`number_of_random_questions`, `max_score_for_random`, `pass_rate`, `summary_pass` /
`summary_default` (result text), `backwards_navigation`, `repeat_until_correct`, `quiz_date`
(daterange open/close), `takes` (allowed attempts, 0 = unlimited), `show_attempt_stats`,
`time_limit` (seconds), `allow_skipping`, `allow_resume`, `allow_jumping`, `allow_change`,
`allow_change_blank`, `build_on_last` (none/correct/all — each attempt builds on the last),
`show_passed`. `max_score` is calculated from the quiz's questions.

## Config-entity bundles

- **`quiz_type`** (`quiz.type.<id>`) — bundles of the `quiz` entity. Ships `quiz`. Manage at
  `/admin/quiz/config/structure` → Quiz types. Field UI base route `entity.quiz_type.edit_form`.
- **`quiz_question_type`** (`quiz.question.type.<id>`) — bundles of `quiz_question`; each
  question-type submodule installs one (e.g. `truefalse`, `multichoice`). See
  [../plugins/question-types.md](../plugins/question-types.md).
- **`quiz_result_type`** (`quiz.result.type.<id>`) — bundles of `quiz_result`. Ships `quiz_result`.
- **`quiz_result_answer_type`** (`quiz.result.answer.type.<id>`) — bundles of `quiz_result_answer`;
  installed per question type.
- **`quiz_feedback_type`** (`quiz.feedback.type.<id>`) — Rules-powered conditional feedback.
  Ships `end` and `question`. Edit conditions at
  `admin/quiz/feedback/type/{id}/conditions` (`QuizFeedbackConditionsForm`, a Rules UI).
  `hook_quiz_feedback_options()` (see [../hooks/hooks.md](../hooks/hooks.md)) adds review options.

## Quick reads

```bash
drush cget quiz.settings has_timer
drush cget quiz.settings admin_review_options_end
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("quiz_question_type")->loadMultiple() as $id=>$e){print "$id => ".$e->label()."\n";}'
```
