<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhpMail Alter — agent index

Alters Drupal's **mail handling (headers/parameters)** via config (envelope-from, headers for
deliverability). Config at `phpmail_alter.settings`. Version **8.x-1.21**. Core `^9||^10||^11`.

Operates on outbound email — review configured changes (mis-set From/envelope headers hurt deliverability
or misrepresent the sender). No content-access role.
