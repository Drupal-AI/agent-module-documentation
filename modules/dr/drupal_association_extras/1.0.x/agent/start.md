<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Association Extras (drupal_association_extras) — agent index

A Drupal Association add-on that carries small features supporting DA initiatives and programs. At
**1.0.0-alpha1** it ships exactly one feature, implemented entirely in `hook_install()`: it adds a
"🚀 Ready to launch?" link to the bottom of core's admin **Navigation** toolbar, pointing at
`https://drupal.org/drupal-cms/launch`. There is no runtime code — no `src/`, no routes, no
services, no permissions, no config schema, no plugins. The link is written once at install time
into core Navigation's own config and is a plain static outbound link thereafter.

Mechanism (`drupal_association_extras.install`, `drupal_association_extras_install()`): on install
(skipped when `$is_syncing` is TRUE, i.e. during config import) it calls the config-action manager
`plugin.manager.config_action` with action `addNavigationBlock` on config `navigation.block_layout`,
placing a `navigation_link` block at `delta: 100` (a deliberately high delta so it sorts last among
the main navigation items) with `label: Launch`, `title: '🚀 Ready to launch?'`,
`uri: https://drupal.org/drupal-cms/launch`, and `provider: navigation`.

- **Depends on:** core `navigation` (info.yml `drupal:navigation`).
- **Core:** `^11.2`.
- **Package:** none set in info.yml.
- **Settings page / configure route:** none (`configure` is null). Nothing to configure.
- **Permissions:** none. **Services:** none. **Drush:** none. **Plugin types:** none.
- **Config schema shipped:** none (it only writes into core Navigation's config).
- **Composer require:** none beyond the module itself; no PHP/library constraints.

## What you'd do → where
Everything is start-only; there are no topic files. Concrete facts:
- **The feature:** the "🚀 Ready to launch?" navigation link, added by
  `drupal_association_extras_install()` in `drupal_association_extras.install`.
- **Change/remove the link:** it lives in core config `navigation.block_layout` after install; edit
  or delete it there (e.g. `drush config:edit navigation.block_layout`), not in this module. The
  module does not re-apply it on cache rebuild — only on (re)install.
- **Test of record:** `tests/src/Functional/LaunchLinkTest.php` asserts the link renders last in the
  navigation toolbar for a user with `access navigation`.

## Key facts (real machine names)
- Hook: `hook_install()` → `drupal_association_extras_install(bool $is_syncing)`.
- Config-action service: `plugin.manager.config_action`; action id `addNavigationBlock`; target
  config `navigation.block_layout`.
- Navigation block written: `id: navigation_link`, `delta: 100`, `label: Launch`,
  `label_display: '0'`, `provider: navigation`, `title: '🚀 Ready to launch?'`,
  `uri: https://drupal.org/drupal-cms/launch`, `icon_class: ''`.
- Permission referenced by the test (core Navigation's): `access navigation`.
- **No security surface** (no routes/services/user input; a single install hook writing one static,
  hardcoded config value).
