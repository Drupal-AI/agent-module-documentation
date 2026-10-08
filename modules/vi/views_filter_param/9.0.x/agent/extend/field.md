<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Filter Parameter — field & redirect

## The Views field
Plugin `Drupal\views_filter_param\Plugin\views\field\ViewsFilterParam` (`@ViewsField("filter_param_views_field")`).
- `query()` is intentionally empty (no DB work, no injection surface).
- `render(ResultRow)` reads `path.current` and `\Drupal::request()->query->all()` and returns
  `?destination-link=<current_path>&<key=value...>` (array filters become `key[]=value`).
- Exposed to rewrite as `{{ filter_param_views_field }}`; typically excluded from display and
  appended to an edit/delete link field.

## The redirect (.module)
`views_filter_param_form_alter()` adds `filter_redirect_submit_handler` when a `destination-link`
query param is present. The handler:
1. Reads `destination-link` and the remaining query params.
2. Rebuilds `"$destination?$param_url"`.
3. `Url::fromUri('internal:' . $url)` and `$form_state->setRedirectUrl($url)`.

### Review notes
- Target is user-controlled (`destination-link`); `internal:` keeps it same-site (external throws),
  but there is no allowlist and no path validation beyond that. Reflects raw query params.
- No SQL concatenation — filter values never reach a query builder here.
