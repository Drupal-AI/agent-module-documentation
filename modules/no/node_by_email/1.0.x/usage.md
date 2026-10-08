<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node by Email creates nodes by sending email.

---

Node by Email **creates nodes from incoming email** — it connects to a configured IMAP mailbox, and turns
matching unseen messages into nodes (subject → title, email body → body), authored as a configured user. It
provides its own permissions and a Drush command to run ingestion.

Use it to let content be posted by email. Only unseen messages whose `From` header matches a configured
sender address are ingested (`imap_search(..., 'FROM "<configured>" UNSEEN')`). Configure the IMAP account
and node mapping.

---

- Create nodes from IMAP email.
- Map subject/body to a node.
- Author as a configured user.
- Provide its own permissions and a Drush command.
- Configure the IMAP account.
- Handle email-to-node.
- Ingest email.
- Configure the mapping.
- Post by email.
- Handle the ingestion.
- Create content by email.
- Secure the ingestion.
- Provide email posting.
