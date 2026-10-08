# Layout Builder Symmetric Translations — agent index

Translates the **content** (inline block text, translatable labels) of Layout Builder
per-entity **overrides**, keeping one shared layout structure across languages ("symmetric").
Depends on core `layout_builder`. **No settings form, no configure route, no permissions of its
own.** Incompatible with `layout_builder_at` (asymmetric). Works by decorating/replacing core
services and plugins.

- **Enable it and translate an override (workflow, the translation field, routes)** →
  [api/translating-layouts.md](api/translating-layouts.md)
- **What it overrides in core (services, plugins, classes) — for developers** →
  [extend/mechanism.md](extend/mechanism.md)

Key facts:
- Adds a locked, translatable field **`layout_builder__translation`** (field type
  `layout_translation`) to any bundle that has Layout Builder overrides enabled — created
  automatically (install hook + overridden `entity_view_display` class).
- Routes: `layout_builder.translate_block`, `layout_builder.translate_inline_block`
  (access check `_layout_builder_translation_access`).
- Requires the bundle to have overrides enabled (core `layout_builder__layout` field) and
  content translation enabled; then edit a non-default translation's layout.
- Enabling it alongside `layout_builder_at` throws a requirements error (pick one).
