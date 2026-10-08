<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automatic Site Icon Picker (automatic_site_icon_picker) — agent index

Adds one core-link **field formatter** that renders each link's favicon (fetched from the external
Vemetric Favicon API and cached locally) next to the link output.

## What it provides
- **Field formatter** `automatic_site_icon_picker_link` (label "Link (favicon)"), for `link` field
  types. Class: `Drupal\automatic_site_icon_picker\Plugin\Field\FieldFormatter\AutomaticSiteIconPickerLinkFormatter`
  (`src/Plugin/Field/FieldFormatter/AutomaticSiteIconPickerLinkFormatter.php`).
- **Theme hook** `automatic_site_icon_picker` (registered in `automatic_site_icon_picker.module`,
  `hook_theme()`); template `templates/automatic-site-icon-picker.html.twig`.
- Cache directory `public://social-media-icons/` for downloaded PNG favicons.

## Dependencies
- Core `field` only (`automatic_site_icon_picker.info.yml`). Core `^10 || ^11`.
- Outbound HTTPS access to `https://favicon.vemetric.com` is required at render time.

## Not provided
No routes, services, permissions, entities, config objects/schema, Drush commands, plugin types,
submodules, or libraries.

## Solution docs
- [agent/fields/formatter.md](fields/formatter.md) — the "Link (favicon)" formatter: settings,
  favicon fetch/cache flow, template, and how to enable it.
