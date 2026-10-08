<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cmlmerchant — feeds & configuration (2.0.x)

## Settings form
`/admin/config/cmlmerchant/settings` — `\Drupal\cmlmerchant\Form\SettingsForm`, permission `administer site configuration`.
Stores to `cmlmerchant.settings`: `shop_name`, `company_name`, `site_url` (absolute-URL override), and boolean toggles `vk_yandex`, `vk_google`, `vk_realty`, `vk_transport`, `vk_services`, `vk_hotel`. For each enabled VK feed the form lists the extra `commerce_product` fields it needs (e.g. realty/hotel: address, locality, region, country; transport: mark, folder, owners_number, year, vin; services: brand taxonomy, worker_type) and warns if a listed field is missing on the `product` bundle.

## Feed endpoints (permission `access content`, read-only)
| Path | Controller method | File served |
|------|-------------------|-------------|
| `/cmlmerchant/google-feed.xml` | `FeedController::google` | `cmlmerchant_google.xml` |
| `/cmlmerchant/yandex-feed.xml` | `FeedController::yandex` | `cmlmerchant_yandex.xml` |
| `/cmlmerchant/vk-google-feed.xml` | `vkGoogle` | google file |
| `/cmlmerchant/vk-yandex-feed.xml` | `vkYandex` | yandex file |
| `/cmlmerchant/vk-realty-feed.xml` | `vkRealty` | realty file |
| `/cmlmerchant/vk-transport-feed.xml` | `vkTransport` | transport file |
| `/cmlmerchant/vk-services-feed.xml` | `vkServices` | services file |
| `/cmlmerchant/vk-hotel-feed.xml` | `vkHotel` | hotel file |

Files live under `DRUPAL_ROOT/sites/default/files/YML/` (public filesystem). If a file does not exist yet the controller returns a small placeholder markup instead of XML.

## What goes in a feed
`YmlService` walks the `catalog` taxonomy term tree, then loads published `commerce_product` entities referencing those terms (`field_catalog`). For each product it emits the first published, in-stock (`field_stock` != '0'), non-zero-price variation as an offer: title (`field_title` or product title), description (CDATA, HTML-escaped), price in **RUB**, optional `oldprice` when `field_oldprice` > price, vendor code (`field_article`), canonical absolute URL, and up to 10 images (`field_image` + `field_gallery`). Google output uses the `g:` namespace; Yandex/VK variants use their own element shapes. The VK realty/transport/services/hotel feeds ignore categories and require their extra per-feed fields or the product is skipped.

## Regeneration
- **Cron:** `cmlmerchant_cron()` → `src/Hook/Cron.php` calls `YmlService::createFeeds()` on scheduled runs.
- **Drush:** `drush cmlmerchant:feeds` / `drush feeds` (`\Drupal\cmlmerchant\Drush\Commands\CmlmerchantCommands`, registered via `drush.services.yml`).
- **Debug:** `/cmlmerchant/debug` (`administer site configuration`) runs `YmlService::debug()` → `createFeeds()`.

## Google category mapping
Config install adds `field_catalog_google_id` (string) to the `catalog` taxonomy vocabulary; set the Google product category id per term.

## Site-URL override
`site_url` config is used by `fixUrl()` to replace a `http://default` host in generated absolute links with the configured domain (useful for CLI/cron contexts that lack a real request host).
