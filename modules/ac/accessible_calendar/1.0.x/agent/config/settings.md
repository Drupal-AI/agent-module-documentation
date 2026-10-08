<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, theming & building a calendar View

There is **no admin settings form and no config/install object** — all configuration is stored in
the Views display (the style/pager option arrays). The only config artifact is the schema.

## Config schema

`config/schema/accessible_calendar.views.schema.yml` defines `accessible_calendar.view_style`
(mapping: `calendar_fields` sequence, `calendar_display_rows` bool, `calendar_weekday_start` bool,
`calendar_sort_order` string, `calendar_timestamp` string, `calendar_title` label,
`calendar_row_title` label), mapped onto `views.style.calendar_month` and
`views.style.calendar_week` (the latter adds `calendar_work_week` bool). Pager options are stored
under the standard Views pager schema. A sample test View is at
`tests/modules/accessible_calendar_test_config/test_views/views.view.accessible_calendar_by_month_test.yml`.

## Theme hooks & templates

Declared in `accessible_calendar_theme()` (`accessible_calendar.module`); preprocessors and
suggestion alters in `accessible_calendar.theme.inc`:

- `views_view_calendar` → `templates/views-view-calendar.html.twig` — wraps `{{ calendars }}`,
  attaches library `accessible_calendar/calendar`, exposes each `calendar_*` option (minus prefix)
  as `options.*`, and optionally renders plain rows when `options.display_rows`.
- `accessible_calendar_day` (render element) → `templates/accessible-calendar-day.html.twig` —
  one cell: a visually-hidden day summary ("{day}, {n} results" via `{% trans %}`), a `<time>`
  day number, and a `<ul>` of event rows. `template_preprocess_accessible_calendar_day()` rebuilds
  each row through core `template_preprocess_views_view_unformatted()`, sets an
  `accessible_title` and a `data-accessible-calendar-hash`, and sorts multiday events by
  `first_instance`.
- `accessible_calendar_pager` → `templates/accessible-calendar-pager.html.twig` (see
  [../plugins/pager-filter.md](../plugins/pager-filter.md)).
- `views_view__style__accessible_calendar` — base-hook override; plus
  `templates/views-view--style--calendar.html.twig` places the pager above the calendar.

**Template suggestions** (in `.theme.inc`): per view id and display id for the day cell, pager, and
the calendar table (`accessible_calendar_theme_suggestions_*_alter`), plus
`accessible_calendar_day__empty` for empty days. Override per-View for custom theming.

## Library

`accessible_calendar/calendar` (`accessible_calendar.libraries.yml`): `js/accessible-calendar.a11y.js`
(announce + focus after AJAX), `css/accessible-calendar.css` + `css/accessible-calendar.default.css`;
deps `core/drupal`, `core/once`, `core/drupal.announce`. Override the Twig `libraries` block to swap
in your own CSS (see `css/accessible-calendar.example.css`).

## Build a calendar View (quick recipe)

1. `drush en accessible_calendar` (optionally `accessible_calendar_multiday`).
2. New View of your content; add ≥1 supported **date field** under *Fields* (may be excluded from
   display).
3. *Format* → **Calendar by month** (or week); in settings tick the field under **Date fields**;
   set first day of week, default date, title token, and optional row title.
4. *Pager* → **Accessible Calendar navigation by month/week**.
5. Optionally add & expose the **Jump to** filter (Accessible Calendar group) and turn on **Use
   AJAX** on the display for in-place navigation with announcements.
6. Constrain data with a Views date filter (offset filters auto-rebase to the viewed period) for
   performance on large datasets.
