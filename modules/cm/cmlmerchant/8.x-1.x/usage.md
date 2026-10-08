<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
cmlmerchant builds Google Merchant, Yandex and VK product feeds as static XML/YML files and serves them at fixed feed paths.

---

The module reads products from a `catalog` taxonomy (it depends on the `catalog` and `cmlstarter` projects) and, via `YmlService`, renders the feed XML to files under `sites/default/files/YML/` (e.g. `cmlmerchant_google.xml`, `cmlmerchant_yandex.xml`, plus VK variants for realty/transport/services/hotel). Regeneration is driven by cron (`src/Hook/Cron.php`) and by a Drush command (`CmlmerchantCommands`); the settings form at `/admin/config/cmlmerchant/settings` controls what is included.

Feed routes (`/cmlmerchant/google-feed.xml`, `/cmlmerchant/yandex-feed.xml`, and the `vk-*` variants) are gated by the `access content` permission and simply stream the pre-generated file back with a `text/xml` content type; they perform no mutation. The `/cmlmerchant/debug` route is restricted to `administer site configuration`. Setup is: install the `catalog`/`cmlstarter` stack, map your Google category field, then let cron (or `drush`) write the feeds.

---

- Install the module together with its `catalog` and `cmlstarter` dependencies.
- Open `/admin/config/cmlmerchant/settings` to configure feed generation.
- Expose the Google product feed at `/cmlmerchant/google-feed.xml`.
- Expose the Yandex feed at `/cmlmerchant/yandex-feed.xml`.
- Serve VK realty feed at `/cmlmerchant/vk-realty-feed.xml`.
- Serve VK transport feed at `/cmlmerchant/vk-transport-feed.xml`.
- Serve VK services feed at `/cmlmerchant/vk-services-feed.xml`.
- Serve VK hotel feed at `/cmlmerchant/vk-hotel-feed.xml`.
- Serve VK Google/Yandex feed variants for social commerce.
- Regenerate all feed files on cron runs automatically.
- Trigger feed regeneration manually with the module's Drush command.
- Inspect feed building via the admin-only `/cmlmerchant/debug` route.
- Store the generated feeds under `sites/default/files/YML/`.
- Populate the `field_catalog_google_id` term field for Google category mapping.
- Submit the Google feed URL to Google Merchant Center.
- Submit the Yandex feed URL to Yandex.Webmaster.
- Grant `access content` so crawlers can fetch feeds.
- Restrict debug output to site administrators.
- Schedule frequent cron to keep product data fresh in feeds.
- Point marketplace integrations at the stable feed URLs.
- Combine with catalog taxonomy terms to segment feed contents.
