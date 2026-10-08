<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services & render-time hooks

All services read `media_link_enhancements.settings`. Published-only + bundle + extension gating is enforced
by the helper.

## Services
- `media_link_enhancements.helper` (`MediaLinkEnhancementsHelper`) — `checkBundle($bundle, $config_key)`
  (bundle is in the allow-list array) and `checkExtension($extension, $config_key)` (extension matches the
  comma list, case-insensitive; empty list = allow all).
- `media_link_enhancements.append_text` (`MediaLinkEnhancementsAppendText`) — `getText(File $source)` returns
  the ` [ext/size]` string (or FALSE); `humanReadableBytes()` formats sizes. Applies `type_size_appending_*`.
- `media_link_enhancements.alter_links` (`MediaLinkEnhancementsAlterLinks`) — `alterLinks($html)` DOM-parses
  markup, finds `<a>` to media (via `data-entity-uuid`/`data-entity-type` or an `/media/{id}` href), and
  rewrites `href`/`download` and/or appends type/size text. Used by content parsing.
- `media_link_enhancements.route_subscriber` — swaps the `entity.media.canonical` controller to
  `MediaLinkEnhancementsController::download` (defaults only; the route's media view access requirement is unchanged).

## Hooks the module implements (behavior, not for you to implement)
- `hook_entity_display_build_alter()` — appends type/size to rendered `link`-type field anchors, and runs
  `alterLinks()` over configured content field types.
- `hook_entity_type_build()` — sets the media entity class to `MediaLinkEnhancementsMedia` (carries the
  Linkit direct-link flag through to URL generation).

## Controller (`MediaLinkEnhancementsController::download`)
Runs at the media canonical URL. Order: `?edit-media` shortcut (auth users → media edit) → redirect (if enabled,
303 `TrustedRedirectResponse`) → binary response (if enabled, inline `BinaryFileResponse`) → default media view.
Only affects allowed bundles/extensions; resolves public/private stream paths for the source file.

## Linkit
Ships `Plugin/Linkit/Matcher/MediaLinkEnhancementsMediaEntityMatcher` so media chosen via Linkit carries the
substitution flag that direct linking respects (a Linkit substitution link is not href-rewritten, only appended to).
