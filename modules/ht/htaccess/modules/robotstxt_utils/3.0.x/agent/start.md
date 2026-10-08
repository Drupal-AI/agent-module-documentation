<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Robots.txt Utils (robotstxt_utils) — agent index

Submodule of the **Htaccess** project. Deletes the physical `DRUPAL_ROOT/robots.txt` so the
contrib **Robotstxt** module's dynamic version is served. Package `Search`. Core `^10 || ^11`.
Depends on module **`robotstxt`**. License GPL-2.0-or-later. Version **3.0.0**.

## What it provides

- **`robotstxt_utils_form_robotstxt_admin_settings_alter()`** — adds a checkbox
  `eliminar_robots_txt` ("Delete physical robots.txt", weight 90) to the Robotstxt module's
  `robotstxt_admin_settings` form and appends a custom submit handler. It defines **no route or
  permission of its own** (the `configure: robotstxt_utils.admin_settings_form` link in its
  `.info.yml` has no matching route; the checkbox lives on the Robotstxt admin form, gated by that
  module's own permission).
- **`robotstxt_utils_admin_settings_submit()`** — saves `eliminar_robots_txt` to
  `robotstxt_utils.settings`, and when true deletes `DRUPAL_ROOT/robots.txt` via
  `file_system->unlink()` (with messenger feedback), if it exists and is writable.
- **`robotstxt_utils_cron()`** — when `eliminar_robots_txt` is true **and** `robotstxt` is enabled,
  unlinks `DRUPAL_ROOT/robots.txt` again on every cron run.
- **Config** `robotstxt_utils.settings` — single boolean `eliminar_robots_txt` (default `false`;
  `config/install` + `config/schema`, `type: config_object`).

## Solution docs

- **Form alter, config, and deletion behavior** → [config/settings.md](config/settings.md)

## Notes from source

- No `src/`, no classes — a single procedural `.module` file.
- The deletion target is the fixed path `DRUPAL_ROOT . '/robots.txt'`; it is not derived from
  request or config input.
- Parent project: `modules/ht/htaccess/3.0.x/`.
