<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI CKEditor Extras — plugins

Four `#[AiCKEditor(...)]` plugins under `src/Plugin/AiCKEditor/`, each extending `Drupal\ai_ckeditor\AiCKEditorPluginBase`:

- **Paraphrasing** (`ai_ckeditor_paraphrasing`) — rewords a selection; config: `provider`, `paraphrasing_mode`.
- **Tone** (`ai_ckeditor_tone`) — rewrites selection into a tone from a chosen taxonomy vocabulary; config includes an editable `prompts.tone` prompt with a `{{ tone }}` placeholder and optional autocreate of terms.
- **FleschScore** — computes Flesch Reading Ease and can rewrite to improve it.
- **Faq** — generates FAQ Q&A from selected content.

Each plugin's `buildConfigurationForm()` pulls provider/model options from `aiProviderManager->getSimpleProviderModelOptions('chat')`. Enable the plugins on a text format's CKEditor toolbar; access follows that format's permissions.
