<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Feedback (admin_feedback) — agent index

"Was this helpful? Yes/No" widget + optional comment, with per-node scoring, Views dashboards, and
CSV export. Stores data in two custom tables (`admin_feedback`, `admin_feedback_score`), not
entities. Depends on `views`, `user`, `node`. Configure at `/admin/feedback/settings`. No Drush.
Version 2.10.x, core `^9.3 || ^10 || ^11`, license GPL-2.0-or-later.

- **Settings form keys, config object, block placement, dashboards** →
  [configure/settings.md](configure/settings.md)
- **Permissions and what each gates (incl. default anon/auth grant)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Vote/comment endpoints, HMAC tokens, flood control, DB tables, CSV export, `VoteEvent`** →
  [api/voting.md](api/voting.md)

## Key facts

- Block plugin `admin_feedback_block` (`src/Plugin/Block/AdminFeedbackBlock.php`,
  `blockAccess` = `give feedback`); only builds on routes with a `node` parameter.
- Config object `admin_feedback.settings` (schema in `config/schema/admin_feedback.schema.yml`),
  configure route `admin_feedback.settings_form` (`AdminFeedbackSettingsForm`).
- Routes: `/feedback_vote` (vote receiver), `/ajax/feedback_vote` (comment form),
  `/feedback_inspected_check` / `_uncheck`, `/export_feedback`, `/admin/feedback/download`,
  `/admin/content/feedback/{id}/delete`, `/admin/content/feedback/delete-all/{id}`,
  `/admin/feedback/settings`. Feedback dashboards are Views (`view.feedback.nodes_list` at
  `/admin/content/feedback`, `view.feedback.nodes_score` at `/node/{nid}/feedback`).
- `VoteEvent` (`event_subscriber.vote`) dispatched per vote; `RouteSubscriber` marks the two Views
  displays as admin routes; `hook_node_delete` / `hook_node_translation_delete` cascade cleanup.
- No submodules, no plugin types, no Drush commands; provides permissions and config schema.
