<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How consent gating works (hooks + renderer swap + SDP)

All logic lives in `usercentrics.module` plus `src/UsercentricsJsCollectionRenderer.php` and the
`usercentrics.helper` service. Every path first checks
`isEnabled() && hasAccess() && !onDisabledUri() && !onExcludedUri()` (see
[../config/settings.md](../config/settings.md)) and the relevant `auto_decorate_*` switch, then
"decorates" a matched script so the browser will **not** execute it: it sets
`type="text/plain"` and adds `data-usercentrics="<app label>"`. The Usercentrics CMP unblocks
(rewrites the type back) once the visitor consents to that service.

`hook_module_implements_alter()` moves `usercentrics`'s `js_alter` and `page_attachments_alter`
implementations to run **last**, so it sees libraries other modules added.

## Four match paths (source → mechanism)

1. **Asset libraries** — `hook_library_info_alter($libraries, $extension)`. Builds a map of every
   enabled app's `libraries()` → app label. For each matching `extension/library`, on each JS asset
   it sets `['preprocess'] = FALSE` and a custom `['usercentrics'] = $app_label` flag. Uses a
   `drupal_static` early-exit gate keyed on the config check + `auto_decorate_library_info_alter`.

2. **Library / aggregated JS rendering** — `UsercentricsJsCollectionRenderer` (registered over
   core's `asset.js.collection_renderer` by `src/UsercentricsServiceProvider.php`). In `render()`,
   any asset still carrying the `usercentrics` flag (set in step 1) gets
   `#attributes['data-usercentrics']` + `#attributes['type'] = 'text/plain'` on the final element.
   This is the step that actually stops execution for library-sourced scripts — **grep for this
   class before assuming a library is gated.**

3. **Manually added script files** — `hook_js_alter($javascript, $assets)`. Map is each enabled
   app's `javascripts()` substrings → label. For each queued JS whose `path` contains a substring
   (`mb_strpos !== FALSE`, non-`setting` type), sets `preprocess = FALSE` and the `usercentrics`
   flag (again finalised by the renderer in step 2).

4. **Page-attachment scripts** — `hook_page_attachments_alter($attachments)`. Map is each enabled
   app's `attachments()` identifiers → label. Walks `$attachments['#attached']['html_head']`; when
   an entry's identifier (its 2nd array element) is in the map, rewrites that entry's
   `#attributes['type'] = 'text/plain'` and adds `#attributes['data-usercentrics'] = $label`.

Each app's match values come from the DPS config entity — see
[../entities/dps-app.md](../entities/dps-app.md). Debug mode logs every "Checking …" and "Changed …"
line to the `usercentrics` logger, which is how you author new match rules.

## Injected loader scripts (`hook_page_attachments`)

Separate from gating, this hook injects the CMP loader (`app.usercentrics.eu/browser-ui/latest/
loader.js` with `data-settings-id`) and, when `sdp_enabled`, the Smart Data Protection blocker
(`privacy-proxy.usercentrics.eu/latest/uc-block.bundle.js`), each `array_unshift`ed to load first,
with matching `preconnect`/`preload` links. Fixed usercentrics.eu hosts; the settings ID is an
escaped attribute value. See [../config/settings.md](../config/settings.md) for the code.

## Front-end toggle button (`usercentrics/ui`, `js/usercentrics.js`)

When `show_toggle_button`, a `Drupal.behaviors.usercentrics` appends a floating
`#uc_toggle_dialog` "Manage consents" button that calls the CMP global `UC_UI.showFirstLayer()`;
if `drupalSettings.usercentrics.logoPath` is set (from `toggle_button_icon`) it becomes the button's
`background-image`. A second behaviour installs a `MutationObserver` that re-runs
`Drupal.attachBehaviors()` after newly unblocked `text/javascript` scripts load.

## SDP / oEmbed caveat

Smart Data Protection blocks external embeds client-side, but Drupal's core media oEmbed serves the
outer iframe from the internal `/media/oembed` URL, which a CMP cannot recognise — so `onDisabledUri()`
always skips `^\/media\/oembed`. The README recommends the **Media oEmbed Provider Markup** module so
the provider's real embed markup (recognisable to the CMP/SDP) is emitted instead.
