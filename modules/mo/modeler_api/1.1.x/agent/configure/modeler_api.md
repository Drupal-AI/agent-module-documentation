# Configuration, storage, permissions, Drush

## Settings form

Route `modeler_api.settings` → `/admin/config/workflow/modeler_api` (form
`Drupal\modeler_api\Form\Settings`, permission `administer site configuration`). Menu path:
**Admin → Configuration → Workflow → Modeler API**. For each model-owner / modeler combination you
choose a **theme** and a **storage** mode.

Config object `modeler_api.settings` (schema `config/schema/modeler_api.schema.yml`):

```yaml
owner_modeler:
  <owner_id>:
    <modeler_id>:
      theme: <string>
      storage: <string>   # validated against Settings::validStorageOptions()
```

Models themselves are config entities `modeler_api.data_model.*` (`id`, `data`). Raw modeler data
may also be stored as the `model_settings.third_party.modeler_api` third-party setting
(`modeler_id`, …). `provides_config_schema` is true.

## Three storage strategies

Raw modeler data (XML/JSON) is stored per owner/modeler combination as one of:

1. **Third-party settings** on the config entity.
2. A **separate config entity**.
3. **Not stored** at all (re-derived from the entity).

The model owner sets `defaultStorageMethod()` and may pin it with `enforceDefaultStorageMethod()`
(TRUE = user cannot change it). `ModelOwnerInterface::storageMethod()` / `storageId()` resolve the
effective choice per model.

## Permissions

Static permission: **`administer modeler_api`** (`modeler_api.permissions.yml`). The rest are
**dynamic**, generated per model owner and per modeler/owner combo by
`Drupal\modeler_api\ModelerApiPermissions::permissions()` (permission_callback) — up to 11 per owner
(administer, view collection, edit, delete, view, edit metadata, switch context, test, replay,
create templates, edit templates) plus 2 per modeler/owner combination. All are enforced on the
auto-generated routes.

## Routes, UI and param converter

Routes are generated dynamically by `Drupal\modeler_api\Routing\Routes::routes` (route_callbacks) —
up to 18 admin routes per owner (collection, add, edit, delete, enable, disable, clone, import,
export, settings, …) plus 3 per modeler/owner combo. Local tasks, local actions and menu links are
produced by the derivers under `src/Plugin/Derivative/`. Static routes also include HTMX endpoints
`modeler_api.global_tokens`, `modeler_api.template_tokens`, and `modeler_api.apply_template`.

## Drush commands

Attribute-based commands in `src/Drush/Commands/ModelerApiCommands.php`:

- `drush modeler_api:update` — update all models if their plugins changed.
- `drush modeler_api:disable <owner_id>` — disable all models of an owner.
- `drush modeler_api:enable <owner_id>` — enable all models of an owner.
- `drush modeler_api:model:export <owner_id> <id>` — export a model as a recipe.
  Options: `--namespace=<vendor>` (composer package prefix), `--destination=<path>` (output dir).

## Install note

The module does nothing on its own. Enable at least one model owner and one modeler, e.g.
`composer require drupal/eca drupal/bpmn_io && drush en eca_ui bpmn_io`.
