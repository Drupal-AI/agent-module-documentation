<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# content_singleton — types (bundles), config, frontend paths, routes & UI

Source: `src/Entity/ContentSingletonType.php`, `src/Form/ContentSingletonTypeForm.php`,
`config/schema/content_singleton.schema.yml`, `content_singleton.routing.yml`,
`src/PathProcessor/ContentSingletonPathProcessor.php`, `src/Routing/*`,
`src/Controller/ContentSingletonAddController.php`, `src/Controller/ContentSingletonRevisionController.php`,
`content_singleton.links.*.yml`.

## Install / enable

`composer require drupal/content_singleton` then `drush en content_singleton`. No dependencies;
PHP 8.3, core `^11`. There is **no global settings form** (`configure` is null); all configuration is
per bundle type.

## The bundle config entity

`ContentSingletonType` (`#[ConfigEntityType(id: 'content_singleton_type', config_prefix: 'type')]`,
`ConfigEntityBundleBase`, `bundle_of: 'content_singleton'`). Config object name:
`content_singleton.type.<id>`. `config_export` / schema (`content_singleton.type.*`,
`FullyValidatable`):

| key | type | meaning |
|-----|------|---------|
| `id` | machine_name | bundle machine name |
| `label` | required_label | human name |
| `description` | text (nullable) | admin description |
| `path` | string | frontend path; empty → the machine name is used |
| `revision` | boolean | create a new revision by default |

Accessors: `getDescription()`, `getPath()`, `shouldCreateNewRevision()` (+ setters). On `postSave`
and `postDelete` the type calls `router.builder->rebuild()` because paths affect URLs.

`ContentSingletonTypeForm` (`BundleEntityFormBase`, `@internal`) renders label / machine name /
description / **Frontend path** / **Create new revision**, plus core language settings when the
`language` module is on. `copyFormValuesToEntity()` unsets an empty `description` (an empty string
violates the schema).

## Frontend clean paths (path processor)

There is **no dynamically generated frontend route**. `ContentSingletonPathProcessor` (service
`content_singleton.path_processor`, tagged inbound + outbound, priority 200) builds a lazy map from
each type's `path` (or `id`) to the canonical `/content-singleton/{id}` of that bundle's single
entity, then:
- **inbound**: rewrites `/{clean-path}` → `/content-singleton/{id}` before routing, so the canonical
  route's access checks / local tasks apply (same pattern as path aliases).
- **outbound**: rewrites `/content-singleton/{id}` → `/{clean-path}`.

Map building queries entities with `accessCheck(FALSE)` (path-map construction only; the canonical
route still enforces entity `view` access) and swallows exceptions during partial bootstrap. Only
bundles that already have an entity get a map entry. `ContentSingletonRouteSubscriber::alterRoutes()`
is intentionally a **no-op** (documents the old dynamic-route approach that the path processor
replaced).

## Routes (`content_singleton.routing.yml` + route providers)

Custom routes:
- `entity.content_singleton.add_page` — `/content-singleton/add`; `_permission: administer content
  singletons` **and** `_content_singleton_add_access: TRUE` (service `access_check.content_singleton.add`
  → `ContentSingletonAddAccessCheck`, allowed only while `hasAvailableBundles()` is true).
- `entity.content_singleton_type.collection` — `/admin/structure/content-singleton`;
  `administer content singletons`.
- `entity.content_singleton.version_history` / `.revision` / `.revision_revert_form` /
  `.revision_delete_form` — revision routes gated by `_entity_access` on the matching operation
  (`view all revisions`, `view revision`, `revert revision`, `delete revision`); id constrained to
  `\d+`.

Entity CRUD routes come from `ContentSingletonRouteProvider` (extends `DefaultHtmlRouteProvider`;
marks edit/delete `_admin_route`). Type routes come from `AdminHtmlRouteProvider`; a per-bundle
permissions tab comes from core `EntityPermissionsRouteProvider`
(`/admin/structure/content-singleton/manage/{type}/permissions`). Menu/action/task links live in
`content_singleton.links.menu.yml` (Structure link), `.links.action.yml` (Add type / Add singleton),
`.links.task.yml` (Singletons tab under admin content; View/Edit/Delete tabs).

## Controllers

- `ContentSingletonAddController::addPage()` (`/content-singleton/add`): loads all types; if none,
  links to create one; filters to bundles without an entity (`ContentSingletonHelper::getExistingBundles()`);
  if none available, shows "all types already have content"; if exactly one available, redirects to
  its add form; otherwise renders an `entity_add_list`, per-bundle add link gated by create access.
- `ContentSingletonRevisionController`: `revisionOverview()` (history table with revert/delete ops per
  per-bundle revision permissions), `revisionShow()`, `revisionPageTitle()`. Revert/delete use
  `ContentSingletonRevisionRevertForm` / `ContentSingletonRevisionDeleteForm`.
- `ContentSingletonViewController` exists in source but **no route references it** — the canonical
  route renders the entity directly. Treat it as legacy/unused.

## Operating it

1. `/admin/structure/content-singleton` → **Add singleton type** (set label, machine name, optional
   path, revision default). 2. Manage fields / Manage display on the type edit form. 3. Set per-role
   access on the type's Permissions tab. 4. `/content-singleton/add` (or `/admin/content` → Singletons
   tab) to create the one instance. 5. Visit the type's path (e.g. `/about-us`) to view when published.
