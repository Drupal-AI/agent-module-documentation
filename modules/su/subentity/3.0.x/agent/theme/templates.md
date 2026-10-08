# Theming subentities

Implemented in `subentity.module`. The base theme hook is `subentity`, rendered by the shipped
`templates/subentity.html.twig` (a `<div{{ attributes }}>{{ content }}</div>` wrapper).

## How a subentity type gets a template automatically

- `subentity_theme()` registers the `subentity` hook (`render element` = `elements`) and one hook per
  discovered subentity type id, all using the `subentity` template.
- `subentity_theme_registry_alter()` maps each subentity type's theme hook to the `subentity`
  template entry when the type does not already define its own.
- Subentity types are discovered by `_subentity_get_subentity_class()`, which scans all entity type
  definitions for classes that are subclasses of `SubEntityBase` (statically cached).

## Preprocess and template suggestions

- `subentity_preprocess()` (runs for subentity hooks only) adds a CSS class
  `Html::cleanCssIdentifier($hook)` to `attributes.class` and copies each child of `elements` into
  `content[<key>]`.
- `subentity_theme_suggestions_alter()` adds, for a rendered `SubEntityBase`:
  - `<hook>`
  - `<hook>__<view_mode>` (when a view mode is set)
  - `<hook>__<bundle>` (when bundle is not the literal `subentity`)
  - `<hook>__<bundle>__<view_mode>`

## Overriding

To fully control markup, define your own `hook_theme` entry, preprocess and Twig template for the
type instead of relying on the auto-registered `subentity` template (as noted in the module README).

Note: 3.0.x changed how custom subentity-type templates are declared (since `3.0.0-rc3`) and the CSS
class naming for custom types (since `3.0.0-rc4`); the project links change records for both.
