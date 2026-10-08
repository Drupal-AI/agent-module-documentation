# configure — enable AI in a text format, pick providers & prompts

There is **no dedicated settings route** (`configure` is `null` in `info.yml`). AI editing is
turned on per **text format / editor** on the core CKEditor 5 toolbar form at
**/admin/config/content/formats** (edit a format that uses the CKEditor 5 editor, e.g.
`/admin/config/content/formats/manage/full_html`).

## Turn it on (per text format)

1. Enable this module and at least one AI provider module (it depends on `ai:ai`); set a
   default **chat** provider in AI Core (`/admin/config/ai/settings`) or plan to pick one
   per action.
2. Edit a text format whose editor is **CKEditor 5**.
3. Drag the **AI CKEditor** button from *Available buttons* into the *Active toolbar*. (An
   optional **AI Balloon Menu** button enables the contextual menu that appears on text
   selection.) These come from `ai_ckeditor.ckeditor5.yml`:
   - `ai_ckeditor_ai` — toolbar item `aickeditor`, CKEditor5 plugin `aickeditor.AiCKEditor`,
     class `Drupal\ai_ckeditor\Plugin\CKEditor5Plugin\AiCKEditor`.
   - `ai_ckeditor_balloon_menu` — toolbar item `ai_balloon_menu`, plugin
     `ai_balloon_menu.AiBalloonMenu`.
4. A **"AI tools"** settings section appears below the toolbar. For each available action
   plugin, tick **Enabled** and (where offered) choose an **AI provider** — the
   `-- Default from AI module (chat) --` option falls back to the AI Core default chat
   provider. If nothing is enabled the button is hidden.
5. Optionally set the modal **dialog** options (autoresize, height `750`, width `900`,
   dialog CSS class `ai-ckeditor-modal`).

This configuration is stored inside the **editor** entity, under
`settings.plugins.ai_ckeditor_ai` (schema `ckeditor5.plugin.ai_ckeditor_ai` in
`config/schema/ai_ckeditor.schema.yml`): a `dialog` mapping plus a `plugins` sequence keyed
by action id, each with `enabled` (bool) and `provider` (string, a provider-model option).

## How a request resolves a provider

`Controller\AiRequest::doRequest()` (route `ai_ckeditor.do_request`) reads the editor's
`plugins.ai_ckeditor_ai.plugins[<id>].provider`. If set it uses
`loadProviderFromSimpleOption()`; otherwise it uses AI Core's
`getDefaultProviderForOperationType('chat')`. If neither is available it shows an error
pointing at the AI settings form. The text format's allowed HTML tags are injected into the
prompt so the model returns only permitted markup.

## Prompt templates (site-wide config object)

Action prompt text is **not** per-format — it lives in the `ai_ckeditor.settings` config
object (`config/install/ai_ckeditor.settings.yml`, schema `ai_ckeditor.settings`). Keys under
`prompts`:

| Key | Used by | Notes |
|---|---|---|
| `complete` | Generate with AI | pre-prompt prepended to the user's prompt (blank by default) |
| `modify_prompt` | Modify with a prompt | template with `{{ modify_prompt }}` placeholder |
| `reformat` | Reformat HTML | instruction to mark up as semantic HTML |
| `spellfix` | Fix spelling | grammar/spelling-only instruction |
| `summarise` | Summarize | summarize-in-same-language instruction |
| `tone` | Tone | template with `{{ tone }}` placeholder |
| `translate` | Translate | template with `{{ lang }}` placeholder |

Inspect / edit with drush:

```bash
drush config:get ai_ckeditor.settings
drush config:set ai_ckeditor.settings prompts.summarise "Summarize this text concisely:" -y
```

Some action forms (e.g. Completion) also write their prompt back into this config object when
their per-format configuration form is saved.
