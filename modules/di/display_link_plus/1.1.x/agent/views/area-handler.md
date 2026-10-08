<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `display_link_plus` Views area handler

Class `Drupal\display_link_plus\Plugin\views\area\DisplayLinkPlus`
(`src/Plugin/views/area/DisplayLinkPlus.php`), annotation `@ViewsArea("display_link_plus")`, extends
`AreaPluginBase`, uses `RedirectDestinationTrait`. Registered as a view **area** handler by
`display_link_plus_views_data()` (`display_link_plus.views.inc`), so it is available in the **Header**
and **Footer** of any view.

## Add it (UI)

On a view: *Header* or *Footer* → **Add** → search "Display Link Plus" → **Apply**. The options form
(`buildOptionsForm()`) is shown next.

## Options / config keys

Defined in `defineOptions()` (lines 79-89); persisted under the area instance in the view config and
validated by schema `views.area.display_link_plus`.

- `display_id` (string, **required**) — machine id of the display to link to. The select is populated
  only with displays for which `isPathBasedDisplay()` is TRUE, i.e. the display handler is an instance
  of `Drupal\views\Plugin\views\display\PathPluginBase` (e.g. `page_1`, a `feed`). Block/attachment/
  embed displays are excluded.
- `label` (string) — link text. When empty, `render()` falls back to the target display's
  `display_title`.
- `class` (string) — one or more CSS classes, space-separated. Each token is run through
  `Html::getClass()` before being applied (render lines 234-239). Recommended: `button`.
- `target` (string, one of `'' | tray | modal`) — `''` = normal navigation; `tray` = off-canvas
  dialog; `modal` = modal dialog.
- `width` (integer, default `'600'`) — dialog width in px; only meaningful when `target` is `tray` or
  `modal` (the field is hidden via `#states` otherwise). Falls back to `600` if empty.
- `append_destination` (boolean, default `FALSE`) — when TRUE, merges the current request's
  `destination` (via `RedirectDestinationTrait::getDestinationArray()`) into the link query, so the
  target form redirects back to the listing after submit.
- `arguments_mapping` (sequence) — one entry per contextual filter (argument) on the *current*
  display. Each entry (schema `display_link_plus_argument_mapping`) has:
  - `enabled` (bool) — turn this mapping on.
  - `query_string` (string) — the query-parameter name to write the argument value into on the link.
  - `is_multiple` (bool) — pass all argument values (array) instead of just the first
    (`array_shift`).

  The arguments-mapping `#details` fieldset only appears when the current display actually has
  argument handlers (`$display_objects->get($this->view->current_display)->getHandlers('argument')`).

## Render behavior (`render($empty = FALSE)`, lines 208-270)

1. Returns `[]` early if the area is empty **and** no `display_id` is set, or if `display_id` is not
   a path-based display (re-checked at render, not just at config time).
2. Computes `$access = $this->view->access($display_id, $currentUser)` and sets it as the render
   array's `#access`, so the link is only rendered for users who can reach the target display.
3. Builds the URL with `$this->view->getUrl(NULL, $display_id)` and attaches the query from
   `getQueryParameter()`.
4. Falls back to the target display's `display_title` for `#title` when `label` is empty.
5. Emits `['#type' => 'link', '#title' => label, '#url' => $url, '#options' => ['attributes' =>
   ['class' => $classes]], '#access' => $access]`.
6. Dialog wiring when `target` is set: adds the `use-ajax` class and
   `data-dialog-options={"width":N}`; for `tray` adds `data-dialog-renderer=off_canvas` +
   `data-dialog-type=dialog`; for `modal` adds `data-dialog-type=modal`.

## Query assembly (`getQueryParameter(): array`, lines 277-327)

- Starts from `$this->view->getExposedInput()` (the current display's exposed-filter input) so the
  filter state is carried over to the linked display.
- Adds `page` = `$this->view->getCurrentPage()` when on a non-zero pager page.
- Strips Views/AJAX internal keys: `view_name`, `view_display_id`, `view_args`, `view_path`,
  `view_dom_id`, `pager_element`, `view_base_path`, plus `AjaxResponseSubscriber::AJAX_REQUEST_PARAMETER`,
  `FormBuilderInterface::AJAX_FORM_REQUEST`, `MainContentViewSubscriber::WRAPPER_FORMAT`.
- Applies each enabled `arguments_mapping` entry: only if the argument exists on the view
  (`$this->view->argument[$name]`) and has a non-empty `->value`; writes the value under
  `query_string` (all values if `is_multiple`, else the first).
- Merges `getDestinationArray()` last when `append_destination` is TRUE.

## Config example (view YAML fragment)

Under a display's `display_options.header` (or `.footer`):

```yaml
display_link_plus_1:
  id: display_link_plus_1
  table: views
  field: display_link_plus
  plugin_id: display_link_plus
  display_id: page_2
  label: 'View all results'
  class: 'button button--primary'
  target: modal
  width: 800
  append_destination: false
  arguments_mapping:
    nid:
      enabled: true
      query_string: node
      is_multiple: false
```

## Update hook

`display_link_plus_update_9000()` (`display_link_plus.install`) iterates all `views.view.*` config and
sets `append_destination = TRUE` on every existing `display_link_plus` header/footer area — preserving
prior behavior, since the option now defaults to `FALSE` for new instances. Run via `drush updb`.
