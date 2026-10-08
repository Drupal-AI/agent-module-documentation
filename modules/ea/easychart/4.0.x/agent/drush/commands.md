<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `easychart:install` (`eci`)

`src/Commands/EasychartCommands.php` (registered via `drush.services.yml`).

## `drush easychart:install` — alias `drush eci`

Downloads and installs the external JavaScript libraries Easychart needs into the site's
`/libraries` directory:

- **Easychart** v3 plugin → `/libraries/easychart` (from the `lib.easycharts.full` library `remote`;
  the downloaded `easychart-master` zip is extracted and renamed to `easychart`).
- **Highcharts** and **Highcharts Editor** are declared with `remote` URLs in
  `easychart_library_info_build()` (`lib.highcharts` 10.1.0, `lib.highcharts-editor` 0.2.2) for the
  same install flow.

Mechanics: creates `/libraries` if missing, `chdir()`s into it, fetches each library's `remote` zip
with `file_get_contents()`, saves via the file system service, deletes any existing copy, extracts
with `Drupal\Core\Archiver\Zip`, and moves it into place. Requires the `easychart` module to be
enabled (it errors otherwise).

Run it once after enabling the module (host: `ddev drush eci`). There are no other Drush commands.
