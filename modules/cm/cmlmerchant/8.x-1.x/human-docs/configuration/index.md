# Configuration

The settings form is at **Configuration → cmlmerchant → Settings**
(`/admin/config/cmlmerchant/settings`), reachable by users who can access
administration pages.

## Configure feed generation

Open the settings form to control what is included in the generated feeds. Adjust
these to match the products and fields you want to expose to Google Merchant, Yandex
and VK.

## Map Google product categories

For the Google Merchant feed, populate the **`field_catalog_google_id`** field on
your `catalog` taxonomy terms with the appropriate Google product category id per
term. This field is installed by the module; setting it correctly is what lets
Google classify your products.

## Your feed URLs

The module serves each pre‑generated file from a fixed path (gated by the **access
content** permission, so search‑engine and marketplace crawlers can fetch them):

| Feed | URL |
|------|-----|
| Google Merchant | `/cmlmerchant/google-feed.xml` |
| Yandex | `/cmlmerchant/yandex-feed.xml` |
| VK (Google variant) | `/cmlmerchant/vk-google-feed.xml` |
| VK (Yandex variant) | `/cmlmerchant/vk-yandex-feed.xml` |
| VK realty | `/cmlmerchant/vk-realty-feed.xml` |
| VK transport | `/cmlmerchant/vk-transport-feed.xml` |
| VK services | `/cmlmerchant/vk-services-feed.xml` |
| VK hotel | `/cmlmerchant/vk-hotel-feed.xml` |

Register the relevant URL with each platform — the Google feed URL in Google
Merchant Center, the Yandex feed URL in Yandex.Webmaster, and so on. The files
themselves live under `sites/default/files/YML/`.

## Keeping feeds fresh

- **Cron** rebuilds the feed files automatically on each scheduled run — schedule
  cron frequently enough that product changes appear in the feeds in good time.
- **Drush** — the module provides a Drush command to regenerate the feeds on
  demand.
- **Debug** — visit `/cmlmerchant/debug` (administrators only) to inspect the feed
  building process if something looks wrong.
