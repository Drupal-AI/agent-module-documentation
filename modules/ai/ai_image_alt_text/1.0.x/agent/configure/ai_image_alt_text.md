# Configure AI Image Alt Text

## Prerequisite: an AI provider

This module has **no AI of its own** — it consumes AI Core. You must either:

- set a **default provider/model for the `chat_with_image_vision` operation** on AI Core
  (`/admin/config/ai/settings`, the "Default Providers" area), or
- pick an explicit model on this module's own settings form (below).

If neither is configured, the button does not appear and admins with `administer ai settings`
get a warning message on image forms.

## Settings form — `ai_image_alt_text.settings`

Route `ai_image_alt_text.settings_form` → `/admin/config/ai/ai_image_alt_text`
(permission `administer ai`). Config object `ai_image_alt_text.settings`
(`config/schema/ai_image_alt_text.schema.yml`). Keys and defaults:

| Key | Default | Meaning |
|---|---|---|
| `prompt` | (a11y expert prompt, see below) | Twig-rendered prompt sent to the model. Required. |
| `image_style` | `ai_image_alt_text` | Image style applied before sending (downscale + reformat to PNG) to save cost. Empty = send original (not recommended). |
| `ai_model` | `''` | Provider/model as a `provider__model` simple option. Empty = use the site default `chat_with_image_vision` model. The select is filtered to `chat` models with the `ChatWithImageVision` capability. |
| `autogenerate` | `false` | Generate alt text automatically on upload, no editor click needed. |
| `hide_button` | `false` | Hide the manual "Generate with AI" button (only meaningful when `autogenerate` is on; forced off otherwise). |

The module ships a default `ai_image_alt_text` image style
(`config/install/image.style.ai_image_alt_text.yml`).

### Prompt tokens

The prompt is rendered with Twig before sending and supports:

- `{{ entity_lang_name }}` — human-readable name of the content entity's language (drives the
  output language).
- `{{ filename }}` — original filename of the uploaded image.

Default prompt instructs the model to act as an accessibility expert, keep alt text under
100 characters, avoid "image of…", not keyword-stuff, and respond with only the alt text.

## The button on image fields

Provided by `hook_field_widget_single_element_form_alter` in `ai_image_alt_text.module`. It
appears on an image widget only when: the widget is an `ImageWidget`, the field has alt text
enabled (`#alt_field`), the current user has `generate ai alt tags`, a working provider is
resolvable, and an image is already uploaded. It attaches the `ai_image_alt_text/alt_text`
JS library and passes `lang`, `autogenerate`, and `hide_button` via `drupalSettings`.

## Permissions

| Permission | Gates |
|---|---|
| `generate ai alt tags` | Showing the button and calling the generate route. |
| `administer ai` | The settings form (route requirement). |
| `administer ai settings` | (AI Core) only used to decide whether to show the "no provider" warning. |

## Drush / config deploy

Settings are a config object, so `drush config:export` / `drush cset ai_image_alt_text.settings <key> <value>`
work as usual (e.g. `drush cset ai_image_alt_text.settings autogenerate 1`).
