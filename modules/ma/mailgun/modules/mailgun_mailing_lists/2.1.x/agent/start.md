<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailgun Mailing Lists — agent index

Submodule of **Mailgun**. Manages Mailgun mailing lists from Drupal and provides a placeable
**`mailing_list_subscribe`** block for visitor email signups. List/member operations call the
Mailgun API (needs the parent module's API key); block placement is local config.

- **Admin list management page + placing/configuring the subscribe block** →
  [configure/mailing-lists.md](configure/mailing-lists.md)
- **The `mailing_list_subscribe` block plugin (settings, subscribe form)** →
  [plugins/subscribe-block.md](plugins/subscribe-block.md)

Key facts:
- Configure route `mailgun_mailing_lists.admin_settings_form` =
  `/admin/config/services/mailgun/settings/mailing-lists` (tab under Mailgun settings).
  Members route: `mailgun_mailing_lists.list` = `.../mailing-lists/{list_address}`.
- Permission: reuses the parent `administer mailgun` (defines none of its own).
- Block plugin id `mailing_list_subscribe`; block setting `mailing_list` = the list address it
  subscribes to.
- Depends on `mailgun`. Parent docs: `modules/mailgun/2.1.x/`.
