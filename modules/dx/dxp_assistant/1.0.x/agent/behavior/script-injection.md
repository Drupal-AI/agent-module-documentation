<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DXP Assistant — script injection (hook_page_attachments)

The module's only runtime behaviour lives in `dxp_assistant.module`:
`dxp_assistant_page_attachments(array &$attachments)` implementing `hook_page_attachments()`.

## Logic
1. Runs only if `\Drupal::currentUser()->hasPermission('access dxp assistant')`. Users without the permission get nothing attached.
2. Loads config `dxp_assistant.configuration` and merges the config object's cache tags into `$attachments['#cache']['tags']` (via `Cache::mergeTags(...)`), so the attachment invalidates when the setting changes.
3. Reads `script_url = $config->get('script_url')`.
4. If the URL is truthy **and** `UrlHelper::isValid($scriptUrl)` passes, appends to `$attachments['#attached']['html_head']`:
   ```
   [
     '#tag' => 'script',
     '#attributes' => [
       'type' => 'text/javascript',
       'src'  => $scriptUrl,
     ],
   ], 'dxp_assistant'
   ```

So the assistant is a single remote `<script src>` in the page `<head>`, keyed `dxp_assistant`. The script is fetched by the visitor's browser directly from whatever URL the admin configured — the module does not proxy, download, or bundle it, and declares no Drupal asset library for it.

## What is NOT exposed
- No `drupalSettings` values are emitted (no site/user/config data handed to the client).
- No HTTP data endpoint, controller, or REST route exists — the routing file defines only the admin config form. The project description's mention of "endpoints and information" is not implemented in this release.
- No API key/secret is stored or printed; the only setting is the script URL.

## Caching / visibility notes
- Because the attachment is gated on a per-user permission, page output varies by the `user.permissions` cache context (standard for permission-gated `hook_page_attachments`). Grant `access dxp assistant` to the anonymous role to serve the assistant publicly, or to specific authenticated roles to limit it.
- `UrlHelper::isValid()` (called with its default `$absolute = FALSE`) accepts both relative and absolute URLs; an invalid/empty value results in no script being attached.
