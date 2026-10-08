<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Paragraphs — configuration & mechanism

## Enable

`drush en cookies_addons_paragraphs`. Requires COOKiES (`cookies`) and Paragraphs (`paragraphs`),
plus at least one enabled `cookies_service` entity.

## Configure

Route `cookies_addons_paragraphs.settings` → `/admin/config/system/cookies-addons-paragraphs`
(permission `administer site configuration`; menu link under `cookies.config`). `SettingsForm`
exposes one field:

- `paragraphs` (textarea, config `cookies_addons_paragraphs.settings:paragraphs`) — one entry per
  line, format `paragraph_id|cookies_service_machine_name`. `paragraph_id` is the numeric Paragraphs
  entity id.

Config object `cookies_addons_paragraphs.settings` (schema: `paragraphs` type `text`).

## Runtime mechanism

1. `cookies_addons_paragraphs_preprocess_paragraph(&$variables)` gets `$variables['paragraph']->id()`
   and calls `_cookies_addons_paragraphs_get_service($id)` → FALSE on POST, else
   `_cookies_addons_paragraphs_is_restricted($id)` (splits `paragraphs` config on newlines,
   `explode('|')`, skips lines with part count ≠ 2, returns the service on exact id match).
2. When restricted, it resolves the service label from enabled `cookies_service` entities (falls back
   to the machine name) and replaces `$variables['content']` with an `html_tag` `div` bearing classes
   `cookies-addons-paragraph-placeholder`, `data-cookies-service`, `data-service-name`,
   `data-paragraph-id`, `id={id}-content`, attaching library
   `cookies_addons_paragraphs/cookies-addons-paragraphs`.
3. `js/cookies-addons-paragraphs.js` (`Drupal.behaviors.cookiesAddonsParagraphs`) mirrors the blocks
   behavior: on `cookiesjsrUserConsent` accept it POSTs
   `/cookies-addons-paragraphs/get-paragraph/{paragraphId}/{service}`; on deny it calls
   `cookiesOverlay(service)`.
4. `CookiesAddonsParagraphsController::getParagraph()` loads the `paragraph` entity, renders it with
   `getViewBuilder('paragraph')->view($paragraph)`, and returns an `AjaxResponse` with a
   `ReplaceCommand`. Throws `\Exception` if the paragraph can't be loaded/built.

## Notes

- Only the paragraph's own render output replaces the placeholder; it is loaded out of its host
  entity's render context.
- Gating helper returns FALSE on POST so the AJAX re-render is not re-gated.
