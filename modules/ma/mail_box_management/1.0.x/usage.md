<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Box Management provides management for inbox, outbox and other mailbox functions.

---

Mail Box Management provides **inbox/outbox mailbox management** in Drupal — storing and managing sent/
received messages (an in-site mailbox), with related mailbox functions. It provides its own permissions, in
the Contrib package.

Use it for in-site mailbox handling. It is a communications/administration feature. Security note: mailbox
contents are **private correspondence/PII**, so gate the mailbox permissions to the appropriate users (a user
should only see their own mailbox unless intentionally shared), and if it connects to an external mail server
(IMAP/SMTP) handle those **credentials** as secrets over encrypted connections. It has no broad access-control
role beyond its permissions. Configure the mailbox.

---

- Manage inbox/outbox mailboxes.
- Store sent/received messages.
- Provide mailbox functions.
- Provide its own permissions.
- Handle in-site mail.
- Manage correspondence.
- TREAT mailbox contents as private/PII.
- Gate mailbox access appropriately.
- Handle IMAP/SMTP credentials as secrets.
- Use encrypted mail connections.
- Have no broad access-control role beyond permissions.
- Configure the mailbox.
- Handle mailboxes.
- Manage messages.
- Configure mail.
- Handle the mailbox.
- Store messages.
- Manage mail.
- Restrict access.
- Provide mailbox management.
