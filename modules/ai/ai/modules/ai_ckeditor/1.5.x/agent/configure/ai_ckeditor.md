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

## Prompts now reference AI Core `ai_prompt` entities (changed in 1.5.x)

Action prompts are **not** per-format and are **no longer inline template strings**. The
`ai_ckeditor.settings` config object (`config/install/ai_ckeditor.settings.yml`, schema
`ai_ckeditor.settings`) now stores, under `prompts`, the **id of an AI Core `ai_prompt`
entity** for each action. The plugins render the prompt via the `#type => 'ai_prompt'` form
element and resolve the text at runtime with
`config('ai.ai_prompt.<id>')->get('prompt')`.

| Key | Used by | Default `ai_prompt` id |
|---|---|---|
| `complete` | Generate with AI | `''` (pre-prompt; blank by default) |
| `modify_prompt` | Modify with a prompt | `ai_ckeditor_modify__default` |
| `reformat` | Reformat HTML | `ai_ckeditor_reformat__default` |
| `spellfix` | Fix spelling | `ai_ckeditor_spellfix__default` |
| `summarize` | Summarize | `ai_ckeditor_summarize__default` (note: key renamed from `summarise`) |
| `tone` | Tone | `ai_ckeditor_tone__default` |
| `translate` | Translate | `ai_ckeditor_translate__default` |

Inspect / edit with drush:

```bash
drush config:get ai_ckeditor.settings
# edit the referenced prompt text in the AI prompt library, e.g.:
drush config:get ai.ai_prompt.ai_ckeditor_summarize__default
```

Edit the wording by changing the referenced `ai_prompt` entity (AI Core's prompt library at
`/admin/config/ai/prompts`), or point an action at a different prompt id in
`ai_ckeditor.settings`.
