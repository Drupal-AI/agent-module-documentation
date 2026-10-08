<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & the `ws-assets://` stream wrapper

## The stream wrapper

`src/StreamWrapper/WingsuitStreamWrapper.php` extends
`Drupal\Core\StreamWrapper\LocalReadOnlyStream` and is registered by
`wingsuit_companion.services.yml`:

```yaml
stream_wrapper.wingsuit:
  class: Drupal\wingsuit_companion\StreamWrapper\WingsuitStreamWrapper
  arguments: ['@config.factory', '@request_stack']
  tags:
    - { name: stream_wrapper, scheme: ws-assets }
```

Scheme: **`ws-assets://`**. It is **read-only** (writes/deletes are unsupported by the base class).
`getDirectoryPath()` returns `wingsuit_companion.config:dist_path` verbatim — that config value is
the root the scheme maps to. `getExternalUrl()` builds a public URL as
`base_path() . $dist_path . '/' . $target`; if `dist_path` is empty it throws
`InvalidArgumentException`. Use `ws-assets://…` from templates and libraries to reference files the
front-end build wrote into the `dist` directory.

## The settings form

Route `wingsuit_companion.wingsuit_companion_config_form` →
`/admin/wingsuit-companion/form/config` (`src/Form/ConfigForm.php`, a plain `FormBase`), requirement
`_permission: 'administer wingsuit configuration'`. A menu link
(`wingsuit_companion.links.menu.yml`) places it under *Configuration → System*.

Fields written to `wingsuit_companion.config`:

- **`dist_path`** (textfield, maxlength 128) — "A local file system path to your dist/app-drupal
  directory." This is the stream-wrapper root and the directory the UI Patterns deriver scans.
- **`only_own_layout`** (checkbox) — "Use only Wingsuit patterns." Hides all other layouts in
  Layout Builder (enforced in `wingsuit_ui_patterns_plugin_filter_layout_alter`).
- **`auto_fill_link_url`** (checkbox) — added by the `wingsuit_link` submodule via
  `hook_form_..._alter`; only appears when that submodule is enabled.

`submitForm()` writes every submitted value except the form-plumbing keys (`submit`, `form_build_id`,
`form_token`, `form_id`, `op`) straight into the config object, then saves.

## Config schema (`config/schema/wingsuit_companion.schema.yml`)

`wingsuit_companion.config` is a `config_object` with `dist_path` (String), `only_own_layout`
(boolean), `auto_fill_link_url` (boolean).

## Install / update behavior

- `config/install/wingsuit_companion.config.yml` ships `dist_path: "/../../dist/app-drupal"`,
  `only_own_layout: FALSE`, `auto_fill_link_url: FALSE`. (On the review site the live value is the
  shipped `/../../dist/app-drupal`.)
- `hook_install()` sets `dist_path` to `themes/custom/wingsuit/dist/app-drupal` **only if empty**.
- `wingsuit_companion_update_8001()` installs the `wingsuit_ui_patterns` submodule and rewrites
  `dist_path` to an absolute path derived from the `wingsuit` theme's path + the relative dist path,
  canonicalized by the private helper `_wingsuit_companion_canonicalize()` (collapses `..`
  segments). This requires a `wingsuit` theme to exist.
- `wingsuit_link_update_8201()` (in the submodule) prefills `auto_fill_link_url` to TRUE.

## Permission

`administer wingsuit configuration` — `restrict access: true`. Sole gate on the settings route.
No other routes exist in the module.
