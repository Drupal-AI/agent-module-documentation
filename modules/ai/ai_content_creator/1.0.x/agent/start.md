<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Creator (ai_content_creator) — agent index

Adds an **"AI Content Generator" panel to node add/edit forms**. An author types a prompt, an AJAX callback calls
the **OpenAI** API through a Guzzle service, and the result is shown in a **modal dialog** with a copy-to-clipboard
button. Nothing is written to the entity automatically — the author copies the text into fields by hand. Package
`Content`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.6. **No module dependencies, no permissions,
no config schema.** Calls OpenAI **directly** (not via drupal/ai).

- **Settings form, the config object, and the model/endpoint keys** → [config/settings.md](config/settings.md)
- **The node-form panel, the AJAX callback, and the OpenAI service** → [api/generation.md](api/generation.md)

## What it provides (from source)

- **hook_form_alter** in `ai_content_creator.module` — on any `NodeForm` whose bundle is in the configured
  `api_node_type` list, adds a `details` element `ai_content_creator` (group `advanced`) with a `keywords`
  textarea (maxlength 2000) and a `generate_content` AJAX button.
- **AJAX callback** `ai_content_creator_generate_content_callback()` — reads the prompt from user input, calls the
  service, and returns an `AjaxResponse` with an `OpenModalDialogCommand` (content escaped with `htmlspecialchars`
  + `nl2br`) or an `AlertCommand` on error.
- **Service** `ai_content_creator.openai_service` → `Service\OpenAiService` (`generateContent()`,
  `validateConfiguration()`), constructed with `@http_client`, `@config.factory`, `@logger.factory`.
- **Config form** `Form\AiContentCreatorConfigForm` at route `ai_content_creator.admin_settings`
  (`/admin/config/ai_content_creator`, permission `administer site configuration`, menu under
  *Configuration → Development*).
- **Library** `ai_content_creator/clipboardjs` — clipboard.js 2.0.10 loaded from a CDN, attached to the button.
- Config object: **`ai_content_creator.adminsettings`** (no schema file ships).

## Routes

| Route | Path | Permission |
|---|---|---|
| `ai_content_creator.admin_settings` | `/admin/config/ai_content_creator` | `administer site configuration` |

The generation itself has **no dedicated route** — it runs as the node form's own AJAX callback, so it is reached
only by users who can open the add/edit form for an enabled content type.
