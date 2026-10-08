# Enable & configure AJAX history on a view

There is **no site-wide settings form** (`configure` route is `null`). History is turned on
**per view display** through a Views display extender.

## Prerequisite: the view must use AJAX

The feature only activates when the view's *Use AJAX* option is on. `hook_views_pre_render()`
checks `$view->ajaxEnabled()` before attaching anything, and the display-extender form only
enables `enable_history` while `use_ajax` is checked (`validateOptionsForm()` forces it off
otherwise).

## Turn it on (UI)

1. Edit the view → **Advanced** → **Use AJAX** (`Other` group).
2. In the *Use AJAX* dialog, tick **AJAX history** ("Enable Views AJAX history").
3. (Optional) Fill **Exclude query arguments from the URL** — one query key per line; each is
   removed from the pushed URL using a "starts with" match.
4. Save the view.

The two settings live on the `ajax_history` display extender:

| Option key | Type | Meaning |
|---|---|---|
| `enable_history` | boolean | Attach the history library and push URL state for this display |
| `exclude_args` | text | Newline-separated query-key prefixes to strip from the history URL |

These are stored under `display.<id>.display_options.display_extenders.ajax_history` in the
view's config and are schema-defined in `config/schema/views_ajax_history.schema.yml`
(`views.display_extender.ajax_history`), so they export/deploy with `drush config:export`.

## The display extender registration

The `ajax_history` extender (plugin `Drupal\views_ajax_history\Plugin\views\display_extender\
AjaxHistory`, `no_ui = FALSE`) is registered in `views.settings` `display_extenders` on
install (`hook_install`) and removed on uninstall. If the extender does not appear on views,
confirm it is listed in `views.settings:display_extenders`.

The old `8.x-1.x` update hook `views_ajax_history_update_8001()` back-filled `enable_history =
TRUE` onto every existing view that already used AJAX, preserving pre-extender behavior.

## What enabling it does at render time

When `enable_history` is TRUE, `ajaxEnabled()` is true, and the view is neither an attachment
nor a live preview, `hook_views_pre_render()`:

- attaches the `views_ajax_history/history` library;
- sets `drupalSettings.viewsAjaxHistory.renderPageItem` to the current pager page
  (`pager.parameters` service `findPage()`);
- adds the `url.query_args.pagers` cache context;
- passes `excludeArgs` (from `exclude_args`) into `drupalSettings`;
- on a non-XHR (first) load, snapshots the current exposed input into
  `drupalSettings.viewsAjaxHistory.initialExposedInput['views_dom_id:<dom_id>']` so state
  survives a full refresh / back navigation.

## Bookmarkable + back/forward behavior

Once enabled, applying an exposed filter or clicking a pager updates the address bar via
`history.pushState()`, so the URL can be bookmarked or shared, and the browser back/forward
buttons re-run the view for the corresponding state. See
[theming/views_ajax_history.md](../theming/views_ajax_history.md) for the JS details.
