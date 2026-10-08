# AI Vocabulary — manual setup guide

**AI Vocabulary** (`ai_vocabulary`) builds Drupal taxonomy vocabularies and their
terms from a plain‑language description, using whatever AI provider you have
configured in the AI module. Instead of clicking through the taxonomy UI to
create a vocabulary and hand‑type dozens of terms, an editor describes the
vocabulary they want — "a category tree for a recipe site", say — and the module
asks the AI provider to produce a structured set of terms and imports them
straight into taxonomy.

Behind the scenes it assembles a prompt, calls the AI provider, and imports the
returned structure as a real vocabulary with hierarchical terms, using core
transliteration to generate clean machine names. Because the result is created
directly in taxonomy, the "generate" permission is effectively
content‑structural — grant it only to trusted editors.

It is a bootstrapping tool: use it to draft a category tree, a tag set, or a
controlled vocabulary quickly, then review and prune the AI‑suggested terms by
hand. Generation runs through your AI provider, which has a per‑call cost.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the default AI provider and
   generation defaults, and the two permissions that gate the feature.

## Where it lives in the admin menu

- **Generate a vocabulary:** **Structure → Taxonomy → AI Vocabulary**
  (`/admin/structure/taxonomy/ai-vocabulary`), gated on `generate ai vocabulary`.
- **Settings:** **Configuration → AI → AI Vocabulary**
  (`/admin/config/ai/ai-vocabulary`), gated on `administer ai vocabulary`.

## How to use it

1. Make sure the AI module has a working provider (see Configuration).
2. Go to the generate form under Structure → Taxonomy → AI Vocabulary.
3. Describe the vocabulary you want in natural language and submit.
4. The module builds a prompt, calls the AI provider, and imports the returned
   terms as a new vocabulary.
5. Open the generated vocabulary in taxonomy and review, rename, or prune the
   terms before relying on it.
