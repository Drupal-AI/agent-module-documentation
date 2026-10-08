<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `[view:exposed-input]` token

The entire module is `views_exposed_input_token.module`: two Token hooks plus one internal helper.
There is no service, plugin, route, config or permission.

## What the token is

- Machine name: `[view:exposed-input]`, registered under the **`view`** token type by
  `views_exposed_input_token_token_info_alter()` (`views_exposed_input_token.module:66`).
  Name "Exposed input", description "The exposed input as a query string with `?` prefix."
- It resolves to the current view's exposed input as a **URL query string**, e.g. `?id=3`,
  `?title=hello&page=2`, or the **empty string** when the view has no exposed input.
- Because it belongs to the `view` type, it only resolves where a `view` object is supplied to
  token replacement — i.e. `Token::replace($text, ['view' => $view])`. In practice: Views Global
  text areas (header, footer, empty text with tokens enabled), the view **title**, and area
  handlers such as the custom-text area. It does **not** resolve in a node/term/user token
  context (no `$data['view']` there).

## How the value is built

`views_exposed_input_token_tokens()` (`:76`) delegates to the internal helper
`_views_exposed_input_token_get_query_string(ViewExecutable $view)` (`:31`):

1. `$query = $view->getExposedInput();` — the exposed filter/sort input for the **current request
   only** (the visitor's own submitted GET values).
2. If `$view->getCurrentPage()` is truthy, sets `$query['page'] = $current_page` (so page 0 is
   omitted, page 1+ becomes `page=N`).
3. Removes internal Views routing keys that live in the same array (`:40-51`): `view_name`,
   `view_display_id`, `view_args`, `view_path`, `view_dom_id`, `pager_element`, `view_base_path`,
   plus `AjaxResponseSubscriber::AJAX_REQUEST_PARAMETER`, `FormBuilderInterface::AJAX_FORM_REQUEST`,
   `MainContentViewSubscriber::WRAPPER_FORMAT`.
4. Returns `'?' . http_build_query($query)`, or `''` when that would be a bare `?`.

`http_build_query()` URL-encodes every key and value, so the returned string is safe to append
directly to an `href`.

## Typical use — a filtered "view more" link

Put the token at the tail of a URL in a Views area. Example from the module's own test view
(`tests/.../views.view.views_exposed_input_token_views_test.yml`), a Global: Text area whose
content is:

```html
<a href="/views-exposed-input-views-test[view:exposed-input]">Test</a>
```

When the visitor has applied `id = 3`, the rendered link is
`/views-exposed-input-views-test?id=3`. The module's functional test asserts this output is
identical to what core's Views `display_link` area produces for the same-view case
(`tests/src/Functional/ViewsExposedInputTokenTest.php`).

Common pattern: a **block display** showing a few filtered rows, with a footer link to the full
**page display** so the visitor keeps their filters:

```html
<a href="/full-listing[view:exposed-input]">See all results</a>
```

Unlike core's `display_link` (which links to another display of the *same* view), the token can
be appended to **any** path — a different route, an RSS feed, a print view.

## Relation to core

- The `view` token type and the `Token` service both come from core (`views` + `token`
  integration in core). This module only adds the one `exposed-input` token to that type.
- Overlaps functionally with the Views `display_link` area handler for the same-view "view more"
  case; the token generalises it to arbitrary link targets and any token-aware area.

## Calling it from code

The token is normal Token API, so from PHP:

```php
$qs = \Drupal::token()->replace('[view:exposed-input]', ['view' => $view]);
// $qs === '?id=3' (or '' when no exposed input)
```

The helper `_views_exposed_input_token_get_query_string()` is marked `@internal` — call the token
rather than the function.
