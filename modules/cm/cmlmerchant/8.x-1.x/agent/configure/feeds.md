<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cmlmerchant — feeds & configuration

## Settings form
`/admin/config/cmlmerchant/settings` (`\Drupal\cmlmerchant\Form\SettingsForm`, permission `access administration pages`).

## Feed endpoints (permission `access content`, read-only)
| Path | Controller method | File served |
|------|-------------------|-------------|
| `/cmlmerchant/google-feed.xml` | `FeedController::google` | `cmlmerchant_google.xml` |
| `/cmlmerchant/yandex-feed.xml` | `FeedController::yandex` | `cmlmerchant_yandex.xml` |
| `/cmlmerchant/vk-google-feed.xml` | `vk_google` | google file |
| `/cmlmerchant/vk-yandex-feed.xml` | `vk_yandex` | yandex file |
| `/cmlmerchant/vk-realty-feed.xml` | `vk_realty` | realty file |
| `/cmlmerchant/vk-transport-feed.xml` | `vk_transport` | transport file |
| `/cmlmerchant/vk-services-feed.xml` | `vk_services` | services file |
| `/cmlmerchant/vk-hotel-feed.xml` | `vk_hotel` | hotel file |

Files live under `DRUPAL_ROOT/sites/default/files/YML/`. If a file does not exist yet the controller returns a small placeholder markup instead of XML.

## Regeneration
- **Cron:** `src/Hook/Cron.php` rebuilds feeds on scheduled runs.
- **Drush:** `\Drupal\cmlmerchant\Drush\Commands\CmlmerchantCommands` (see `drush.services.yml`) regenerates on demand.
- **Debug:** `/cmlmerchant/debug` (`administer site configuration`) runs `YmlService::debug()`.

## Google category mapping
Config installs `field_catalog_google_id` on the `catalog` taxonomy vocabulary; set the Google product category id per term.
