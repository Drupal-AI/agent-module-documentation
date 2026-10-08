<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component blocks (component_blocks) — agent index

Bridges **UI Patterns 1.x** and core **Layout Builder**: derives one block per UI Patterns
component × content entity type, so a themed component can be dropped into a layout and have its
fields filled from the host entity (via a field + formatter) or from a fixed string with token
support. No settings page (`configure` is null); all configuration is per-block in the block form.

Depends on core `block`, `layout_builder` and contrib `ui_patterns` (composer pins
`drupal/ui_patterns ^1.0` — UI Patterns **1.x**, not the SDC-aligned 2.x). Core `^9.0 || ^10.0 || ^11`.

- **Understand/operate the derived block plugin, its derivative ids, context, config form and build pipeline** → [blocks/component-blocks.md](blocks/component-blocks.md)
- **Define a component (pattern) so it becomes a block; template variables, libraries, variants, settings, the field render theme hook** → [theme/patterns.md](theme/patterns.md)

Key facts:
- Block plugin id `component_blocks` (class `Drupal\component_blocks\Plugin\Block\ComponentBlock`),
  deriver `Drupal\component_blocks\Plugin\Deriver\ComponentBlockBlockDeriver`.
- Derivative id format: `component_blocks:<entity_type_id>:<pattern_id>` (one per content entity type × pattern).
  Derivatives carry `_block_ui_hidden: TRUE` and an `entity` context — usable in Layout Builder, not the plain block layout.
- Consumes `plugin.manager.ui_patterns` (does NOT define its own plugin type).
- Config schema: `block.settings.component_blocks:*:*` with keys `variant`, `variables` (per-field
  `type`/`source`/`value`/`settings`), `settings`; plus type `component_blocks.context_variable`.
- Fixed-value sentinel: constant `ComponentBlock::FIXED = '__fixed'` (the `source` value meaning "typed/token input").
- Theme hook `field__component_block` (base hook `field`, template `templates/field--component-block.html.twig`);
  `hook_theme_suggestions_block_alter` adds a `block__bare` suggestion outside Layout Builder.
- No routes, no permissions, no drush, no update hooks, no `.services.yml` (services injected from core/ui_patterns).
