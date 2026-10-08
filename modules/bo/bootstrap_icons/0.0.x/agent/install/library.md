<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installing the Bootstrap Icons SVG library

The module registers the pack but does **not** bundle the ~2000 SVG files. They must land at
`libraries/bootstrap-icons/icons/*.svg` (the `config.sources` glob in the pack definition). Three
ways, all installing `twbs/bootstrap-icons` **1.11.3**.

## Enable the module

```bash
composer require drupal/bootstrap_icons
drush en bootstrap_icons
```

## Option A — Drush command (recommended)

```bash
drush bootstrap_icons:download            # installs into libraries/
drush bootstrap_icons:download web/libraries   # custom path (positional $path arg)
```

Provided by `BootstrapIconsCommands::download()` (`src/Commands/BootstrapIconsCommands.php`,
service `bootstrap_icons.commands`, alias `bootstrap-icons-download`). What it does, in order:

1. Creates `$path` (default `libraries`) if missing, then `chdir($path)`.
2. If a `bootstrap-icons/` dir already exists there, deletes it recursively.
3. Downloads the hard-coded npm tarball
   `https://registry.npmjs.org/bootstrap-icons/-/bootstrap-icons-1.11.3.tgz` via
   `curl -sL --connect-timeout 30` (throws `RuntimeException` if the file is missing/empty).
4. Extracts with `tar -xzf` into `bootstrap-icons-tmp/`, then renames the npm `package/` subdir to
   `bootstrap-icons/`.
5. Deletes the tarball, counts `bootstrap-icons/icons/*.svg`, logs success/error, and restores the
   original cwd in a `finally`.

Requires `curl` and `tar` on the host running Drush. The download URL and version are constants in
the class, not configurable.

## Option B — Composer

Merge the shipped `composer.libraries.json` fragment (a `repositories` entry + a
`require: { "twbs/bootstrap-icons": "1.11.3" }`) into the root `composer.json`, and ensure
`drupal-library` maps to the libraries dir:

```json
"installer-paths": { "web/libraries/{$name}": ["type:drupal-library"] }
```

The package's `extra.installer-name` is `bootstrap-icons`, so it installs to `.../bootstrap-icons/`.

## Option C — Manual

```bash
cd /path/to/drupal/libraries
curl -sL https://registry.npmjs.org/bootstrap-icons/-/bootstrap-icons-1.11.3.tgz | tar xz
mv package bootstrap-icons
```

## After installing

`drush cr`, then verify `libraries/bootstrap-icons/icons/arrow-right.svg` exists. To update to a
newer library version: bump `version`/`dist.url` in `composer.libraries.json`, bump `version` in
`bootstrap_icons.icons.yml`, re-run the download (or Composer), and `drush cr`.
