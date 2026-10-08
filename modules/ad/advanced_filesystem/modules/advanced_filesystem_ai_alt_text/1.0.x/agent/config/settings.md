<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & permissions

## Install & enable

```bash
drush en advanced_filesystem_ai_alt_text -y
```

Requires `advanced_filesystem` (+ core `file`, `field`, `user`). To do anything useful you also need
**drupal/ai** installed with a default provider set for the **Chat with Image Vision** operation at
*Config → AI → Providers* / *AI Settings*. This submodule stores **no** provider, model or API key.

## Config object: `advanced_filesystem_ai_alt_text.settings`

Defaults in `config/install/advanced_filesystem_ai_alt_text.settings.yml`, schema in
`config/schema/advanced_filesystem_ai_alt_text.schema.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `prompt` | string | "Generate a concise, descriptive alt text … Respond with ONLY the alt text …" | Sent to the model with each image. The raw reply (quote-trimmed) becomes the alt text. |
| `overwrite` | boolean | `false` | When true, batch/per-file runs replace existing alt text by default (per-run override still offered). |
| `max_length` | integer | `125` | Reply is truncated to this many characters on a word boundary; `0` = no limit. |
| `image_field_mappings` | ignore | `{}` | Reserved per-field mapping map (schema type `ignore`); not used by the current service logic. |

Edited via `Form\AltTextSettingsForm` at `/admin/config/media/advanced_filesystem/ai-alt-text`
(`submitForm()` writes `prompt`, `max_length`, `overwrite`). The form's build shows an AI-status
banner (provider active / not ready / drupal/ai missing).

## Permissions (`advanced_filesystem_ai_alt_text.permissions.yml`)

- `administer advanced_filesystem_ai_alt_text` — **restrict access: true**. Required by the settings,
  batch and per-file routes (`_permission` on each in `*.routing.yml`).
- `generate advanced_filesystem_ai_alt_text` — grants running generation. The inline JSON endpoint's
  `_custom_access` (`AltTextInlineController::access()`) allows **either** this permission **or** the
  administer permission; the widget button (`.module`) and the file-listing operation link appear for
  holders of either.

Grant `generate` to trusted editors so they can produce alt text without full admin rights; note that
each generation is a real (possibly paid) call to the configured AI provider.
