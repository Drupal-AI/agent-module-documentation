# The JS library — hooking Views AJAX into the History API

## Library

`views_ajax_history/history` (`views_ajax_history.libraries.yml`):

- JS: `js/views_ajax_history.js`
- Depends on: `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`,
  `core/drupal.ajax`.

Attached only by `hook_views_pre_render()` when the view has AJAX + `enable_history` on
(never on attachments or live preview). There are no Twig templates or theme hooks; "theming"
here means the client-side layer.

## How it works

The script wraps three core `Drupal.Ajax.prototype` methods (saving the originals on
`Drupal.ViewsAjaxHistory` and calling them at the end of each override):

- **`beforeSerialize`** — fires on pager-link clicks. If the target is an `<a>` for a view, it
  reads the link's `href`, drops any query keys matching `drupalSettings.viewsAjaxHistory.
  excludeArgs` (startsWith match), then calls `addState(options, '?' + params)`.
- **`beforeSubmit`** — fires on exposed-form submission. It rebuilds the URL from the form's
  values, removes the `page` param (a new filter should return page one), copies selected
  values (including `[]` multi-value fields, unchecked checkboxes, and empty multi-selects)
  into both the pushed URL and the AJAX request URL, then `addState()`.
- **`beforeSend`** — rewrites the actual AJAX request URL to `drupalSettings.views.ajax_path`
  (with the `drupal_ajax` wrapper format), branching if the view has Facets
  (`drupalSettings.facets_views_ajax`).

### State push / pop

- `addState(options, url)` stores `options.data.view_dom_id` as `lastViewDomID`, temporarily
  unbinds `popstate`, calls `history.pushState(cleanStateForHistory(options), title,
  cleanURL(url, options.data))`, then rebinds. Functions are stripped from the state because
  history state must be serializable.
- `cleanURL()` strips views-internal and duplicate params and honors clean-URLs off (adds `q`).
- `loadView()` is the `popstate` handler: on back/forward it rebuilds Drupal AJAX options from
  `history.state` (or, for the first entry where `state === null`, from
  `drupalSettings.views.ajaxViews` + `initialExposedInput` + `onloadPageItem`) and calls
  `Drupal.ajax(settings).execute()` with `httpMethod: 'GET'`.

### Other behaviors

- `Drupal.behaviors.viewsAjaxHistory` runs once (`core/once`, key
  `views-ajax-history-first-page-load`) to seed `onloadPageItem` from `renderPageItem` so the
  very first back click restores the initial view.
- `window.onpageshow` reloads the page when `event.persisted` (restored from bfcache) to avoid
  stale AJAX state.

## drupalSettings contract

Set by `hook_views_pre_render()` under `drupalSettings.viewsAjaxHistory`:
`renderPageItem` (current page), `excludeArgs` (from the `exclude_args` option), and
`initialExposedInput['views_dom_id:<dom_id>']` (first-load exposed input snapshot). The script
also adds `onloadPageItem` and `lastViewDomID` at runtime.
