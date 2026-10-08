<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & route

## Install

```bash
composer require drupal/entity_is_public   # pulls drupal/helper >= 1.50
drush en entity_is_public -y
```

Only runtime dependency is `helper`. Integrations (media, metatag, xmlsitemap, rabbit_hole,
field_redirection, micronode, trash, path) activate automatically when those modules are present;
they are `require-dev`/`test_dependencies` only, not hard requirements.

## Settings form

- Route **`entity_is_public.settings`** → path **`/admin/config/system/entity-is-public`**,
  `_form: \Drupal\entity_is_public\Form\SettingsForm`, requirement
  `_permission: 'administer site configuration'` (`entity_is_public.routing.yml`).
- Menu link under *Configuration → System* (`entity_is_public.links.menu.yml`).
- Class `SettingsForm` extends `ConfigFormBase`, form id `entity_is_public_settings`, edits config
  `entity_is_public.settings`.

Form fields:

- **`entity_types`** — a `checkboxes` element listing every entity type for which
  `EntityIsPublic::isApplicableType()` returns TRUE (labels natsorted). Bound with a `ConfigTarget`:
  `getEntityTypeDefaultValue()` fills defaults for unknown types by calling `isTypePublic()`, and
  the save callback maps values with `boolval`.
- **`require_alias`** (in a "Logic" details group) — checkbox bound to
  `entity_is_public.settings:require_alias`; its description lists entity types that have a `path`
  field. Consumed by the `path` integration hook.
- **Reset button** ("Reset and recalculate default public entity types", `::resetEntityTypes`) —
  rewrites `entity_types` from `getEntityTypeDefaultValue([], FALSE)` and clears cached entity-type
  definitions.

`submitForm()` calls `entityTypeManager->clearCachedDefinitions()` so the reseeded `public`
property (applied via `entity_type_alter`) takes effect (works around core issues 3001284 / 3013659).

## Config object `entity_is_public.settings`

Install defaults (`config/install/entity_is_public.settings.yml`):

```yaml
entity_types: {}
require_alias: false
```

Schema (`config/schema/entity_is_public.schema.yml`, `FullyValidatable`):

- `entity_types` — sequence of booleans keyed by entity-type id ("Public status").
- `require_alias` — boolean.

When `entity_types` is empty, per-type public status is computed from eligibility + anonymous
access (see [../api/service.md](../api/service.md)); ticking/unticking a box stores an explicit
boolean that `entity_type_alter` then applies to the type's `public` property.

## Cache invalidation

`entity_is_public.services.yml` registers `entity_is_public.settings_cache_subscriber` (helper's
`ConfigCacheTagInvalidator`) to invalidate the `entity_types` cache tag whenever
`entity_is_public.settings` is saved.
