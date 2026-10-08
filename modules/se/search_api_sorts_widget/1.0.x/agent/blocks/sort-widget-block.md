<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The sort widget (a block *alter*, not a new block)

This module registers **no `@Block` plugin**. The block on the page is
`search_api_sorts_block` — a derivative block (one per Search API display) provided by the
**search_api_sorts** module. You place that block; this module rewrites its content.

## How the rewrite is wired

1. `search_api_sorts_widget.module` implements
   `hook_block_view_search_api_sorts_block_alter(array &$build, BlockPluginInterface $block)` and
   appends a pre-render callback:
   ```php
   $build['#pre_render'][] = '\Drupal\search_api_sorts_widget\BlockViewAlter::preRender';
   ```
2. `src/BlockViewAlter.php` implements `TrustedCallbackInterface` (declaring `preRender` in
   `trustedCallbacks()`), and its `preRender($build)` replaces the block body with a form:
   ```php
   $build['content'] = \Drupal::formBuilder()->getForm(
     '\Drupal\search_api_sorts_widget\Form\WidgetForm',
     $build['content'] ?? NULL,          // the original render array = the sort LINKS
     $build['#derivative_plugin_id'] ?? NULL  // identifies the display
   );
   ```
   The original link list is handed to the form so the widget can fall back to it, and re-use the
   links' real URLs on submit.

## `WidgetForm` (src/Form/WidgetForm.php)

- **buildForm($form, $form_state, $content, $derivative_plugin_id)**
  - If `$content` or `$derivative_plugin_id` is empty → returns `$content` (nothing to do).
  - Loads the config entity: `searchApiSortsWidgetStorage->load(getEscapedConfigId($derivative_plugin_id))`.
  - If the entity is missing **or** `status` is false → returns `$content` (the original links).
    This is why the widget is strictly opt-in per display.
  - Otherwise reads `$content['links']` and, for each configured sort, builds `select` options from
    the admin labels:
    - value `"$field|asc"` → label `label_asc` (only added if non-empty)
    - value `"$field|desc"` → label `label_desc` (only added if non-empty)
  - `#default_value` is set to the currently active sort **inverted** (`asc`↔`desc`) so choosing the
    already-active option flips its direction.
  - Stores the links render array in `$form_state->set('links', $links)` for the submit handler.
  - `autosubmit` → `$form['sort_by']['#attributes']['onChange'] = 'this.form.submit();'`.
  - Adds a "Sort" submit button; `autosubmit_hide` → button gets inline `style: display: none;`.

- **submitForm()**
  ```php
  [$key, $order] = explode('|', $form_state->getValue('sort_by'));
  foreach ($links['#items'] as $link) {
    if ($link['#sort_field'] == $key) {
      $url_info = parse_url($link['#url']);        // path + query come from the TRUSTED link
      parse_str($url_info['query'], $query);
      $query['order'] = $order;                    // user-chosen direction
      $url_info['query'] = UrlHelper::buildQuery($query);
      $form_state->setRedirectUrl(Url::fromUserInput($url_info['path'] . '?' . $url_info['query']));
    }
  }
  ```
  - The `$key` must equal a real `#sort_field` from the block's links, or **nothing happens** (no
    redirect) — the field is validated against the trusted set.
  - The redirect **path is the sort link's own path**, not user input; only `order` is user-supplied,
    and it is URL-encoded by `UrlHelper::buildQuery`. search_api_sorts then reads `sort`/`order` from
    the query string and applies the sort. Result: the sort ends up in the URL (linkable, bookmarkable,
    back-button-safe).

## Placement / behavior notes for agents
- To get the widget on a page you place the **search_api_sorts** block (Block Layout or Layout
  Builder) for the relevant display — there is nothing named "Sorts Widget" to place.
- If the widget shows the plain link list even though the module is enabled, the display's
  `search_api_sorts_widget` config entity is missing or **not Active** — fix it on the Sorts widget tab.
- Auto-submit with the button hidden needs JavaScript; keep the button visible if no-JS/keyboard
  users must be able to submit.
