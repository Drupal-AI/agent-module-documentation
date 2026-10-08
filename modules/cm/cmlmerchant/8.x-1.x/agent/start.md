<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cmlmerchant (cmlmerchant) — agent index
**Generates static Google Merchant / Yandex / VK product feed files from a `catalog` taxonomy and serves them at fixed URLs.**

- **version:** 8.x-1.x
- **core:** ^9 || ^10 || ^11
- **depends on:** catalog, cmlstarter
- **routes:** `/cmlmerchant/{google,yandex}-feed.xml` + `vk-*` variants (`_permission: access content`, read-only file streaming); `/cmlmerchant/debug` (`administer site configuration`); settings `/admin/config/cmlmerchant/settings` (`access administration pages`).
- **service:** `cmlmerchant.yml` (`YmlService`) renders feeds to `sites/default/files/YML/`; cron hook + Drush command regenerate them.
- **Security:** feed routes are read-only and only stream pre-generated files; `access content` is appropriate for public product feeds. Admin/debug route permission-gated. No mutating anonymous endpoints.

See [configure/feeds.md](configure/feeds.md)
