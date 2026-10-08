<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure

Config object: **`node_by_email.nodebyemailconfig`**. UI route: `node_by_email.node_by_email_config_form`
at `/admin/config/node_by_email/nodebyemailconfig` (permission: *configure node by email module*). Menu link
under *Configuration → System*. There is **no config schema** shipped (`provides_config_schema: false`).

## Keys (with shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `imap_connection_string` | `{imap.gmail.com:993/imap/ssl}` | PHP `imap_open` mailbox string (keep the braces). Yahoo: `{imap.mail.yahoo.com:993/imap/ssl}`, AOL: `{imap.aol.com:993/imap/ssl}`. |
| `email_username` | `RRR@example.com` | IMAP account login (the mailbox that receives mail). |
| `imap_password` | *(unset)* | IMAP account password. |
| `from_email` | `FFF@example.com` | Only unseen mail whose `From` matches this address is ingested. |
| `node_types` | `[]` | Content types to create; stored as `{type_id: type_id}` (form uses checkboxes, saved via `array_filter`). |
| `author_uid` | `1` | User id set as the node author. |
| `publishing_option` | `0` | `1` = create Published, `0`/empty = Unpublished. |
| `cron_interval` | `3600` | Minimum seconds between cron ingestion runs. |
| `imap_connected` | *(set on save)* | `1` if the last save connected successfully, else `0`; gates the Unseen Emails form. |

## Set via drush (example)

```
drush cset node_by_email.nodebyemailconfig from_email 'poster@example.com' -y
drush cset node_by_email.nodebyemailconfig author_uid 42 -y
drush cset node_by_email.nodebyemailconfig publishing_option 0 -y
drush cset node_by_email.nodebyemailconfig cron_interval 900 -y
# node_types must be a map, e.g. {article: article}:
drush cset node_by_email.nodebyemailconfig node_types.article article -y
```

Saving the form calls `IMAPService::connection()` with the entered credentials and shows
"IMAP connection is made successfully." on success or a warning otherwise, and records `imap_connected`.
