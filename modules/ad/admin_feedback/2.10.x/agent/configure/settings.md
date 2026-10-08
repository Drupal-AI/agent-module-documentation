<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Admin Feedback

## Settings form

Route `admin_feedback.settings_form` → `/admin/feedback/settings`, permission
`administer admin feedback` (`AdminFeedbackSettingsForm`). Linked under
*Configuration → System* (`admin_feedback.links.menu.yml`) with a *Settings* local task. Writes the
config object `admin_feedback.settings` (schema `config/schema/admin_feedback.schema.yml`,
config-translatable via `admin_feedback.config_translation.yml`).

![Admin Feedback settings form](../../../../../../../screenshots/admin_feedback/2.10.x/settings-form.png)

## Config keys (`admin_feedback.settings`, defaults from `config/install`)

| Key | Default | Meaning |
|---|---|---|
| `initial_question` | `Was this helpful?` | Heading shown in the block. |
| `yes_button` / `no_button` | `Yes` / `No` | Button labels. |
| `yes_response` / `no_response` | thank-you strings | Shown after Yes/No (escaped into `drupalSettings`). |
| `feedback_prompt_on_yes` | `true` | Show the comment prompt after a Yes vote. |
| `feedback_prompt_on_no` | `true` | Show the comment prompt after a No vote. |
| `feedback_prompt` | `If you'd like, give us more feedback.` | Comment-prompt text. |
| `submit_text` | `Send feedback` | Comment submit button label. |
| `final_response` | `Thank you!` | Shown after a comment is saved. |
| `feedback_enable_predefined_answers` | `false` | `true` = radio list of preset answers; `false` = free textarea. |
| `feedback_predefined_answers` | 4 sample strings | The radio options when the above is on. |
| `custom_text_response_on_no` | (unset) | `{value, format}` rich text; run through `check_markup()` then exposed as `drupalSettings.admin_feedback.custom_text_response_on_no` (shown only when `feedback_prompt_on_no` is off). |
| `feedback_allow_cancel` | `{active: false, timeout: 3}` | Optional undo window after submit. |
| `feedback_batch_size` | `5000` | Rows per batch during CSV export. |
| `feedback_flood` | `{limit: 20, window: 3600}` | Per-IP vote flood limit / window (seconds). |

Set values with Drush, e.g.:

```bash
ddev drush config:set admin_feedback.settings initial_question 'Was this page useful?' -y
ddev drush config:set admin_feedback.settings feedback_flood.limit 10 -y
```

## Place the block

Enable the **Admin Feedback Block** (`admin_feedback_block`) via Block layout. It only builds on
routes with a `node` parameter (node canonical pages) and its access is `give feedback`. It attaches
`admin_feedback/admin_feedback_block` (JS) + `admin_feedback/admin_feedback_css` and a
`drupalSettings` payload. Cache contexts: `user.permissions`, `url.path`; cache tag
`config:admin_feedback.settings`.

## Dashboards (Views, provided by the module)

- `/admin/content/feedback` — `view.feedback.nodes_list` (menu: *Content → Feedback Dashboard*),
  permission `view admin feedback dashboard`. One row per node/language with title, score %,
  positive/negative/total counts, and an edit link.
- `/node/{nid}/feedback` — `view.feedback.nodes_score` detail view,
  permission `view admin feedback detail view`. Per-feedback rows with the message, an inspected
  checkbox, and a per-row delete link.

![Admin Feedback dashboard](../../../../../../../screenshots/admin_feedback/2.10.x/dashboard.png)

Both views are forced to the admin theme by `RouteSubscriber::alterRoutes()`. The
`views.view.feedback` config is installed by the module and deleted on uninstall
(`admin_feedback_uninstall()`).
