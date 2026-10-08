# Admin Feedback — agent index

"Was this helpful? Yes/No" widget + optional comment, with per-node scoring, Views dashboards, and
CSV export. Stores data in two custom tables (`admin_feedback`, `admin_feedback_score`), not
entities. Depends on `views`, `user`, `node`. Configure at `/admin/feedback/settings`. No Drush.

- **Settings form keys, config object, block placement, dashboards** →
  [configure/settings.md](configure/settings.md)
- **Permissions and what each gates (incl. default anon/auth grant)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Vote/comment endpoints, HMAC tokens, flood control, DB tables, CSV export, `VoteEvent`** →
  [api/voting.md](api/voting.md)

Key facts:
- Block plugin `admin_feedback_block` (blockAccess = `give feedback`); only renders on node routes.
- Config object `admin_feedback.settings` (schema in `config/schema`), configure route
  `admin_feedback.settings_form`.
- Routes: `/feedback_vote` (vote receiver), `/ajax/feedback_vote` (comment form), plus
  inspect/export/delete admin routes; feedback dashboards are Views (`view.feedback.*`).
- Hardened: per-node HMAC vote token, `yes`/`no`-only + existing-node checks, per-IP flood limit
  (`feedback_flood`, default 20/3600s), one-comment-per-row via signed feedback-id token.
