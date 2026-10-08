<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Translate Plus extends AI Translate so translation prompts and models can vary per entity type, bundle and language, with Core token and Twig context from the entity, plus per-field translation exclusions.

---

AI Translate Plus builds on the **AI Translate** submodule of Drupal AI, whose out-of-the-box
behavior is a single prompt per language. This module makes prompt and model selection contextual:
per entity type, per bundle and per target language, resolved most-specific-first. It integrates
Core **replacement tokens** (following entity references) and gives the **entity itself** to Twig
when the prompt is rendered, so instructions can depend on real field values (e.g. "do not translate
the manufacturer name"). It can also **disable translation for chosen fields** per bundle. It works
by decorating AI Translate's text-extractor and text-translator services, overriding the translate
controller to carry the extra context through the batch, and adding a `chat_translation_plus` AI
provider that resolves and renders the contextual prompt/model. Configuration lives in
`ai_translate_plus_settings` config entities (one per entity type). It adds one permission,
`manage ai translate plus prompts`. Translation is performed by the AI provider AI Translate/AI is
configured to use.

Use it to:

- Give each content type/bundle its own translation prompt.
- Vary the translation prompt per target language.
- Use a different AI provider/model per bundle or per language.
- Set an entity-type default prompt and override it per bundle.
- Set an entity-type default model and override it per bundle/language.
- Exclude specific fields (e.g. path alias) from AI translation per bundle.
- Insert Core tokens from the translated entity into the prompt (`[node:title]`, etc.).
- Follow entity references in tokens (e.g. a referenced manufacturer's name).
- Render prompts as Twig with the entity available in context.
- Narrow translation context via taxonomy on the entity.
- Keep brand names or domain terms untranslated by prompt instruction.
- Auto-accept some fields' translations while treating others differently.
- Reuse AI Translate's one-click translate action with richer prompts.
- Fall back to AI Translate's default prompt/model when no override matches.
- Configure everything from an admin overview + per-entity-type form.
- Restrict who can manage prompts via the module permission.
- Route content-type-specific translations to context-tuned models.
- Improve translation quality for ambiguous terms (e.g. "Apple" the fruit vs. brand).
- Layer contextual prompts on top of Drupal AI without patching AI Translate.
