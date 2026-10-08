# Configuration

Node by Email is configured from a single screen at
**Configuration → System → Node by Email**
(`/admin/config/node_by_email/nodebyemailconfig`). You need the module's
*configure node by email module* permission (an administrator role by default) to
open it. Do not grant that permission to untrusted users — it exposes the mailbox
credentials.

When you save the form, the module tries to connect to your mailbox with the
credentials you entered. On success the top of the page shows *"IMAP connection is
made successfully."*; a warning means the connection failed and no mail will be
ingested until it is fixed.

## The IMAP connection

- **IMAP connection string** — the mailbox string PHP uses to open the connection,
  for example a Gmail-style `{imap.gmail.com:993/imap/ssl}` (keep the braces).
  Substitute your own host for other providers.
- **Email username** — the login for the IMAP account, i.e. the mailbox that
  *receives* the incoming mail.
- **Password** — the IMAP account password. Where your provider offers an app-specific password, prefer
  that over your main account password.

## Which emails become content

- **From email address** — only unread messages whose **`From`** header matches
  this address are picked up.

## Content type settings

- **Content type** — choose which node type(s) the incoming mail should create.
  Remember the type must have a **title** and a **body** field, because the email
  subject fills the title and the email body fills the body.

## Publishing options

- **Author** — the user account set as the author of every node created from email.
  This is independent of who triggers ingestion.
- **Published / Unpublished** — whether new nodes are published immediately or held
  as unpublished drafts. Keep this unpublished if you want a human to review each
  item before it goes live.
- **Cron interval (seconds)** — the minimum number of seconds between automatic
  ingestion runs on Drupal cron. A smaller number checks the mailbox more often; a
  larger number is gentler on the mail server.

## Creating nodes from the unseen-mail list

Besides cron, the module offers an admin page that lists the mailbox's unseen
messages (subject, body, date). You can select messages and create nodes from them
in a batch — useful for reviewing before publishing. That page is gated by its own
permission, so grant it only to trusted editors. After a message is processed it is
marked as seen so it is not picked up again.

## Save

Click **Save configuration**. Watch for the *"IMAP connection is made
successfully."* confirmation, then send a test email from your configured sender
address and either wait for cron or use the unseen-mail list to confirm a node is
created as expected.
