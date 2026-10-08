<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: how the background is injected

All logic lives in `background_wallpaper.module` (no service class).

## `background_wallpaper_page_attachments(array &$attachments)`
Implements `hook_page_attachments()`, so it runs on every page build. Steps:
1. Loads `background_wallpaper.settings`; reads `background_image` (fid array) and `background_target` (array of targets).
2. Determines whether the current page matches a target (`$target_matched`):
   - Front page: `\Drupal::service('path.matcher')->isFrontPage()` AND `in_array('front', $background_targets)`.
   - Otherwise, if the current route has a `node` parameter (`\Drupal::routeMatch()->getParameter('node')`) whose `getType()` is in `$background_targets`.
   - Note: front-page and node matching are mutually exclusive here (`if`/`elseif`); non-node, non-front routes never match.
3. If matched and `background_image` is non-empty, loads the first file: `entityTypeManager()->getStorage('file')->load($file_ids[0])`.
4. Builds the absolute image URL: `\Drupal::service('file_url_generator')->generateAbsoluteString($file->getFileUri())`.
5. Attaches an inline style to `html_head`:
   ```
   ['#tag' => 'style',
    '#value' => "#main { background-image: url('$file_url') !important; background-size: cover; background-position: center; }"]
   ```
   keyed `'background_wallpaper'`.

## Behavioral notes for agents
- The CSS targets the `#main` selector only. If the active theme does not render an element with `id="main"`, the rule has no visible effect.
- Only the FIRST uploaded file (`$file_ids[0]`) is ever used, even though the config value is an array.
- `!important` is emitted, so the rule overrides theme background rules on `#main`.
- The head element has no `#type`; core's `HtmlResponseAttachmentsProcessor::processHtmlHead()` assigns `#type => html_tag`, so the `#value` is rendered via `HtmlTag::preRenderHtmlTag()` (which runs `Xss::filterAdmin()` on the string).
- No caching metadata (cache tags/contexts) is added by the hook beyond what the page render already carries; changing the config and rebuilding cache updates the output. Front-page vs. node targeting depends on route/path context.

## `background_wallpaper_help($route_name, $route_match)`
Implements `hook_help()`; returns a one-line description for `help.page.background_wallpaper`. No other hooks.
