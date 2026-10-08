<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The dropdown Views pager

## Install & enable

```bash
composer require drupal/dropdown_pager
drush en dropdown_pager -y
```

Only dependency is core **`views`**. No sub-modules, no permissions, no Drush commands, no config
schema, no settings route.

## Select it on a View

The plugin `Dropdown` (`src/Plugin/views/pager/Dropdown.php`) is declared with
`#[ViewsPager(id: "dropdown", title: "Paged output, dropdown pager", short_title: "Dropdown",
theme: "views_dropdown_pager")]` and extends core `SqlBase`. So it appears in the standard Views
pager picker.

UI: edit a View → **Pager** → *Use pager* → **"Paged output, dropdown pager"** → gear icon to set
the options below → Save. Config equivalent (in the display's `pager` section of a
`views.view.*` config): `type: dropdown` with an `options` mapping.

## Plugin options

From `defineOptions()` (merged over `SqlBase`'s defaults) and `buildOptionsForm()`:

| Option key | Default | Meaning |
|---|---|---|
| `title` | `Pagination` | Used as the nav element `aria-label`. |
| `tags.first` | `« First` | First-page link text. |
| `tags.last` | `Last »` | Last-page link text. |
| `tags.previous` / `tags.next` | (from `SqlBase`) | Previous/Next link text. |
| `templates.dropdown_text_template` | `@current / @total` | Visible button text. Placeholders: `@current`, `@total`, `@start`, `@end`, `@items_total`. |
| `templates.button_label_template` | `Page @current of @total` | Visually-hidden button label for screen readers. Placeholders: `@current`, `@total`. |
| `templates.page_link_template` | `Page @page` | Per-page link text. Placeholders: `@page`, `@total`. |
| `search.search_enabled` | `FALSE` | Show a numeric search field inside the dropdown to jump to a page. |
| `search.search_text_placeholder` | `#` | Placeholder for that search field (only visible when search enabled). |
| `quantity` | `5` | Number of page links shown in the dropdown (`#min 1`). |

`buildOptionsForm()` also **removes** the `pagination_heading_level` field that `SqlBase` adds
(`unset($form['pagination_heading_level'])`). Items-per-page / offset come from the parent pager.
`summaryTitle()` renders the Views summary line (e.g. "Dropdown pager, 10 items, search enabled").

## Render flow

`Dropdown::render($input)` returns a render array with `#theme => 'views_dropdown_pager'`,
`#element => options['id']`, `#parameters => $input`, `#route_name` = `<current>` in live preview
else `<none>`, plus the option values above as `#title`, `#tags`, `#*_template`, `#search_*`,
`#quantity`, `#items_per_page` (`getItemsPerPage()`), `#total_items` (`getTotalItems()`), and
`#attached[library] = ['dropdown_pager/dropdown_pager']`.

## Hook class & preprocess (DropdownPagerHook)

`src/Hook/DropdownPagerHook.php` is an autowired service (`dropdown_pager.services.yml`) that
takes core's `PagerManagerInterface` (`pager.manager`) via constructor injection.
`dropdown_pager.module` only forwards `hook_theme()` and
`template_preprocess_views_dropdown_pager()` to it via `#[LegacyHook]`.

- `#[Hook('theme')] theme()` declares the `views_dropdown_pager` theme (template
  `views-dropdown-pager`) with its default variables.
- `#[Hook('preprocess_views_dropdown_pager')] preprocessViewsDropdownPager(&$variables)` builds the
  actual items. It calls `pagerManager->getPager($element)` (empty `items` if null), reads
  `getCurrentPage()`/`getTotalPages()`, and builds `items.first/previous/next/last` and
  `items.pages` (a windowed list of `quantity` pages centred on the current page, always including
  page 1 and the last page, with `ellipses.previous`/`ellipses.next` flags — mirroring core's
  pager math). Each link href is `Url::fromRoute($route_name, $route_parameters, [query =>
  pagerManager->getUpdatedParameters($parameters, $element, $page)])->toString()`.
- Link/label text is produced with `FormattableMarkup($template, [...])` **cast to a plain string**
  (`(string) new FormattableMarkup(...)`), for `page.text`, `dropdown_text` and
  `button_label_text`. `@start`/`@end`/`@items_total` in the dropdown text are computed from
  `items_per_page` and `total_items`.
- When `search_enabled`, it also builds `all_pages` (every page 1..total) so the client search can
  reveal pages outside the visible window. Sets `pager_id = 'dropdown-pager-' . $element`.

## Template & library

`templates/views-dropdown-pager.html.twig` (only renders when `total_pages > 1`): a
`<nav class="pager pager--dropdown">` with First/Previous list items, a `<button
class="pager__dropdown-button" aria-haspopup="listbox">` showing `dropdown_text` + a
visually-hidden `button_label_text`, and a `<ul role="listbox" class="pager__dropdown-list">` of
`role="option"` items (one per page, with `data-pager-page`, `aria-selected`, `aria-current`),
optional numeric `<input type="number">` search field, ellipsis `role="presentation"` items, and
Next/Last items. All dynamic values (`page.text`, `dropdown_text`, `button_label_text`, `title`,
tag labels, hrefs, placeholder) print through Twig auto-escaping. Override this template to
re-theme the pager.

Library `dropdown_pager/dropdown_pager` (`dropdown_pager.libraries.yml`): `css/dropdown-pager.css`
(styling via CSS custom properties on `:root`) + `js/dropdown-pager.js`, deps `core/drupal`,
`core/jquery`, `core/drupal.ajax`, `core/once`. `js/dropdown-pager.js`
(`Drupal.behaviors.dropdownPager`, using `once` on `.pager--dropdown`) wires open/close, outside-
click close, full keyboard nav (Enter/Space/Arrows/Home/End/Escape, `aria-activedescendant`), and
the search field (numeric-only input, filters `data-pager-page` items, hides ellipses while
searching). It re-processes after AJAX (`once.remove(...)` then `once(...)`).

## Operating notes

- Purely presentational: the View's SQL query, results and access are unchanged (it extends the
  same `SqlBase` as core's mini/full pagers).
- All configurable text is set by a Views administrator; it is escaped on output (Twig
  auto-escaping over strings cast from `FormattableMarkup`), so template markup renders as text,
  not as executable HTML.
- No config schema ships, so strict config-schema validation may flag the pager `options` in the
  View config; the options still save and work.
