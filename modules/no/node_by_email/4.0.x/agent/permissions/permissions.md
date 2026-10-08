<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `node_by_email.permissions.yml`. Both are admin-level; neither should be granted to untrusted roles.

| Permission | Gates |
|---|---|
| `configure node by email module` | The config form route `node_by_email.node_by_email_config_form` at `/admin/config/node_by_email/nodebyemailconfig` (IMAP credentials, sender, author, publish, cron interval). |
| `access to unseen mail list` | The `UnseenEmailForm` route `node_by_email.unseen_email_controller_unseenEmailList` at `/admin/config/node_by_email/unseenEmailList` — lists unseen mail (subject/body/date) and creates nodes from selected messages via a batch. |

Note the created nodes are authored as the configured `author_uid`, independent of who triggers ingestion
(cron, drush, or the form), so the node author is not the acting user.
