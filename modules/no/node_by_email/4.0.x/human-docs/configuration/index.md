# Configuration

Node by Email is configured from a single screen at
**Configuration → System → Node by Email**
(`/admin/config/node_by_email/nodebyemailconfig`). Saving the form makes the module
attempt an IMAP connection with the credentials you entered: on success the top of
the page reads *"IMAP connection is made successfully."*, and a warning means the
connection failed and nothing will be ingested until it is fixed.

## Permissions

Two admin-level permissions gate the module's pages. Grant them only to trusted
roles — neither should go to untrusted users.

| Permission | Controls |
|------------|----------|
| **configure node by email module** | The configuration screen above, which holds the IMAP credentials, sender, author, publish state, and cron interval. |
| **access to unseen mail list** | The **Unseen Emails** page (`/admin/config/node_by_email/unseenEmailList`) that lists unread mail and creates nodes from selected messages via a batch. |

## The IMAP connection

- **IMAP connection string** — the mailbox string PHP uses to open the connection.
  The shipped default is a Gmail-style `{imap.gmail.com:993/imap/ssl}` (keep the
  braces). For other providers substitute the host, e.g.
  `{imap.mail.yahoo.com:993/imap/ssl}` or `{imap.aol.com:993/imap/ssl}`.
- **Email username** — the login for the IMAP account, i.e. the mailbox that
  *receives* the mail.
- **Password** — the IMAP account password. Where your provider offers an app-specific password, use that rather than
  your main account password.

## Which emails become content

- **From email address** — only unread messages whose **`From`** header matches this
  address are ingested (the module runs an IMAP search for `FROM "<address>" UNSEEN`).

## Content type settings

- **Content type(s)** — tick which node type(s) incoming mail should create. The
  type must have a **title** and a **body** field, since the subject fills the title
  and the email body fills the body.

## Publishing options

- **Author** — the user account set as the author of every node created from email,
  regardless of who or what triggered ingestion (cron, Drush, or the form). The
  shipped default is user 1.
- **Published / Unpublished** — whether new nodes are published immediately or held
  as drafts. The shipped default is **unpublished** (`0`), so a human can review
  each item first.
- **Cron interval (seconds)** — the minimum number of seconds between automatic
  ingestion runs on Drupal cron (the shipped default is `3600`, i.e. hourly). Lower
  it to check the mailbox more often, raise it to be gentler on the mail server.

## Save

Click **Save configuration** and watch for *"IMAP connection is made
successfully."* Then send a test email from your configured sender address and
either wait for cron, run `drush nbe-gn`, or use the **Unseen Emails** page to
confirm a node is created as expected. After a message is processed it is marked
seen and flagged so it will not be ingested again.
