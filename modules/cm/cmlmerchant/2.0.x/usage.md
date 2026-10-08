<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
cmlmerchant builds Google Merchant, Yandex and VK product feeds as static XML/YML files from Drupal Commerce products and serves them at fixed feed URLs.

---

The module reads published `commerce_product` entities organised under a `catalog` taxonomy vocabulary (it requires the `catalog` and `cmlstarter` projects) and, via the `cmlmerchant.yml` service (`YmlService`), renders feed XML to files under `sites/default/files/YML/` — `cmlmerchant_google.xml`, `cmlmerchant_yandex.xml`, and VK variants for Google/Yandex plus realty, transport, services and hotel. Regeneration is driven by `hook_cron` (`src/Hook/Cron.php`) and by the `drush cmlmerchant:feeds` (alias `feeds`) command; the settings form at `/admin/config/cmlmerchant/settings` sets the shop/company name, a site-URL override, and which VK feeds are built.

Feed routes (`/cmlmerchant/google-feed.xml`, `/cmlmerchant/yandex-feed.xml`, and the `vk-*` variants) require the `access content` permission and simply stream the pre-generated file back with a `text/xml` content type; if the file does not exist yet they return a small placeholder. The `/cmlmerchant/debug` route and the settings form both require `administer site configuration`. Products are collected with the catalog term tree; each offer carries title, description (CDATA), price (RUB), vendor code, canonical URL and up to ten images. Version 2.0.x targets Drupal core `^11 || ^12` and adds the Drush command and a PHP 8.2-style typed/`readonly` service rewrite over the previous 8.x-1.x major.

---

- Install the module together with its required `catalog` and `cmlstarter` projects (and Drupal Commerce for `commerce_product`).
- Open `/admin/config/cmlmerchant/settings` to set shop name, company name and the public site URL.
- Enable the VK feed variants (yandex, google, realty, transport, services, hotel) with the settings-form checkboxes.
- Expose the Google Merchant product feed at `/cmlmerchant/google-feed.xml`.
- Expose the Yandex.Market feed at `/cmlmerchant/yandex-feed.xml`.
- Serve the VK realty feed at `/cmlmerchant/vk-realty-feed.xml`.
- Serve the VK transport (cars) feed at `/cmlmerchant/vk-transport-feed.xml`.
- Serve the VK services feed at `/cmlmerchant/vk-services-feed.xml`.
- Serve the VK hotel listings feed at `/cmlmerchant/vk-hotel-feed.xml`.
- Serve VK Google/Yandex feed variants for social-commerce catalogs.
- Regenerate every configured feed file automatically on cron runs.
- Trigger feed regeneration on demand with `drush cmlmerchant:feeds` (alias `drush feeds`).
- Inspect feed building through the admin-only `/cmlmerchant/debug` route.
- Store generated feeds under `sites/default/files/YML/`.
- Populate `field_catalog_google_id` on catalog terms for Google category mapping.
- Submit the Google feed URL to Google Merchant Center.
- Submit the Yandex feed URL to Yandex.Webmaster / Yandex.Market.
- Point VK (ВКонтакте) catalog integrations at the matching `vk-*` feed URLs.
- Add the required per-feed product fields (address, region, VIN, year, worker_type, etc.) the settings form lists for realty/transport/services/hotel.
- Grant `access content` so marketplace crawlers can fetch the feeds.
- Restrict the debug route and settings form to site administrators.
- Schedule frequent cron so product and price changes reach the feeds promptly.
- Use the configured site-URL override to rewrite absolute links when the request host differs.
- Segment feed contents by building out the `catalog` taxonomy term tree.
- Rely on only in-stock, published variations with a non-zero price being emitted as offers.
- Advertise an optional old price (`oldprice`) when a product's `field_oldprice` exceeds the current price.
