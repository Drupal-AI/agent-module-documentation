# Configuration

Config Patch works as soon as it's enabled — the **Patch** tab and Drush commands
are available immediately. The settings form only tunes two things, but the config
base path in particular is worth setting so your patches apply cleanly in your
repo.

## The settings form

1. Go to **Configuration → Development → Config Patch**
   (`/admin/config/development/config_patch`). You need the **Administer
   config_patch** permission (a restricted permission).
2. Set the two options:

- **Config base path** — a relative path prefix that's prepended to each config
  file's path inside the generated patch, so the paths in the diff line up with
  where the config files actually live in your repository. Set it to match your
  repo layout (for example `config` or `web/sites/default/files/config_XXXX/sync`).
  It **must not** start with a `/` — the form validates this.
- **Output plugin** — the default output plugin used by the button on the Patch
  tab. Out of the box this is **Text** (print the patch). If you've installed a
  Git‑host submodule, you can choose its plugin here instead.

Click **Save configuration**.

### Setting the base path in `settings.php` instead

You can skip the UI and derive the base path from your sync directory in
`settings.php`, which is handy for keeping it correct per environment:

```php
$config['config_patch.settings']['config_base_path'] = 'web/' . $settings['config_sync_directory'];
```

## Permissions — who can do what

Config Patch reuses Drupal's own configuration permissions for most actions, plus
its own for the settings form. All of these are **restricted** permissions, so
grant them only to trusted roles:

- **Export configuration** (core) — view the Patch tab, use the toolbar widget,
  and clear the module's cached comparison.
- **Import configuration** (core) — use the **revert** form that restores a named
  config object back to its sync version.
- **Administer config_patch** (this module) — access the settings form above.

## Generating patches from the command line (Drush)

Two Drush commands are provided:

- **`drush config:patch <plugin>`** (alias `drush cpatch <plugin>`) — generate a
  patch from active → sync config using the named output plugin. The output plugin
  must support CLI output; the bundled `text` plugin does.

  ```bash
  drush config:patch text                    # print the unified diff to the screen
  drush config:patch text --filename=cfg.patch   # write it to a file instead
  drush cpatch text | patch -p1              # apply another site's config in your repo
  ```

  Useful options: `--filename=PATH` writes to a file instead of stdout, and
  `--collections=a,b` limits the patch to specific config collections.

- **`drush config:patch:list`** — list the config objects that differ between
  active and sync as a table of name and change type. It reports "No changes
  found." when there's no drift. Add `--compact` for a headerless, compact table.

## Reverting a single config item

From the Patch tab you can revert an individual config object back to its sync
version using the confirm‑revert form. Because that writes config, it requires the
**Import configuration** permission.

## Extending the output (developers)

The action taken on a generated patch is a plugin, so you can build your own —
for example to submit patches to a bespoke system or produce a downloadable file.
The plugin interface and a minimal example are documented in the
[`agent/`](../agent/start.md) docs (`plugins/output.md`).
