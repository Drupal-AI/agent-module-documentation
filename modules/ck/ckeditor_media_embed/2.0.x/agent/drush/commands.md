<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands — download the CKEditor plugin JS

The CKEditor 5 media-embed JavaScript is **not shipped** with the module. It must live at
`<drupal_root>/libraries/ckeditor5/plugins/media-embed/build/media-embed.js`. These commands
fetch it. Registered via `drush.services.yml` (`ckeditor_media_embed.commands`).

| Command | Does |
|---|---|
| `drush ckeditor_media_embed:install` | Download the media-embed plugin build for the target CKEditor version into `libraries/ckeditor5/plugins/`, and record `plugins_version_installed` in config. Run once after enabling the module. |
| `drush ckeditor_media_embed:update` | Re-download the plugin to match core's current CKEditor version (use after a core update that bumps CKEditor). |

Target version resolution (`AssetManager::getCKEditorVersion`): the `ckeditor_version` config key
if set, otherwise the `ckeditor5.version` parsed from core's `core/core.libraries.yml`, otherwise
the module's built-in fallback `4.5.x`.

## When you'd run them

- Right after `drush en ckeditor_media_embed` — the module's `hook_install` and
  `hook_requirements` warn that plugins are missing until you do.
- After upgrading Drupal core to a new CKEditor 5 version — the Status Report shows
  *"Mixed versions"*; run `:update`.

Both commands reach out to the npm registry / GitHub to obtain the build, so they need outbound
network access and write access to `libraries/`. In an air-gapped environment, place the built
`media-embed` plugin directory there manually instead.

## Verifying install state without Drush

`drush php:eval` using the facade:

```php
use Drupal\ckeditor_media_embed\AssetManager;
$v = AssetManager::getCKEditorVersion(\Drupal::service('library.discovery'), \Drupal::service('config.factory'));
var_export(AssetManager::pluginsAreInstalled($v));   // TRUE once media-embed.js is present
```

or check the Status Report (`/admin/reports/status`) → "CKEditor Media Embed plugin".
