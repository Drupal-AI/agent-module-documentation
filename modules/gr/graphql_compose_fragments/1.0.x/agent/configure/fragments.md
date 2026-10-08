<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — admin form & fragment generation

## Route & access

- Route: `graphql_compose.fragments` → path `/admin/config/graphql_compose/fragments`
  (`_admin_route: TRUE`), also the module's `configure` link.
- Access: `_permission: "administer graphql configuration"` (defined by GraphQL Compose,
  not by this module). It is a local task tab (`graphql_compose.settings.fragments`, weight 5)
  under the GraphQL Compose settings page.
- Form class: `Drupal\graphql_compose_fragments\Form\FragmentsForm` (extends `ConfigFormBase`,
  editable config `graphql_compose.settings`).

## What the form shows

`FragmentsForm::buildForm()` calls `FragmentManager::getTypes()`, maps each type through
`FragmentManager::getFragment()`, then splits the result into two `details` groups:

- **Union Types** — fragments whose `type` is a `UnionType`.
- **Object Types** — fragments whose `type` is an `ObjectType`.

Each group renders with the `graphql_compose_fragments` theme hook
(`templates/graphql-compose-fragments.html.twig`), one `<details class="fragment">` per
fragment containing the fragment `content` inside `<code><pre>` for copy-paste. The
`graphql_compose_fragments/fragments` library (`css/fragments.css`) styles it. A status
message repeats the maintainers' caveat: *"These fragments are intended as a guide, not a
solution."*

The form writes **nothing** to disk — it is a read-only display you copy from.

## The one setting

- `#type => checkbox` "Enable fragments on schema" → on submit,
  `submitForm()` saves `graphql_compose.settings:settings.fragments_enabled`
  (`$form_state->getValue('enabled') ?: FALSE`) and calls `_graphql_compose_cache_flush()`.
- Default: **unset / FALSE** (verified: `drush cget graphql_compose.settings
  settings.fragments_enabled` → `null` on a fresh install).
- Config schema for this key is added by `graphql_compose_fragments_config_schema_info_alter()`
  as a boolean on `graphql_compose.settings`'s `settings` mapping. This is the module's only
  config contribution (`provides_config_schema: true`).

Enabling it only affects the schema (see [api/schema.md](../api/schema.md)); the admin form
itself always lists fragments regardless of the toggle.

## How fragments are generated (`FragmentManager`)

Service `graphql_compose_fragments.manager` (autowire alias
`Drupal\graphql_compose_fragments\FragmentManager`), constructed with
`@graphql_compose.schema_type_manager` and `@graphql_compose.entity_type_manager`.

- `getTypes()` — registers all entity types, loads all schema type definitions, then collects
  every `ObjectType` and `UnionType`, merges in object **extensions** (so extended fields
  appear), `ksort`s and returns them.
- `getFragment(Type)` — returns `['type','name','content','entity','bundle','dependencies']`.
  `name` is the prefix `Fragment` + the type name (e.g. `FragmentNodePage`). `content` is the
  fragment string `fragment FragmentNodePage on NodePage { … }`. `entity`/`bundle` come from an
  entity map keyed by SDL type name.
- `getFragmentContent(Type)` — for a union, spreads each member as `... FragmentMember`; for an
  object, lists scalar fields by name and, for object/union-typed fields, nests
  `field { ...FragmentFieldType }`. A field whose type equals its own parent emits
  `# Recursion. Use best judgement or define manually`. `dependencies` is the de-duplicated list
  of referenced fragment names.
