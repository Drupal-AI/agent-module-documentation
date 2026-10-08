# FooTable — global settings, breakpoints, permission, libraries

## Permission
`administer footable` (`footable.permissions.yml`) — gates the settings form, the breakpoint
collection/add/edit/delete routes, and is the `admin_permission` of the `footable_breakpoint` entity.
It is a normal (non-`restrict access`) config permission.

## Global settings form
Route `footable.settings` at `/admin/config/user-interface/footable/settings`, form
`src/Form/FooTableConfigForm.php`, config object `footable.settings`:
- `plugin_type` — radios `standalone` | `bootstrap` (default `standalone`).
- `plugin_compression` — radios `minified` (production) | `source` (development); default `minified`.

These two combine to pick the attached library `footable/footable_<plugin_type>_<plugin_compression>`
(see `FooTable::getLibrary()` and `template_preprocess_views_view_footable()`).

## Breakpoint config entity
`footable_breakpoint` (`src/Entity/FooTableBreakpoint.php`, `@ConfigEntityType`). Keys: `name` (id),
`label`, `breakpoint` (int px). Managed at `/admin/config/user-interface/footable` (collection),
add/edit form `src/Form/FooTableBreakpointForm.php` (label, machine name, breakpoint number in px).
Shipped defaults (`config/install/`): `xs`=480, `sm`=768, `md`=992, `lg`=1200. All breakpoints are
emitted to every FooTable as `data-breakpoints='{"xs":480,...}'` (JSON), and each Views column can be
assigned to collapse at one or more of these breakpoints.

## Asset libraries (`footable.libraries.yml`)
- `footable/footable` — the Drupal glue JS (`js/footable.js`) + core/jquery/once.
- `footable/footable_standalone_(source|minified)` and `footable/footable_bootstrap_(source|minified)`
  — load `/libraries/footable/compiled/footable(.min).js` and the matching CSS.

The FooTable jQuery plugin is NOT bundled — download the 3.x release from
`github.com/fooplugins/FooTable` into `libraries/footable/` (or `composer require fooplugins/footable`
via a custom package repo, per the README). The Bootstrap variant additionally needs Bootstrap CSS;
the standalone variant needs Font Awesome for its icons.

## Config schema
`config/schema/footable.schema.yml` types `footable.settings`, `footable.footable_breakpoint.*`, and
`views.style.footable` (all the Views style options — see configure/views-style.md).
