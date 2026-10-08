<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Blogspot Archive (views_blogspot_archive) — agent index

A single Views **style plugin** (`id = views_blogspot_archive`) that renders a view's result set as a
Blogspot-style **year → month archive tree** with per-year and per-month post counts. You pick the
style on a Views display, name the **date field** to group on (`vba_field_name`), and the plugin's
preprocess (`templates/views_blogspot_archive.theme.inc`) buckets each result entity by
`format('Y')` / `format('m')`, appends `count()` totals, and emits a nested `#theme => 'item_list'`.
Entity titles link via `Link::fromTextAndUrl($entity->label(), $entity->toUrl())`.

The grouping and counts are computed **in PHP over the rows the view already returned** — there is no
SQL `GROUP BY`/`COUNT` and no query of its own — so the view must return the full result set (pager =
none) for the archive to be complete, and the real cost is loading every matching entity. Two render
modes: **unlinked** (default) renders JS-collapsible `.caret` year/month nodes and attaches the
CSS/JS library; **linked** (`vba_use_result_page`) makes year/month labels link to a configured view
page display (`vba_view_name`, route `view.<id>.page_1`) carrying `year`/`month` query params, and
attaches no library.

- **Depends on:** `drupal:views` (info.yml). No other modules; no composer.json.
- **Core:** `^10 || ^11`. **Package:** Content display. **Version:** 2.0.2.
- **Settings page / configure route:** none — configured entirely in the Views UI style-options form.
- **Permissions:** none. **Drush:** none. **Services:** none. **Routes:** none. **New plugin types:** none.
- **Provides:** one Views style plugin, config schema (`views.style.views_blogspot_archive`), a
  library, and an optional example view.

## What you'd do → where
- Understand / configure the style plugin, its options, render modes, and the config quirk →
  [`agent/plugins/views-style.md`](plugins/views-style.md)

## Key facts (real machine names)
- Style plugin id: `views_blogspot_archive` (`src/Plugin/views/style/ViewsBlogspotArchive.php`).
- Theme hook: `views_blogspot_archive_view_archive`; theme file `views_blogspot_archive.theme.inc`;
  template `views-blogspot-archive-view-archive.html.twig`; preprocess
  `template_preprocess_views_blogspot_archive_view_archive()`.
- Style options: `vba_field_name` (required date field), `vba_use_result_page` (bool),
  `vba_view_name` (target view page route). Config schema type `views.style.views_blogspot_archive`.
- Helpers: `views_blogspot_archive_add_count()`, `views_blogspot_archive_with_link()`,
  `views_blogspot_archive_without_link()`.
- Library: `views_blogspot_archive/views_blogspot_archive` (css + js; deps `core/drupal`, `core/once`);
  JS behavior `Drupal.behaviors.views_blogspot_archive` toggles `.caret`.
- Example view: `viewsblogspot_archive` (`config/optional/…`), Page display path `viewsblogspot-archive`.
