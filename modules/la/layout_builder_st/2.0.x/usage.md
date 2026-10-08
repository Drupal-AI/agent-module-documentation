Layout Builder Symmetric Translations lets editors translate the content of a Layout Builder **override** (per-entity layout) — inline block text and translatable component/block labels — while keeping the same layout structure across every language ("symmetric": all translations share one set of sections/components).

---

Core Layout Builder does not support translating per-entity layout overrides; this module fills that gap. On install (and whenever a bundle gets Layout Builder overrides enabled) it adds a locked, translatable field `layout_builder__translation` (field type `layout_translation`) to the bundle to store the translated labels/config alongside core's `layout_builder__layout` field. It works by decorating and replacing several core services and plugins rather than adding config UI: it swaps the `entity_view_display` entity class (`LayoutBuilderEntityViewDisplay`) so the translation field is created automatically, replaces the `overrides` section storage (`OverridesSectionStorage`) with a translatable one, replaces the `inline_block` block plugin and the `layout_builder_widget` field widget, decorates the core `class_resolver`, and adds a route subscriber plus an event subscriber (`ComponentPluginTranslate`) that swaps in translated component configuration for the active language. It contributes two routes — `layout_builder.translate_block` and `layout_builder.translate_inline_block` — reached from the Layout Builder UI when editing a non-default translation, gated by a custom `_layout_builder_translation_access` check. There is **no settings form and no configure route**; you enable it by turning on Layout Builder overrides for a bundle and enabling content translation, then editing a translation's layout. It is mutually exclusive with Layout Builder Asymmetric Translations (`layout_builder_at`) — installing both raises a requirements error. Because layouts stay symmetric, structural edits made in one language are shared by all; only translatable strings differ per language.

---

- Translate the text inside an inline block placed in a node's Layout Builder override.
- Provide per-language labels for components/blocks in an overridden layout.
- Keep one layout structure for a page while offering it in multiple languages.
- Let editors translate a landing page's Layout Builder content without duplicating the layout.
- Translate inline-block bodies on a per-entity basis across languages.
- Offer a multilingual homepage built with Layout Builder overrides.
- Avoid maintaining separate layouts per language (symmetric model).
- Add the `layout_builder__translation` storage automatically when overrides are enabled on a bundle.
- Ensure the correct translated component config renders for the current language at view time.
- Translate a promotional/marketing node's blocks for each locale.
- Support content translation workflows on Layout-Builder-driven content types.
- Reuse a single set of sections/components while swapping only translatable strings.
- Provide a "Translate block" action in the Layout Builder UI for translators.
- Migrate a monolingual Layout Builder site to multilingual without rebuilding layouts.
- Keep structural layout changes in sync across all translations by design.
- Translate custom (content) inline blocks via the block_content `layout_builder_translate` form.
- Give translators access limited to translating (not restructuring) an overridden layout.
- Serve translated inline-block content on the canonical entity page per language.
- Combine with core content translation to translate both fields and layout content.
- Replace hand-rolled per-language layout duplication with a supported symmetric approach.
- Pair Layout Builder overrides with multilingual editorial teams needing localized copy.
