<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — default_content_tools.settings

Install/enable: `drush en default_content_tools -y`. No module dependencies in `*.info.yml`; the
`recipe_tracker` integration is optional and only affects the catch-up subscriber (see
[../api/deletion.md](../api/deletion.md)).

## Config object

`default_content_tools.settings` (a `config_object`). Install defaults come from
`config/install/default_content_tools.settings.yml`:

```yaml
suppress_import: false
delete_recipes: []
```

Schema (`config/schema/default_content_tools.schema.yml`):

- `suppress_import` — `boolean`. When TRUE, the `DefaultContentImport` PreImportEvent subscriber
  skips **all** discovered default-content items by UUID, so nothing is imported.
- `delete_recipes` — `sequence` of `string` (recipe machine names). Each listed recipe has its
  content deleted automatically when it finishes applying (`RecipeContentCleanup`), and — when
  `recipe_tracker` is installed — also swept from the tracker log (`RecipeTrackerCatchup`).

## Settings form

`Drupal\default_content_tools\Form\SettingsForm` (a `ConfigFormBase`, form id
`default_content_tools_settings`), route `default_content_tools.settings` at
`/admin/config/content/default-content-tools`, permission **`administer site configuration`**.
Menu link `default_content_tools.settings` (title "Default Content Tools") under
`system.admin_config_content` (Configuration > Content authoring).

The form exposes a single checkbox, **"Suppress Default Content Import"**, bound to
`suppress_import`. `getEditableConfigNames()` returns `['default_content_tools.settings']`;
`submitForm()` writes `suppress_import` and saves. The `delete_recipes` list is **not** editable
from this form — it is managed by recipes via the config actions
([../plugins/config-actions.md](../plugins/config-actions.md)) or by direct config edit/import.

## Managing the deletion list in config

Because `delete_recipes` is plain config, it can be set in a config-managed deployment, e.g.:

```yaml
# default_content_tools.settings.yml
suppress_import: false
delete_recipes:
  - my_demo_catalogue
```

Prefer the `markRecipeContentForDeletion` / `unmarkRecipeContentForDeletion` config actions when a
recipe needs to add/remove one entry without clobbering entries other recipe layers added.
