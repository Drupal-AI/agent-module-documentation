<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia DAM — agent index

Integrates the **Acquia DAM (Widen)** SaaS with Drupal: remote assets become media entities
via the `acquia_dam_asset` media source, embeddable through the Media Library. Config UI:
`/admin/config/acquia-dam` (route `acquia_dam.config`). Settings object:
**`acquia_dam.settings`**. Ships **8 media types** (image, video, audio, pdf, documents,
archive, spinset, generic). Runtime asset calls need live DAM OAuth credentials; the Drupal
config side is fully inspectable offline.

- **Connection + all settings keys, the admin forms (metadata, image styles, links), Key entity** →
  [configure/settings-and-connection.md](configure/settings-and-connection.md)
- **The 8 media types + the `acquia_dam_asset` source and its config (download_assets, uri_scheme…)** →
  [plugins/media-source.md](plugins/media-source.md)
- **The two permissions and how routes gate on site-authentication** →
  [permissions/permissions.md](permissions/permissions.md)
- **Drush commands (download / update / metadata-sync / resolve / integration-links)** →
  [drush/commands.md](drush/commands.md)
- **Key services, formatters/widgets, stream wrapper, cron/queue/action** →
  [api/services-and-fields.md](api/services-and-fields.md)

Submodules (documented separately, nested under this dir):
- **acquia_dam_integration_links** — deep asset-usage discovery (entity refs, paragraphs, text embeds).
- **acquiadam_asset_import** — bulk import assets by Widen category/asset group.

Key facts:
- Media source id is `acquia_dam_asset:<type>` (e.g. `acquia_dam_asset:image`); source field
  `acquia_dam_asset_id`. Plugin type manager: `plugin.manager.acquia_dam.asset_media_source`
  (`Plugin/media/acquia_dam`, annotation `AssetMediaSource`).
- `acquia_dam.settings` install default: `domain: ''`, `asset_file_directory_path:
  'dam/[media:acquia_dam_asset_id:external_id]'`. Not connected until `domain`/auth are set.
