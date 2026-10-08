<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pager override mechanism

How Extra Pagination replaces and extends Drupal's core pager. All logic is procedural; there are no classes.

## 1. Redirect the `pager` theme hook — `extra_pagination.module`

`extra_pagination_theme_registry_alter(&$theme_registry)` sets
`$theme_registry['pager']['path'] = <module_path> . '/templates'` (module path from
`extension.list.module`). This makes core's existing `pager` theme hook resolve to this module's
`templates/pager.html.twig` instead of core's, site-wide, with **no** `hook_theme` of its own. Run `drush cr`
after enable so the registry picks up the new path.

## 2. Rebuild the pager variables — `extra_pagination_preprocess_pager(&$variables)`

Implements `template_preprocess_pager()`. Reads from the pager render array:
`#element`, `#parameters`, `#quantity` (default 9), `#tags`, `#route_name`, `#route_parameters`. Uses the
`pager.manager` service:

- `getPager($element)`; returns early (no pager) if missing or `getTotalPages() <= 1`.
- Computes `current_page`, `total_pages`.
- Builds `variables['items']['first'|'previous']` when `current_page > 0`, and `['next'|'last']` when
  `current_page < total_pages - 1`. Each item's `href` = `Url::fromRoute($route_name, $route_parameters,
  ['query' => $pager_manager->getUpdatedParameters($parameters, $element, <target>)])->toString()`; `text` from
  `#tags` fallbacks (`First`/`Previous`/`Next`/`Last`) via `t()`; `attributes` = empty `new Attribute()`.
- Numbered window: `start = max(1, current_page + 1 - ceil(quantity/2))`, `end = min(total_pages, start +
  quantity - 1)`; loops `$i` from `start..end` into `items['pages'][$i]` with page text = `$i`. Sets
  `ellipses['previous']`/`['next']` when the window is clipped.
- Then `require_once includes/pager.inc` and appends `items['extra'] = pager_extra_pages($pager_last,
  $pager_max, $route_parameters, $parameters, $element)` where `$pager_last = current_page + quantity -
  ceil(quantity/2)` and `$pager_max = $pager->getTotalPages()`.

## 3. Extra jump links — `pager_extra_pages()` in `includes/pager.inc`

Signature `pager_extra_pages($pager_last, $pager_max, $route_parameters, $parameters, $element)`. Starting at
`floor($pager_last / 10) * 10`, it steps `+base` (base starts at 10) while `($i + $base) < $pager_max`; for each
step (skipping the one adjacent to `pager_last`, `abs($i - pager_last) > 1`) it sets
`$items[$i]['href'] = Url::fromRoute('<current>', $route_parameters, ['query' =>
$pager_manager->getUpdatedParameters($parameters, $element, $i)])`. After 10 steps the interval widens
(`$base = $base * $base` → 100), so very large sets get sparse far-out jumps. Returns `$items` keyed by page
number. Note the `href` here is a `Url` object (rendered by Twig), unlike section 2 which stores strings.

## 4. Template — `templates/pager.html.twig`

A copy of core's pager template plus one extra block: after the `items.pages` loop (and the `ellipses.next`
marker) it iterates `items.extra` into `<li class="pager__item pager__item--extra">` with an
`aria` label and the page number as link text. All links are `<a href="{{ item.href }}">` with Twig
auto-escaping; item text is an integer page number or a `t()`-translated label; item attributes use
`|without(...)`. There is no `|raw` and no user/remote-supplied string rendered into markup.

## Operate / gotchas

- No configuration; behavior is automatic wherever core renders a pager.
- The numbered-window size follows the pager's `#quantity` (default 9); Extra Pagination does not expose a
  setting to change it.
- Because it overrides the global `pager` template, a theme that ships its own `pager.html.twig` may win by
  theme-registry precedence — verify the extra items render in your active theme; clear cache after enable.
- Uninstalling removes the registry alter and restores the core pager.
