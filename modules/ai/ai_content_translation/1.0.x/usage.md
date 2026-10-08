<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Translation generates translations of Drupal content entities (nodes, paragraphs and other referenced content) with OpenAI, on top of core's content_translation workflow.

---

AI Content Translation adds an "AI Translate to <language>" operation to translatable content and an "Add AI Translation" action on each entity's Translations tab. Picking a target language creates a new translation of the entity and fills it in field by field: the title, body, other text and string fields, and image alt/title attributes are each sent to OpenAI's chat-completions API with a configurable system prompt, and the returned text is written back into the translation while preserving each field's text format. The controller recurses through entity-reference and entity_reference_revisions fields (including Paragraphs) so structured content is translated as a unit, while file, media and taxonomy_term references and non-text fields (datetime, numeric, list) are skipped. A single settings form holds the OpenAI API key, model, system prompt, temperature, timeouts and logging options, all under the `administer ai content translation` permission. Source and translated text are sent to OpenAI, so weigh data sensitivity and per-request cost, and review machine output before publishing.

---

- Auto-generate a translation of a node into a target language from the content list's operations dropdown.
- Add an AI translation from the entity's Translations tab ("Add AI Translation" action).
- Use the "Generate AI Translation" button that appears on a translation add form.
- Translate the title and body of a node in one action.
- Translate additional text and string fields on an entity, not just title/body.
- Translate the alt and title attributes of image fields.
- Translate referenced Paragraphs and other referenced content entities recursively.
- Preserve each text field's format (e.g. full_html) when writing the translation.
- Choose the OpenAI model per site: GPT-4, GPT-4 Turbo or GPT-3.5 Turbo.
- Customise the system prompt to control translation tone, style and HTML handling.
- Tune translation determinism with the temperature setting (0.3 recommended).
- Raise request and connection timeouts for large content that takes longer to translate.
- Skip empty, whitespace-only and NULL field values automatically.
- Skip file, media and taxonomy_term references so only editorial text is translated.
- Skip datetime, numeric and list fields so structured data is left intact.
- Control log verbosity (errors only, normal, or verbose) for translation runs.
- Turn off text sampling in logs when translating sensitive content.
- Speed up multilingual content production while keeping human review in the loop.
- Restrict who can translate and configure with the `administer ai content translation` permission.
- Integrate with core content_translation without replacing its review UI.
- Warn editors when a translation already exists for the chosen language instead of duplicating it.
- Run on Drupal 10 or 11 sites that have content_translation enabled.
- Consider data sensitivity: source and translated text are sent to OpenAI.
- Account for per-translation API cost when translating in bulk.
