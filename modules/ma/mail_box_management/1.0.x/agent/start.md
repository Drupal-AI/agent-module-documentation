<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail Box Management — agent index

Provides **inbox/outbox and mailbox management** in Drupal (store/manage messages). Provides permissions.
Version **1.0.1**. Core `^9.5||^10||^11`.

Communications/admin — mailbox contents are **private/PII**: gate access appropriately (own mailbox only);
handle any IMAP/SMTP **credentials** as secrets over encrypted connections. No broad access role beyond
permissions.
