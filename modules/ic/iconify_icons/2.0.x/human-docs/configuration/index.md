# Configuration

Iconify Icons has one settings form, where you choose which of Iconify's many
icon sets your editors are offered.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission. (The
   module does not add its own permission — this core permission gates the form.)
2. Go to **`/admin/config/iconify_icons/settings`** (the `iconify_icons.settings`
   route, under **Configuration**).

## Choose which icon sets are offered

Iconify aggregates more than 150 icon collections, which is more than most sites
want to expose in a picker. On this form you select the **icon sets (collections)**
that should be available. Limiting the list to an approved handful keeps the picker
focused, helps editors stay on‑brand, and enforces a consistent iconography across
the site. Save the form to apply your selection.

The picker is styled both generically and specifically for the **Gin** admin
theme, so it looks at home in a Gin‑based admin UI.

## Important: this module calls the Iconify API

Icon rendering depends on an **outbound HTTP request to the Iconify API**. A
built‑in cache stores fetched icons so the same icon isn't requested repeatedly,
but you should still weigh these points before relying on it:

- **Egress is required.** An air‑gapped site, or one with a strict outbound‑traffic
  policy, cannot render icons on a cache miss. Make sure the site can reach the
  Iconify API over HTTPS.
- **Upstream availability.** An outage at Iconify degrades the picker until the API
  is reachable again.
- **Third‑party disclosure.** Requests to the API reveal your site's icon usage to
  a third party.

If any of those are dealbreakers, consider a **self‑hosted** alternative that
serves icons locally — for example
[Iconify Field](../../../iconify_field/1.2.x/human-docs/index.md), which ships the
icon data as a Composer package, or `font_iconpicker`.

## Save

Click **Save** to store your chosen icon sets. The selected collections then
appear wherever Drupal offers an icon picker (icon fields, menu items, and other
Icon‑API‑aware places).
