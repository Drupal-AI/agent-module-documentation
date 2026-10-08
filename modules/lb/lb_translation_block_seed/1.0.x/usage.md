<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Seeds Layout Builder layouts and clones inline blocks (and nested paragraphs) from the source language into new translations, with per-block push to translations.

---

LB Translation Block Seed automatically seeds a new translation's Layout Builder layout from the source language, cloning inline blocks (and any nested Paragraph entities) into language-specific copies so each translation can be edited independently without affecting the original.

When a translation is created, a hook handler invokes `LayoutSeeder`, which copies the source sections and components, uses `InlineBlockCloneService`/`ParagraphCloneService` to duplicate inline block content per language, and preserves component ordering and UUIDs; it integrates with `layout_builder_at` (async translation) and supports Content Moderation. Beyond initial seeding, editors can flag selected components on the source entity for push to one or more translations (`processPushedBlocks()` reads a `_push_translations` marker on the component's `additional` data and re-clones just those blocks). The single permission `push layout builder block translations` (restricted) gates the push feature.

Typical setup: enable the module (with its layout_builder_at dependency), grant the push permission to translators, then create translations — layouts seed automatically, and use the per-block push to propagate source changes.
---
- Seed a new translation's layout from the source language.
- Clone inline blocks into language-specific copies.
- Clone nested Paragraph entities inside inline blocks.
- Preserve section/component order and UUIDs across languages.
- Let translators edit blocks without touching the source.
- Re-seed a translated layout from the source on demand.
- Push selected inline-block updates to chosen translations.
- Maintain independent inline-block revisions per language.
- Integrate with Content Moderation workflows.
- Work with layout_builder_at asynchronous translation.
- Grant the push permission to specific roles.
- Keep translated layouts structurally in sync with source.
- Avoid sharing one inline block across all languages.
- Extend cloning behaviour via the service architecture.
- Support Drupal 10.3+ and 11.
