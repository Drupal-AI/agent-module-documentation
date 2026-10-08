<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Vocabulary (ai_vocabulary) — agent index

**Generates Drupal taxonomy vocabularies and terms from a natural-language prompt using the AI module.**

- **Version:** 1.0.x (1.0.2)
- **Core:** ^10.3 || ^11
- **Depends on:** taxonomy, ai
- **Routes:** `ai_vocabulary.generate` → `/admin/structure/taxonomy/ai-vocabulary` (perm: `generate ai vocabulary`); `ai_vocabulary.settings` → `/admin/config/ai/ai-vocabulary` (perm: `administer ai vocabulary`)
- **Services:** `ai_vocabulary.prompt_builder`, `ai_vocabulary.ai_service`, `ai_vocabulary.vocabulary_generator`, `ai_vocabulary.taxonomy_importer`
- **Permissions:** `generate ai vocabulary`, `administer ai vocabulary` (restricted)
- **Security:** both routes permission-gated; the generate permission creates real taxonomy structure, so treat it as trusted-editor level. No anonymous or unauthenticated endpoints.

See [configure/settings.md](configure/settings.md)
