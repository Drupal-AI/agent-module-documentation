<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Asymmetric Translation lets every translation of an entity have its **own** Layout Builder override — different sections, different blocks, different order per language.

---

Layout Builder stores per-entity overrides in the multi-value `layout_builder__layout` field of type `layout_section`. Core keeps that field non-translatable, so all translations share one layout. This module makes it translatable: `hook_ENTITY_TYPE_presave()` on `field_storage_config` flips `setTranslatable(TRUE)` on any `layout_section` storage named `layout_builder__layout`, and `hook_install()` re-saves the existing ones so already-configured sites are converted. It then removes the obstacles core puts in the way — `hook_layout_builder_section_storage_alter()` swaps the `overrides` section storage class for `TranslatableOverridesSectionStorage`, whose only change is to neutralise `handleTranslationAccess()` so the *Layout* tab is reachable on a translation; `hook_module_implements_alter()` and a `hook_theme_registry_alter()` remove Layout Builder's own form alter and the "Non translatable" warning on the Content Language settings page; and a service provider replaces `layout_builder.get_block_dependency_subscriber` with a translation-aware subscriber. For editors it ships one field widget, `layout_builder_at_copy` ("Layout Builder Asymmetric Translation"), which you place on `layout_builder__layout` in *Manage form display*: it shows a **"Copy blocks into translation"** checkbox on the *add translation* form and, when ticked, deep-clones every section — duplicating inline `block_content` entities, keeping only the new translation's language, registering inline-block usage and assigning fresh component UUIDs — so the translation starts from a copy instead of an empty layout. Its single setting, `appearance`, controls whether that checkbox is `unchecked`, `checked`, or `checked_hidden`. New inline blocks added inside Layout Builder are automatically stamped with the entity's language unless `$settings['layout_builder_at_set_content_block_language_to_entity'] = FALSE;` is set in `settings.php`. It is mutually exclusive with Layout Builder Symmetric Translations (`layout_builder_st`).

---

- Give the German translation of a page a different section order than the English one.
- Add a language-specific promo block that only exists on the French translation.
- Remove a block from one translation without affecting the others.
- Start a new translation from a copy of the source layout with one checkbox.
- Force every new translation to be pre-populated by setting the widget appearance to `checked_hidden`.
- Let editors decide per translation whether to copy blocks, using the `unchecked` default.
- Duplicate inline (non-reusable) blocks per language so their text can be translated independently.
- Keep reusable block placements identical while translating only the inline content.
- Convert an existing Layout Builder site to asymmetric translations — install makes existing layout fields translatable.
- Reach the *Layout* tab on a translation route, which core normally blocks.
- Build per-market landing pages that share a URL structure but not a layout.
- Let a right-to-left language use a different column arrangement.
- Give one language a shorter layout by deleting sections only in that translation.
- Stop the "Non translatable" warning appearing for the layout field on *Regional → Content language*.
- Assign the entity's language automatically to inline blocks created in Layout Builder.
- Opt out of that automatic language assignment through a `settings.php` flag.
- Clean up per-translation Layout Builder tempstore entries when a translation is deleted.
- Copy a layout from a chosen source language when the translation form offers `source_langcode`.
- Preserve entity-reference-revisions sub-entities when cloning inline blocks (paragraphs inside a block).
- Audit which bundles have asymmetric layouts by checking `layout_builder__layout` translatability.
- Prevent editors from re-selecting the core Layout Builder widget once asymmetric translation is on.
- Choose asymmetric (this module) over symmetric (`layout_builder_st`) when languages need different structures.
- Deploy the widget choice through configuration as part of `core.entity_form_display.*`.
- Give a translation its own hero image block while the default language keeps a video block.
