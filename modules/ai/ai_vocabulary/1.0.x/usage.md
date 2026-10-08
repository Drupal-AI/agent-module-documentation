<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Vocabulary generates Drupal taxonomy vocabularies and their terms from a natural-language prompt using the AI module's configured provider.

An editor opens the generation form at `/admin/structure/taxonomy/ai-vocabulary`, describes the vocabulary they want, and the module builds a prompt (`PromptBuilder`), calls the AI provider (`AIService`), and imports the returned structure into taxonomy (`TaxonomyImporter`, using core transliteration for machine names). The default provider and generation defaults are set on the settings form at `/admin/config/ai/ai-vocabulary`. Generation is gated on `generate ai vocabulary`; configuration on `administer ai vocabulary` (restricted). Because a generated vocabulary is created directly in taxonomy, treat the generate permission as content-structural and grant it to trusted editors.

Use it to bootstrap category trees, tag sets, and controlled vocabularies quickly, then refine the imported terms by hand.
---
Generates Drupal taxonomy vocabularies and terms from a natural-language prompt via the AI module.
---
- Generate a new vocabulary from a plain-language description
- Produce a hierarchical set of taxonomy terms with one prompt
- Bootstrap a category tree for a new content type
- Create a tag/keyword vocabulary for articles
- Set the default AI provider for generation on the settings form
- Configure generation defaults (depth, term count) for editors
- Grant "generate ai vocabulary" to trusted content editors
- Restrict provider configuration behind "administer ai vocabulary"
- Import AI-suggested terms into an existing vocabulary
- Rely on transliteration for clean term machine names
- Draft a controlled vocabulary before manual refinement
- Generate localized term labels for a topic area
- Speed up initial IA / taxonomy modelling
- Regenerate a vocabulary with a refined prompt
- Review and prune AI-suggested terms after import
- Seed faceted-search taxonomies quickly
