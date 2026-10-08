# ai_ckeditor (AI CKEditor integration) 1.5.x — agent index

> **Deprecated in 1.5.x.** `ai_ckeditor.info.yml` now sets `lifecycle: deprecated`
> (`lifecycle_link: https://www.drupal.org/node/3612175`). It still works, but new work has
> moved to a dedicated contrib project — prefer that for new sites; this submodule is kept for
> backward compatibility.

Submodule of AI Core (`ai`). Adds AI actions to CKEditor 5. An editor clicks the **AI
CKEditor** toolbar button (or uses the contextual balloon menu on a text selection), picks
an action in a modal dialog, and the module calls an AI Core `chat` provider and streams the
result back into the editor.

Mental model: each action (Summarize, Translate, Tone, …) is an **`AiCKEditor` plugin** — a
plugin type this module defines. Available actions are turned on per **text format** on the
CKEditor 5 toolbar settings form. Depends on `ai:ai`, so a `chat` provider must be
configured for actions to return text.

- **Enable the AI button in a text format & pick providers/prompts** → [configure/ai_ckeditor.md](configure/ai_ckeditor.md)
- **Add your own AI editor action (`AiCKEditor` plugin)** → [plugins/ai_ckeditor.md](plugins/ai_ckeditor.md)
- **Permission that gates all AI editor features** → [permissions/ai_ckeditor.md](permissions/ai_ckeditor.md)

Built-in action plugins (`src/Plugin/AiCKEditor/`): `ai_ckeditor_completion` (Generate with
AI), `ai_ckeditor_modify_prompt`, `ai_ckeditor_summarize`, `ai_ckeditor_translate` (needs
taxonomy), `ai_ckeditor_tone` (needs taxonomy), `ai_ckeditor_spellfix`,
`ai_ckeditor_reformat_html`, `ai_ckeditor_help`.

In 1.5.x the per-action prompts are stored as references to AI Core **`ai_prompt`** entities
(not inline template strings) — see the configure doc.
