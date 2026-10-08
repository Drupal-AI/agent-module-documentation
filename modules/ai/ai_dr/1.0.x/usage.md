<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Deep Reference adds Drupal tokens that expose the description text of taxonomy terms — including terms referenced from a node's entity-reference fields — so that text can be pulled into AI prompt templates and any other token-driven context.
---
Drupal's token system readily exposes a term's *name* but not a convenient path to the *description* of a term that a node references. AI Deep Reference closes that gap. It registers a `[term:description]` token for taxonomy terms and a dynamic `[node:term-description:FIELD_NAME]` token that walks a named entity-reference field on the node, collects the referenced terms' descriptions, and joins them with blank lines into a single string.

The module is implemented purely as token hooks (`hook_token_info`, `hook_token_info_alter`, `hook_tokens`, plus `hook_help`); it declares no routes, permissions, forms, services, entities, or configuration, and it has no settings page. Its only dependency is the contributed Token module. Although it was written for the AI ecosystem — to feed richer taxonomy context into prompts assembled from tokens — it is a generic token provider usable anywhere Drupal resolves tokens.
---
- Add a `[term:description]` token for taxonomy terms.
- Resolve a term's description wherever Drupal tokens are supported.
- Add the dynamic `[node:term-description:FIELD_NAME]` token for referenced terms.
- Pull descriptions from a node's entity-reference field into text.
- Join several referenced term descriptions into one blank-line-separated string.
- Feed taxonomy term context into an AI prompt template.
- Combine scene, character, and setting term descriptions for image generation.
- Build glossary-style prompt context from a controlled vocabulary.
- Enrich metatag templates with referenced term descriptions.
- Include term descriptions in mail/message token templates.
- Surface vocabulary text to token-driven automated workflows.
- Provide category context to an LLM summariser.
- Reach description text that core exposes only via `entity:description` chained tokens.
- Assemble multi-term prompts such as "Characters: [node:field_characters:0:entity:description]".
- Avoid writing custom code to expose term descriptions as tokens.
- Pair with the AI module and AI Automator for prompt-driven generation.
- Use term descriptions in Views token replacements.
- Keep prompt context automatically in sync as editors update term descriptions.
- Work with any node type whose fields reference a taxonomy vocabulary.
- Operate with no configuration — install, enable, and start using the tokens.
