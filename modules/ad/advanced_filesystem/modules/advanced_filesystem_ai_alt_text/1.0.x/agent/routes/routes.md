<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, endpoint & UI hooks

From `advanced_filesystem_ai_alt_text.routing.yml` (all carry `_admin_route: true`):

| Route | Path | Handler | Access |
|---|---|---|---|
| `.settings` | `/admin/config/media/advanced_filesystem/ai-alt-text` | `Form\AltTextSettingsForm` | `_permission: administer advanced_filesystem_ai_alt_text` |
| `.batch` | `…/ai-alt-text/batch` | `Form\BatchAltTextForm` | same permission |
| `.file_generate` | `/admin/content/files/{file}/ai-alt-text` (`file` = `entity:file`, `\d+`) | `Form\SingleFileAltTextForm` | same permission |
| `.generate_inline` | `/admin/api/advanced-filesystem/ai-alt-text/{fid}` (`\d+`) | `Controller\AltTextInlineController::generate` | `_custom_access` = `AltTextInlineController::access` |

## The JSON endpoint (`.generate_inline`)

`AltTextInlineController::access()` allows the request if the account has **`administer …`** *or*
**`generate advanced_filesystem_ai_alt_text`** (`cachePerPermissions`). `generate($fid, $request)`
`File::load($fid)`s (404 if missing), rejects non-`image/*` MIME (422), calls
`AltTextService::generateAltText()`, and returns `{"success":true,"alt_text":"…"}` or
`{"success":false,"error":"…"}` (500 on provider error, message from the caught exception). It reads
only the route `{fid}`; no request body is trusted.

## Widget button & operation link (`.module`)

- `hook_field_widget_single_element_form_alter()` → adds an `#after_build`
  (`_advanced_filesystem_ai_alt_text_inject_button`) that appends an `html_tag` `<button>`
  (`data-alt-selector`, `data-fids-name`) to image widgets and attaches library
  `advanced_filesystem_ai_alt_text/widget`. Only for users with either permission and only when
  `AltTextService::isAvailable()`.
- `js/alt-text-button.js` (`Drupal.behaviors`, `core/once`) reads the fid from the widget's hidden
  `fids` input and `fetch()`es the JSON endpoint, then writes `alt_text` into the alt input.
- `hook_entity_operation()` adds an "AI Generate Alt Text" link (to `.file_generate`) on image file
  rows in `/admin/content/files`, gated by the same permissions + MIME allowlist.
- `Ajax\AltTextAjaxHandler::generate()` is an alternate Form-API AJAX callback (resolves the fid from
  form values/user input, invokes the same service, populates the alt input via `InvokeCommand`);
  AI text is passed through `t()` placeholders in the status message.
