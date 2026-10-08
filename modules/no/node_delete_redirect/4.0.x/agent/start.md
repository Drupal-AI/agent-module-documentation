<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Delete Redirect (node_delete_redirect) — agent index

Configurable **post-node-delete redirect**, per content type. Replaces Drupal's default
"return to front page" after a node delete with an admin-configured internal path per bundle.
Version **4.0.0**. Package `Content`. Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later.
Only dependency is core **`node`**. No permissions of its own, no Drush, no entities, no plugins.

- **The settings form, config object + schema, path validation, and the delete-time redirect
  mechanism** → [config/settings.md](config/settings.md)

## What it actually is

- One settings form: `NodeDeleteRedirectConfigForm` (form id + route id
  `node_delete_redirect.admin_settings_form`), at path
  **`admin/config/content/node-delete-settings`**, requirement `_permission: 'administer content types'`
  (`node_delete_redirect.routing.yml`). Menu link under *Configuration → Content authoring*
  (`node_delete_redirect.links.menu.yml`).
- One config object: **`node_delete_redirect.admin_settings_form`** with a single top-level key
  `ndr_admin_form_settings` (schema in `config/schema/node_delete_redirect.schema.yml`).
- One service: **`node_delete_redirect.elem_path_validate`** →
  `Drupal\node_delete_redirect\Validate\NodeDeleteRedirectElemPathValidate` (arg `@path.validator`),
  the per-element `#element_validate` for redirect paths.
- Procedural glue in `node_delete_redirect.module`: `hook_help`, `hook_form_alter`, the custom
  submit `node_delete_redirect_form_submit`; `hook_uninstall` in `.install` deletes the config.

## Mechanism (from source)

- `node_delete_redirect_form_alter()` runs on the node delete confirm form (`node_{type}_delete_form`).
  When `ndr_check` is on and that bundle's `is_enabled` is true, it stashes the configured
  `redirect` path onto `$form['#attributes']['node_delete_redirect_to']` and appends
  `node_delete_redirect_form_submit` to the submit handlers.
- `node_delete_redirect_form_submit()` reads that path, optionally prepends `/{current_lang}` when
  `ndr_lang` is on and the current language differs from the default, ensures a leading
  `/`/`?`/`#`, and calls `$form_state->setRedirectUrl(Url::fromUserInput($redirect_to))`.
  `Url::fromUserInput` accepts **internal paths only** → redirect stays on-site.
- Redirect targets are **admin config**, not request input, and are validated at save time
  (see settings doc). No open-redirect surface.

## Provides / does not provide

- provides_config_schema: **true**; provides_permissions: **false** (reuses core
  `administer content types`); provides_drush_commands: **false**; provides_plugin_types: **[]**;
  submodules: **none**.
