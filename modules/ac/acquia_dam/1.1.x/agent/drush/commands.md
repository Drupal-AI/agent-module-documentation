<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by classes under `src/Drush/Commands/` (plus a legacy `src/Commands/`). All operate
against the connected DAM, so they need a valid site connection to do real work; they exist
and can be listed (`drush list --filter=acquia`) without one.

| Command | Aliases | Purpose |
|---|---|---|
| `acquia-dam:download-assets` | `ad:das`, `das` | Download queued/selected assets locally. |
| `acquia-dam:queue-update-assets` | `ad:qua` | Queue assets whose remote versions may have changed for update. |
| `acquia-dam:process-update-queue` | `ad:puq` | Process the asset **update** queue. |
| `acquia-dam:update-assets` | `ad:ua` | Queue + process updates in one go (refresh local copies of changed assets). |
| `acquia-dam:resolve-asset-media-type` | `ad:ramt` | Resolve which Drupal media type a given DAM asset maps to. |
| `acquia-dam:asset-metadata-sync` | `ad:ams` | Sync DAM metadata onto existing media entities. |
| `acquia-dam:queue-integration-links` | `ad:qil` | Queue integration links (asset-usage) for registration. |
| `acquia-dam:process-integration-links-queue` | `ad:pilq` | Process the integration-links queue. |
| `acquia-dam:register-integration-links` | `ad:ril` | Register integration links back to the DAM directly. |

`SqlSanitizeCommands` hooks core `drush sql:sanitize` to scrub DAM auth data (site/user tokens
in `state` / `user.data`) from sanitized DB dumps — so credentials do not leak into copies.

Typical cron-like maintenance:

```bash
drush acquia-dam:update-assets          # refresh changed assets
drush acquia-dam:asset-metadata-sync    # pull latest metadata
drush acquia-dam:queue-integration-links && drush acquia-dam:process-integration-links-queue
```

The **bulk import** commands (`acquia-dam:import-assets`, `:queue-import-assets`,
`:process-import-queue`) belong to the **acquiadam_asset_import** submodule — see its docs.
Cron and the `asset_update_check_action` action also drive updates automatically once
configured.
