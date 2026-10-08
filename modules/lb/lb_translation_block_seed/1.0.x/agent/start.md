<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LB Translation Block Seed (lb_translation_block_seed) — agent index

**Seeds Layout Builder layouts and clones inline blocks (plus nested paragraphs) from the source language into new translations; supports per-block push to selected translations.**

- **Version:** 1.0.x — core `^10.2 || ^11`
- **Depends:** layout_builder, content_translation, language, layout_builder_at
- **Permission:** `push layout builder block translations` (restricted) — gates the source→translation push
- **Services:** `layout_seeder` (LayoutSeeder), `inline_block_clone`, `paragraph_clone`, `section_cloner`, `component_cloner`; hook handler `TranslationSeedHookHandler` runs on translation create.
- **Access:** no routes; push feature permission-gated.
