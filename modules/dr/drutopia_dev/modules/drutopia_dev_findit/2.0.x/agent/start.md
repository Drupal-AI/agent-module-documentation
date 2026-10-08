<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Dev for Find It (drutopia_dev_findit) — agent index

Submodule of **Drutopia Dev**, targeting the Drutopia **"Find It"** install profile. Like the parent it has no `src/` classes — it is dependency metadata plus one installed config file.

- **Version:** 2.0.x (dev checkout; no packaged `version:`) · **Core:** `^8 || ^9 || ^10` (info.yml also keeps the legacy `core: 8.x` key) · **Package:** Drutopia · **License:** GPL-2.0-or-later
- **Parent project:** [drutopia_dev](../../../2.0.x/agent/start.md). This submodule is **independent of** and **mutually exclusive with** the parent (both install the same `features.bundle.drutopia` object).

## What it actually ships

- **No routes, permissions, services, hooks, plugins, or Drush commands.** No `*.module`, `src/`, or `config/schema/`.
- **Dependencies** (`drutopia_dev_findit.info.yml`): `dblog`, `drutopia_page`, `drutopia_findit_organization`, `drutopia_findit_program`, `features`, `features_ui`, `node`, `user`.
- **Config it installs** (`config/install/features.bundle.drutopia.yml`): the `drutopia` Features bundle config entity — **byte-identical** to the parent's copy (hence the mutual exclusivity noted in the README). See [config/findit-bundle.md](config/findit-bundle.md).
- **Features marker** (`drutopia_dev_findit.features.yml`): `bundle: drutopia`, `required: true`.

## Operate it

Enable on a development environment built on the Find It install profile (`drush en drutopia_dev_findit -y`) to bring in the Find It content features and the Features UI, and to install the `drutopia` bundle. No configuration form of its own (`configure: null`). Do not enable it together with `drutopia_dev`. Details: [config/findit-bundle.md](config/findit-bundle.md).
