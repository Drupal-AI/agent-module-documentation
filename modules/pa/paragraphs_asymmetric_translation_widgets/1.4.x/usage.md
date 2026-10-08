<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Asymmetric Translation Widgets extends the Paragraphs field widgets so that each language of a translated host entity can hold a completely different set of paragraphs (add, remove and reorder per language) instead of sharing one symmetric structure.

---

Out of the box, the Paragraphs module translates paragraphs *symmetrically*: every translation of a node shares the same paragraph items in the same order, and translators may only edit the field values inside each paragraph, not add, delete or reorder them per language. This module lifts that restriction. It ships a legacy inline widget `paragraphs_classic_asymmetric` (label "Paragraphs Legacy Asymmetric") and, through `hook_field_widget_info_alter`, transparently swaps the class behind the modern stable `paragraphs` widget to an asymmetric variant so both widgets let translators manage an independent paragraph set for each language. It relies on `hook_entity_translation_create` to recursively duplicate the source language's paragraph entities the moment a new translation is created, giving each language its own paragraph revisions to diverge from. The translatable paragraphs reference field (an `entity_reference_revisions` field targeting `paragraph`) must be set translatable for the behavior to engage. It depends on Paragraphs 1.15+ and core `content_translation`, and adds config schema for the classic widget's settings. Note the maintainer's own warning: switching an existing site's fields from non-translatable to translatable can soft-unlink previously attached paragraphs, so plan migrations carefully. There is no admin settings form; you enable the behavior purely by choosing the module's widget on a bundle's form display.

---

- Let editors build a page with three promo paragraphs in English but only one in German, without the other languages inheriting the extra items.
- Reorder paragraph sections differently per language (e.g. put the video block first in Japanese, last in English).
- Delete a paragraph in one translation while keeping it in the source language.
- Add language-specific call-to-action blocks that exist only in certain markets.
- Give each translation its own hero, body and gallery paragraphs that diverge freely over time.
- Migrate a symmetric multilingual Paragraphs site to a per-language editorial model.
- Support marketing landing pages where each locale has a bespoke component layout.
- Configure the legacy inline paragraphs form to support asymmetric translation via the `paragraphs_classic_asymmetric` widget.
- Configure the modern stable paragraphs form to support asymmetric translation (the module swaps its class automatically when the field is translatable).
- Let translators remove paragraphs that are irrelevant to their audience without affecting the original.
- Author region-specific FAQ accordions where each language answers different questions.
- Duplicate source-language paragraphs automatically as a starting point for a new translation, then edit independently.
- Keep a shared brand header paragraph while letting the body sections differ per language.
- Build multilingual case-study pages where the number of testimonial blocks varies by locale.
- Run a multilingual site where some languages are richer (more sections) than others.
- Provide independent image/caption paragraph sequences per language for culturally-adapted content.
- Let content teams in different countries fully own the paragraph structure of their translation.
- Combine with content moderation so each language's paragraph set follows its own editorial workflow.
- Avoid the "shared paragraph" pitfall where editing one translation's paragraph values leaks into another.
- Offer editors an "add mode" and "edit mode" (open/closed) UI on the asymmetric legacy widget just like the classic Paragraphs widget.
- Set a default paragraph type that is pre-added per language when a translator opens a new translation form.
- Support step-by-step multilingual tutorials where each language has a different number of steps.
- Enable per-language product-feature grids on a commerce catalog.
