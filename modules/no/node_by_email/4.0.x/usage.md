<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node by Email creates Drupal nodes from incoming email fetched over IMAP.

---

Node by Email **connects to a configured IMAP mailbox and turns unseen messages into nodes** — the email subject becomes the node title, the email body becomes the node body, authored as a configured user. Ingestion runs three ways: automatically on `hook_cron` (throttled by a configurable interval in seconds), on demand via the Drush command `node_by_email:generate_node` (alias `nbe-gn`), and manually through an admin "Unseen Emails" form that lists unseen mail in a tableselect and processes the selected rows through the Batch API. All mail selection is done with `imap_search(..., 'FROM "<configured>" UNSEEN')`, so only unread messages whose `From` matches the configured sender are picked up, then flagged `\Seen \Flagged` after processing. It requires the PHP **IMAP extension** (`ext-imap`) at runtime and Drush `^11`. Configuration lives at `/admin/config/node_by_email/nodebyemailconfig` (route `node_by_email.node_by_email_config_form`): IMAP connection string, account username, password, the sender address, target content type(s), author user, published/unpublished, and cron interval.

The shipped default `publishing_option` is `0` (unpublished).

---

- Create Drupal nodes from IMAP email (subject -> title, body -> body).
- Post content from a phone/mobile mail client instead of the Drupal UI.
- Author incoming nodes as a configured user.
- Restrict ingestion to messages from one configured sender address.
- Ingest only unseen (unread) messages, then mark them Seen + Flagged.
- Run ingestion automatically on cron at a configurable interval.
- Run ingestion on demand from the CLI with `drush node_by_email:generate_node`.
- Manually review unseen mail and create nodes from selected messages (batch form).
- Map incoming mail to one or more selected content types.
- Choose whether new nodes are published or unpublished on creation.
- Connect to Gmail / Yahoo / AOL or any IMAP-over-SSL mailbox.
- Verify the IMAP connection from the config form (success/warning message).
- Gate the config UI behind the "configure node by email module" permission.
- Gate the unseen-mail list behind the "access to unseen mail list" permission.
- Require the PHP IMAP extension (`ext-imap`) on the server.
