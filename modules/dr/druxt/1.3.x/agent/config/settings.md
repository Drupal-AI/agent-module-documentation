<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Druxt settings — exposed JSON:API resources

## Install & enable

```bash
composer require drupal/druxt
drush en druxt -y
```

Pulls in `decoupled_router`, `jsonapi_menu_items`, `jsonapi_views` and core `jsonapi`. On install
`druxt_install()` runs `druxt_ensure_entity_view_displays()` so every bundle/view-mode has an
`entity_view_display` config entity. Then grant `access druxt resources` to the role (often
anonymous) the Nuxt frontend uses.

## The config object

`druxt.settings` (`config/install/druxt.settings.yml`) has one key, `resources`: a **sequence of
JSON:API resource type ids** in `entity_type--bundle` form. Default list (also hardcoded in
`druxt_default_resources()` in `druxt.module`):

```
block--block, configurable_language--configurable_language,
entity_form_display--entity_form_display, entity_form_mode--entity_form_mode,
entity_view_display--entity_view_display, entity_view_mode--entity_view_mode,
field_config--field_config, field_storage_config--field_storage_config,
jsonapi_resource_config--jsonapi_resource_config, menu--menu,
menu_link_content--menu_link_content, view--view
```

All are **configuration entities** except `menu_link_content`, a content entity kept for
backward compatibility (`druxt_grandfathered_resources()`).

Schema (`config/schema/druxt.schema.yml`): `druxt.settings` is a `config_object`; each `resources`
item is a `string` carrying the `DruxtResource` constraint.

## The settings form

`DruxtSettingsForm` (`src/Form/DruxtSettingsForm.php`), route `druxt.settings` at
`/admin/config/services/druxt`, permission `administer druxt` (*Configuration → Web services →
Druxt*). A `checkboxes` element lists resources.

- **Options** — `resourceOptions()` walks `jsonapi.resource_type.repository`, skips internal resource
  types and any that fail `druxt_resource_is_allowed()`, so **only configuration-entity resources are
  offered** (plus grandfathered `menu_link_content`).
- **Default value** — `storedResources()` (the raw stored list, *not* `druxt_resources()`, so the
  alter hook's additions/removals are never persisted).
- **Submit** — merges the chosen resources with any **stored-but-not-offered** resource (a resource
  for a module not installed here is kept, so saving on a site without Views does not strip
  `view--view` from a shared config set), sorts, saves. If a default resource was removed, adds a
  warning naming it ("A frontend that reads them will stop rendering that part of the site.").

## How the list is resolved at runtime

`druxt_resources()` (`druxt.module`): read `druxt.settings:resources`, fall back to
`druxt_default_resources()` when unset (a site updated from a hardcoded release has no config yet),
`array_filter` through `druxt_resource_is_permitted()` (drops a resource whose entity type exists but
is not a config entity / grandfathered; keeps one whose entity type is absent), then invoke
`hook_druxt_resources_alter()`. See [api/resources.md](../api/resources.md).

## Config import guard

`DruxtConfigImportSubscriber` (subscribes to `ConfigEvents::IMPORT_VALIDATE`, priority 20) validates
an imported `druxt.settings` in **every** collection with the typed-config `DruxtResource` constraint
and logs an importer error for each violation — because Drupal runs no schema constraints on save or
import by itself. See [api/resources.md](../api/resources.md).

## Status report

`hook_requirements()` (`druxt.install`) checks the resources in `druxt_required_resources()` (=
`druxt_resources()`): skips entity types this site lacks, reports any that are **missing** a JSON:API
resource type, and any that are **disabled/internal** (linking to the JSON:API Extras edit form when
that module is present) as warnings.
