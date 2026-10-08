<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering pipeline & cookies

## Selection (`AnnoyingPopupRepository`, `src/AnnoyingPopupRepository.php`)
Service `annoying_popup.repository` (args: `entity_type.manager`, `path.matcher`, `path.current`,
`path_alias.manager`, `renderer`, `language_manager`).

- `getPopupsForTheCurrentPath()` — loads all `annoying_popup` entities where `enabled == TRUE`
  (entity query with `accessCheck(TRUE)`), then unsets any whose visibility does not match. Path: current
  path is resolved to its alias (`AliasManager::getAliasByPath`) and tested with
  `PathMatcher::matchPath(alias, visibility.request_path.pages)`, combined with the `negate` flag. Language:
  current langcode is checked against `visibility.languages.langcodes` with its own `negate` flag.
- `hasPopupsForCurrentPath()` — boolean, count > 0.
- `getPopupsForCurrentPathJavaScriptSettings()` — for each matched popup builds a settings array with `id`,
  the **rendered** `content`, `action_button` (`url`, `title`, `open_in_new_window`) and `dismiss_button`
  (`title`). The body is rendered via a render array `['#type' => 'processed_text', '#text' => content.value,
  '#format' => content.format]` through `Renderer::renderPlain()` — i.e. the stored text format's filters are
  applied.
- `getCacheTags()` — returns `annoying_popup:<id>` for each matched popup.

## Page attachment (`annoying_popup_page_attachments()`, `annoying_popup.module`)
On every page, if `repository->hasPopupsForCurrentPath()`:
- attaches library `annoying_popup/annoying_popup`;
- sets `drupalSettings.annoyingPopup` to the settings array above;
- if `eu_cookie_compliance` is enabled **and** the current user has permission
  `display eu cookie compliance popup`, sets `drupalSettings.annoyingPopupCookieAware = TRUE` and adds the
  popup cache tags to `#cache['tags']`.

## Client behavior (`assets/src/js/annoying_popup.js`, built to `assets/dist/js/`)
`Drupal.behaviors.annoyingPopups` (jQuery + `js-cookie`):
- If not cookie-aware, initializes popups on `document.ready`; otherwise waits for the
  `eu_cookie_compliance` agree button (or `Drupal.eu_cookie_compliance.hasAgreed()`).
- For each popup in `drupalSettings.annoyingPopup`, if cookie `annoying_popup-<id>` is unset, appends the
  popup markup (content + action/dismiss buttons) and an overlay to `body`, revealing them via a `visible`
  attribute after a short timeout (~1s).
- Dismiss click sets cookie `annoying_popup-<id> = 'dismissed-client'`; engage (action-link) click sets
  `'engaged-client'` then navigates. Cookies: one-year `expires`, `path: '/'`, `secure: true`,
  `sameSite: 'strict'`.

## Cookie lifetime extension (`AnnoyingPopupRequestSubscriber`)
Service `annoying_popup.request_subscriber` subscribes to `KernelEvents::REQUEST`
(`extendCookieLifetime()`): for each request cookie named `annoying_popup-*` whose value ends in `-client`,
it re-issues the cookie server-side via `setcookie()` with the extracted value, a one-year lifetime,
`path '/'`, `secure = TRUE`, `httponly = FALSE`. This effectively renews the dismissal record on each visit.

## Cache invalidation
Saving a popup (`AnnoyingPopupForm::save()`) invalidates `Cache::invalidateTags([$entity->getCacheTag()])`.
