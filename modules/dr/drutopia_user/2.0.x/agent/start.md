<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia User (drutopia_user) — agent index

A **configuration-only** Drutopia distribution base feature. Ships **no PHP** — no `.module`,
`.install`, `src/`, routes, services, permissions, plugins, or schema. It contains only three
exported core display-config objects for the core **User** entity. Package `Drutopia`.
Core requirement `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.

- **Version:** `2.0.x` — documented from a **dev checkout** (info.yml has no `version:`; branch
  built on git.drupalcode.org and mirrored to drupal.org). No packaged release string on disk.
- **Nature:** a Features module (`drutopia_user.features.yml` → `bundle: drutopia`), meant to be
  installed as part of the Drutopia distribution rather than standalone.
- **Dependencies (info.yml):** core only — `field`, `file`, `image`, `path`, `user`. No Composer
  `require` beyond that (composer.json declares none; `minimum-stability: dev`).

## What it actually ships

Three files in `config/install/` (imported on enable, then editable via the UI as normal config):

- `core.entity_form_display.user.user.default` — the user **account form** display.
- `core.entity_view_display.user.user.default` — the user **profile** (default view mode) display.
- `core.entity_view_display.user.user.compact` — a **compact** user view mode display.

No settings route (`configure` is null). Adjust afterwards at *Structure → Account settings →
Manage display / Manage form display* (`/admin/config/people/accounts/display` and `/form-display`).

- **Exactly which fields each display shows/hides, weights, and the compact view mode** →
  [config/displays.md](config/displays.md)
