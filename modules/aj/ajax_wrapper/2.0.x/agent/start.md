<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Wrapper (ajax_wrapper) — agent index

A developer utility that provides one **render element**, `ajax_wrapper`, whose content comes from a
**callback** and is **re-rendered over AJAX** when links or forms inside it are used — for building
overviews (paged/filtered lists) that update without a full page reload. Core `^10.3 || ^11`,
license GPL-2.0-or-later, version 2.0.3. **No dependencies, no permissions, no config, no Drush.**

## What it actually provides

- **Render element** `ajax_wrapper` — `src/Element/AjaxWrapperElement.php` (`@RenderElement("ajax_wrapper")`,
  extends `RenderElementBase`). You give it `#ajax_callback`; its `#pre_render` runs the callback to
  produce the initial content and emits AJAX settings into `drupalSettings`. See
  [api/render-element.md](api/render-element.md).
- **Route** `ajax_wrapper.refresh` → `AjaxWrapperController::refresh` at `/ajax-wrapper/refresh`
  (GET+POST, `_permission: 'access content'`). Rebuilds the request for the clicked URL, re-runs the
  callback, returns an `AjaxResponse`. See [routes/refresh.md](routes/refresh.md).
- **Service** `ajax_wrapper.utility.callback` → `Utility\AjaxWrapperCallbackUtility` — resolves and
  invokes the callback through Drupal's `DoTrustedCallbackTrait`. Covered in
  [routes/refresh.md](routes/refresh.md).
- **AJAX command** `StoreHistoryCommand` (`src/Ajax/StoreHistoryCommand.php`) + `js/history.js` —
  pushes the new URL into `window.history` (`storeHistory` command).
- **Theme hook** `ajax_wrapper` (`ajax_wrapper.module`, template `templates/ajax-wrapper.html.twig`) —
  wraps `ajax_wrapper_content` in a `<div>` with `ajax_wrapper_attributes`.
- **Libraries** (`ajax_wrapper.libraries.yml`): `ajax_wrapper/ajax_wrapper` (js/ajax_wrapper.js,
  depends on core jquery/drupal/drupal.ajax/once + the `history` sub-library) and
  `ajax_wrapper/history` (js/history.js).

## Key facts for agents

- It is **developer-facing only** — invoked from custom render arrays/controllers/blocks. There is no
  admin form, no `config/`, no `*.permissions.yml`, no `*.install`.
- The wrapper's content is whatever the `#ajax_callback` returns; the initial render respects that
  callback's own logic. `js/ajax_wrapper.js` (`Drupal.behaviors.ajaxWrapper`) binds click/submit
  handlers to `<a>`/`<form>` inside the configured `#ajax_wrapper_classes` and POSTs to the refresh
  route.
- `AjaxBlockResponse` (`src/Response/AjaxBlockResponse.php`) is a small `AjaxResponse` subclass
  (adds `addDataKey()`); note it is **not** actually used by the controller in this version.
- The controller uses `router.no_access_checks` to *match* the target route (to derive route
  name/params for URL generation during the refresh).
