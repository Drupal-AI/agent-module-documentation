<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — schemes in `settings.php`

Flysystem has **no admin config and no configure route**. Every backend is a *scheme*
declared in `settings.php`:

```php
$settings['flysystem'] = [
  // Stream-wrapper name. Allowed chars: letters, numbers, + . -  (NO underscores).
  'myfiles' => [
    'driver' => 'local',          // Flysystem adapter plugin id.
    'config' => [
      'root'   => 'sites/default/files/flysystem', // relative to Drupal root for public
      'public' => TRUE,           // serve at browser-accessible URLs + image styles
      // 'cache' => TRUE,         // cache filesystem metadata (via Drupal cache adapter)
      // 'name' => 'My files',    // display label in the file-system UI
      // 'description' => '...',
      // 'replicate' => 'backupscheme', // mirror every write to another scheme
    ],
  ],
];
```

After editing `settings.php`, rebuild so the stream wrapper and routes register:
`drush cr` (the `flysystem_factory->ensure()` also runs on cron and `hook_rebuild`).

## Built-in drivers

| `driver` | Class | Notes |
|---|---|---|
| `local` | `Drupal\flysystem\Flysystem\Local` | Local dir; writes a `.htaccess`; `public` serves via web. |
| `ftp` | `Drupal\flysystem\Flysystem\Ftp` | Needs the PHP `ftp` extension; config `host`/`username`/`password`/`port`/`root`/… |

Contrib modules add more `driver` ids: `s3v2` (flysystem_s3), `sftp`, `dropbox`, `gcs`,
`swift`, `zip`, `Drupal Cache`, `Aliyun OSS`. A driver whose PHP extension is missing is
removed from the plugin list (`alterDefinitions()`), and an unknown driver falls back to the
`missing` plugin (`FallbackPluginManagerInterface`).

## `public` vs non-public

- `config.public = TRUE` → Flysystem registers file + image-style routes (see
  `FlysystemRoutes::routes()`); files are reachable directly and `flysystem_entity_access()`
  grants `download`/`view`.
- Non-public → files are proxied through Drupal at `/_flysystem/{scheme}/{filepath}`
  (`flysystem.serve`), subject to normal file access.

## Inspect the live schemes (no config entity to `drush config:get`)

```bash
# List active schemes:
drush php:eval 'print implode(",", \Drupal::service("flysystem_factory")->getSchemes());'

# Full settings for a scheme (driver + config):
drush php:eval 'print var_export(\Drupal\Core\Site\Settings::get("flysystem")["myfiles"] ?? "none", TRUE);'

# Run each scheme's health check (returns per-scheme error/info messages):
drush php:eval 'print var_export(\Drupal::service("flysystem_factory")->ensure(), TRUE);'
```

Set the site's **default** upload destination to a scheme on the File system settings page
(`/admin/config/media/file-system`) or via `system.file` config.
