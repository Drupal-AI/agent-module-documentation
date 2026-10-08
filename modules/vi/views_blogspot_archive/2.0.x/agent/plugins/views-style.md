<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `views_blogspot_archive` Views style plugin

The module's entire surface is one Views **style plugin**. It takes the view's already-executed
result rows, groups their entities by year → month in PHP, and renders a nested `item_list` (the
Blogspot-style archive tree with per-year and per-month post counts). No routes, services,
permissions, drush, SQL, or new plugin types.

## The plugin

`src/Plugin/views/style/ViewsBlogspotArchive.php` — `@ViewsStyle` annotation:

- `id = "views_blogspot_archive"`, `title = "Views Blogspot Archive"`
- `theme = "views_blogspot_archive_view_archive"`, `theme_file = "views_blogspot_archive.theme.inc"`
- `display_types = {"normal"}`, `$usesGrouping = FALSE`
- Extends `StylePluginBase`. Injects `entity_type.manager` (used only in the options form to list
  candidate archive-result-page routes).

Select this style on any Views display (Format → "Views Blogspot Archive"). The view is expected to
return the **full** result set (set the pager to *Display all items* / none) — the archive counts and
tree are built by counting the rows PHP-side, so a paged view yields an incomplete archive.

## Options (`defineOptions` / `buildOptionsForm`)

| Option | Type | Default | Purpose |
|---|---|---|---|
| `vba_field_name` | textfield (required) | `''` (form shows `created`) | Machine name of the **date field** the archive groups on. Read off each result entity via `$entity->get($vba_field_name)`. Must be a date/timestamp field on the row's entity. |
| `vba_use_result_page` | checkbox | `FALSE` | "Link archive items" — turns year/month labels into links to an archive result page (linked mode) instead of JS-collapsible carets (unlinked mode). |
| `vba_view_name` | select | `FALSE`/`NULL` | Route name of the view **page display** to link to, e.g. `view.<view_id>.page_1`. The select is populated from every view display that has a `path`. |

**Config quirk (verified against source):** `defineOptions()` and `config/schema/views_blogspot_archive.schema.yml`
declare `vba_field_name`, `vba_view_name`, `vba_use_result_page` at the **top level**, but
`buildOptionsForm()` nests the last two inside a `vba_style` fieldset, so they save under
`options.vba_style.vba_view_name` / `options.vba_style.vba_use_result_page`. The preprocess reads the
**nested** path (`$style['vba_style'][...]`). Consequences: (1) the linked/unlinked decision hinges on
the nested `vba_style` mapping, which the schema does not describe; (2) the shipped example view
(`config/optional/views.view.viewsblogspot_archive.yml`) sets `vba_view_name` at top level and omits
`vba_style`, so it renders in **unlinked** (JS caret) mode regardless of the top-level value.

## Rendering pipeline (`templates/views_blogspot_archive.theme.inc`)

`template_preprocess_views_blogspot_archive_view_archive()`:

1. Iterate `$variables['rows']`; for each `$row->_entity` that is `FieldableEntityInterface` and
   `hasField($vba_field_name)`, read the first field value. Numeric → `DrupalDateTime::createFromTimestamp()`;
   otherwise resolve the field's `datetime_type` setting and parse with the matching
   `DATE_STORAGE_FORMAT` / `DATETIME_STORAGE_FORMAT`. Parse failures are swallowed (`try/catch`, `@todo`).
2. Bucket into `$data[Y][m::F][entity_id] = $entity]`.
3. `views_blogspot_archive_add_count()` rewrites keys to append PHP `count()` totals, e.g.
   `2024 (12)` and `03::March (4)`. Counts are computed in PHP over the loaded rows — **not** a SQL
   `GROUP BY`/`COUNT` query.
4. Decide which year/month to auto-expand: first from the current route's entity parameter
   (`\Drupal::routeMatch()->getParameters()` — e.g. the node being viewed), else, when the current
   `_route` equals the configured `vba_view_name`, from the `year` / `month` **query parameters**.
5. Linked mode (`vba_style.vba_use_result_page`) → `views_blogspot_archive_with_link()`; else
   `views_blogspot_archive_without_link()` and attach the JS/CSS library.
6. Assign `$variables['views_blogspot_archive']` as a `#theme => 'item_list'` render array with
   `#cache.contexts = ['url.query_args:year', 'url.query_args:month', 'url.path']`. The Twig template
   just prints `{{ views_blogspot_archive }}`.

### Two render modes
- **`views_blogspot_archive_without_link()`** — every year/month is a `<span class="caret"><a>…</a></span>`
  plus count; every entity in every month is rendered as a `Link::fromTextAndUrl($entity->label(), $entity->toUrl())`.
  Expansion is client-side via the attached library.
- **`views_blogspot_archive_with_link()`** — year and month become links built with
  `Url::fromRoute($vba_view_name, [], ['query' => ['year' => …, 'month' => …]])`; entity links are
  rendered only for the currently active (expanded) month. No library is attached in this mode.

Empty result → a single `t('No posts available.')` item.

## Escaping / data flow (why the string concatenation is safe)
The `#markup` strings concatenate only date-format output (`format('Y')`, `format('m')`, month name
from `format('F')`) and integer `count()` values; entity titles/URLs go through `Link`/`Url` (auto-escaped).
The `year`/`month` **query parameters** are used only for expand-branch comparison and, for month, fed
through `mktime()`/`date('m', …)` (integer context) — they are never emitted into markup. No
user-supplied string reaches output unescaped.

## Assets & example view
- Library `views_blogspot_archive/views_blogspot_archive` (`views_blogspot_archive.libraries.yml`):
  `css/views_blogspot_archive.css` + `js/views_blogspot_archive.js`; deps `core/drupal`, `core/once`.
  JS: `Drupal.behaviors.views_blogspot_archive` binds `.caret` clicks to toggle the nested `<ul>` and
  the `caret-down` class. Attached only in unlinked mode.
- Example view `config/optional/views.view.viewsblogspot_archive.yml` (id `viewsblogspot_archive`):
  a Block display using this style plus a Page display (`path: viewsblogspot-archive`) with
  `date_month` / `date_year` contextual arguments defaulted from the `month` / `year` query params —
  the pair that wires the archive links to a filtered result page.
