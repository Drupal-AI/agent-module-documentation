<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — AI Vocabulary

- **Settings:** `ai_vocabulary.settings` → `/admin/config/ai/ai-vocabulary` (perm `administer ai vocabulary`, restricted). Pick the default AI provider and generation defaults.
- **Generate:** `ai_vocabulary.generate` → `/admin/structure/taxonomy/ai-vocabulary` (perm `generate ai vocabulary`). Enter a prompt; the module builds it (`PromptBuilder`), calls the provider (`AIService` via `@ai.provider`), and imports terms (`TaxonomyImporter`).

Flow: prompt → `VocabularyGenerator` → AI provider → structured vocabulary/terms → taxonomy import (transliterated machine names). Generated vocabularies are created immediately; review terms after generation.
