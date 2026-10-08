<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install & enable

```bash
composer require drupal/library_manager
drush en library_manager -y
```

Requires core `^10 || ^11` and the contrib module **`codemirror_editor`** (`^1.0 || ^2.0`), which
provides the in-browser code editor; `drupal/system` is the only core dependency. `configure` link
points at route `library_manager.settings`.

## The `library_manager.settings` config object

One key, defined in `config/install/library_manager.settings.yml`:

```yaml
libraries_path: sites/default/files/libraries/custom
```

Schema (`config/schema/library_manager.schema.yml`): `library_manager.settings` is a
`config_object` with a single `libraries_path` string. This is the directory root under which
**inline-code** JS/CSS files are written to disk (as `libraries_path/{definition_id}/{file_name}`);
uploaded and external files do not use it. The default lives under the public files directory so it
is web-accessible, which the module requires because the generated files are served as static
assets.

## `SettingsForm`

`Drupal\library_manager\Form\SettingsForm` (extends `ConfigFormBase`, form id
`library_manager_settings`, route `/admin/structure/library/settings`, permission
`administer libraries`). It renders one `libraries_path` textfield (with an `#after_build` of
`system_check_directory`, which creates the directory and warns if it is not writable), and on
submit saves the value and calls `libraryDiscovery->clearCachedDefinitions()`. Editable config
name: `library_manager.settings`. Constructor injects `config.factory` and
`library_manager.library_discovery`.

## Config schema for definitions

The same schema file also declares `library_manager.library_definition.*` (see
[../entities/library_definition.md](../entities/library_definition.md) for the property list): the
`license` mapping, the `js`/`css` sequences with their per-file mappings, `library_dependencies`,
`load`, and a `visibility` sequence typed as `condition.plugin.[id]` so each stored condition
validates against its own plugin schema.

## Install / update hooks

`library_manager.install` ships two update hooks that migrate existing definitions:

- `library_manager_update_8205()` — backfills the `attributes`, `typemodulecheck`,
  `nomodulecheck` fields on pre-existing definitions.
- `library_manager_update_8206()` — sets `status = TRUE` on every definition (needed when
  upgrading 2.x → 3.x; run `drush updb`).

Both invalidate `cache.config` afterwards.

## Menu / task / action links

- Menu (`.links.menu.yml`): *Libraries* under Structure, with child items *Library definitions*,
  *Add library definition*, *Settings*; plus *Library assets* under Reports.
- Local tasks (`.links.task.yml`): Libraries / Definitions / Settings tabs on the collection page;
  View / Export tabs on a single library page.
- Action link (`.links.action.yml`): *Add library definition* on the definition collection.
