<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI CKEditor Extras (ai_ckeditor_extras) — agent index

**Adds AI-powered CKEditor tools — paraphrasing, tone, Flesch score, FAQ generation.**

- **Version:** 1.0.x (1.0.1), core `^10.3 || ^11`, package AI Tools
- **Depends on:** `ai:ai_ckeditor` (and the AI provider stack)
- **Plugins (`AiCKEditor`):** `Paraphrasing`, `Tone`, `FleschScore`, `Faq` (all extend `AiCKEditorPluginBase`, dispatch `AiRequestCommand`)
- **Config:** `ai_ckeditor_extras.settings` (per-plugin prompts, e.g. Tone prompt with `{{ tone }}`)
- **No custom routes or permissions** — access via CKEditor text-format access and AI CKEditor plugin config.
- **Security:** no anonymous or mutating endpoints; requests go to the configured AI provider; prompts are admin-configurable.

See [plugins/ai-tools.md](plugins/ai-tools.md)
