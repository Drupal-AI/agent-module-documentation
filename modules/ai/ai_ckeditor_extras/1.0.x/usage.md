<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI CKEditor Extras adds AI-powered authoring tools to Drupal's CKEditor: paraphrasing, tone rewriting, Flesch reading-ease scoring and FAQ generation.

---

The module provides four `AiCKEditor` plugins (`Paraphrasing`, `Tone`, `FleschScore`, `Faq`) that plug into the AI CKEditor toolbar. Each plugin extends `ai_ckeditor`'s `AiCKEditorPluginBase`, builds a configuration form where an editor picks the AI provider/model (via the AI module's provider manager), and issues an `AiRequestCommand` to rewrite or analyse the selected text. The Tone plugin is driven by a taxonomy vocabulary of tone terms and stores its prompt in config; the FAQ plugin turns selected content into Q&A.

Because it builds on the `ai` and `ai_ckeditor` modules, all access is governed by CKEditor text-format access and the AI CKEditor plugin configuration — there are no custom routes, permissions or mutating endpoints in this module. Requests are dispatched to whichever AI provider you configure. The prompts are admin-configurable per plugin, so operators control what is sent to the LLM.

---
- Enable `ai`, `ai_ckeditor` and `ai_ckeditor_extras`
- Configure an AI provider (OpenAI, Ollama, etc.) in the AI module
- Add the AI tools to a text format's CKEditor toolbar
- Enable the Paraphrasing plugin and pick a provider/model
- Choose a paraphrasing mode (simplify, expand, restructure, synonymize)
- Enable the Tone plugin and select a tone vocabulary
- Let editors rewrite selections into a chosen tone of voice
- Customize the Tone change prompt (uses `{{ tone }}` placeholder)
- Enable the Flesch Score plugin to compute reading ease
- Rewrite text to improve its Flesch reading-ease score
- Enable the FAQ Generator to produce Q&A from content
- Restrict AI tools to specific text formats/roles via format access
- Review/adjust per-plugin prompts before production use
- Use the `AiGetCommand` drush/console command surface for testing
- Improve clarity and audience targeting without leaving CKEditor
