<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Developer Helper (seeds_development) — agent index

Developer-productivity utilities from the **Seeds** distribution. Adds admin tools onto core's
image-style and form-display screens. Package **Seeds**. Core `^10 || ^11`. License
GPL-2.0-or-later. Version **1.0.2**. Meant for **development/staging, not production**.

**No declared dependencies** (`info.yml` lists none, `composer.json` `require` is empty), but at
runtime it uses core **image** / **responsive_image** and the contrib **field_group** module
(`field_group_group_save()` is called directly by the generator). It also uses **language** for
the translate-fields form. Enable those before use.

- **Routes, controller actions, the permission, and how to operate each tool** →
  [tools/overview.md](tools/overview.md)
- **The image-style usage inspector service** → [api/inspector.md](api/inspector.md)

## What it provides (from source)

- **One permission:** `access seeds development` (`seeds_development.permissions.yml`) — gates every
  route.
- **Controller** `SeedsDevelopmentController` (`src/Controller/`) with actions:
  `inspectImageStyle`, `inspectAllImageStyle`, `generateFieldGroups`, `viewDisplayInspect` (a
  TODO stub), `testResponsiveImages`.
- **Service** `seeds_development.inspector` → `SeedsDevelopmentInspector` implements
  `SeedsDevelopmentInspectorInterface::imageStyleUseability()`; also a private logger channel
  `logger.channel.seeds_development`.
- **Form** `TranslateFieldsForm` (`src/Form/`, form id `seeds_translate_fields_form`) — per-bundle,
  per-language field-label editor; implements `TrustedCallbackInterface` (`preRenderTable`).
- **Local-action plugin** `SeedsLocalAction` + deriver `GroupsGeneratorLocalActions`
  (`src/Plugin/Derivative/`) — adds a "Generate Basic Groups" action on every entity type's
  default form-display screen.
- **Hooks** (`seeds_development.module`): `hook_help`, `hook_entity_operation_alter` (adds an
  "Inspect" op to image_style rows). Helper `create_inspect_operation()`.
- **Menu/task/action links** (`*.links.*.yml`): "Unused image styles" action on the image-style
  collection; a "Test" tab/task on the responsive-image-style collection.
- **Library** `seeds_development/responsive_image_style_test` (one CSS file). Bundled sample image
  `assets/images/test.jpg`. **No config objects, no config schema, no Drush, no submodules.**

## Routes (all `_permission: access seeds development`)

| Route | Path | Action |
|---|---|---|
| `seeds_development.image_style` | `/admin/config/media/image-styles/inspect/image-styles/{image_style}` | `inspectImageStyle` |
| `seeds_development.unused_image_style` | `/admin/config/media/image-styles/inspect/unused-image-styles` | `inspectAllImageStyle` |
| `seeds_development.generate_field_groups` | `/admin/config/structure/{entity_type_id}/{bundle}/{form_mode}` | `generateFieldGroups` |
| `seeds_development.view_mode` | `/admin/structure/{entity_type_id}/{bundle}/view-mode/{view_mode}` | `viewDisplayInspect` (stub) |
| `seeds_development.translate_fields` | `/admin/structure/{entity_type_id}/{bundle}/translate-fields` | `TranslateFieldsForm` |
| `seeds_development.test_responsive_images` | `/admin/config/media/responsive-image-style/test` | `testResponsiveImages` |
