<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates & theme hooks

`hook_theme()` registers three render elements, one per wrapper type. Each includes
`views-view-fields.html.twig` to print the child fields.

| Theme hook | Template | Variables |
|---|---|---|
| `views_fieldsets_fieldset` | `views-fieldsets-fieldset.html.twig` | `fields`, `attributes`, `show_fieldset`, `legend`, `collapsible`, `collapsed` |
| `views_fieldsets_details` | `views-fieldsets-details.html.twig` | `fields`, `attributes`, `show_fieldset`, `legend`, `collapsed` |
| `views_fieldsets_div` | `views-fieldsets-div.html.twig` | `fields`, `attributes`, `show_fieldset` |

Markup (only emitted when `show_fieldset` is true):

- `fieldset` → `<fieldset>` + optional `<legend>`.
- `details` → `<details>` + optional `<summary>` (legend).
- `div` → plain `<div>` (no legend).

`attributes` already carries the wrapper `classes` (tokenized) and, when
`collapsed` is set on a non-`div` wrapper, the `collapsed` class.

## Theme hook suggestions (override granularity)

`RowFieldset::themeFunctions()` builds suggestions from most to least specific.
For hook `views_fieldsets_<type>`, with view id `V`, display id `D`, field id `F`:

```
views_fieldsets_<type>__V__D__F
views_fieldsets_<type>__V__D
views_fieldsets_<type>__D__F
views_fieldsets_<type>__D
views_fieldsets_<type>__V__F
views_fieldsets_<type>__V
views_fieldsets_<type>__F
views_fieldsets_<type>
```

So `views-fieldsets-fieldset--myview--page--group.html.twig` targets one field on
one display; `views-fieldsets-details--page.html.twig` targets a display; etc.
(The README's `.tpl.php` references are legacy — Drupal 11 uses `.html.twig`.)

## Extra paragraph suggestions

The module also implements `hook_theme_suggestions_paragraph()`
(`themeSuggestionsParagraph()`), adding `paragraph__<view_mode>`,
`paragraph__<bundle>`, and `paragraph__<bundle>__<view_mode>` suggestions — useful
when fieldset-grouped views render paragraph fields.

## Admin CSS

`views_fieldsets/admin` library (`css/views-fieldsets-admin.css`) is attached to the
Views UI display tab to visually mark fieldset rows (`views-fieldsets-fieldset`) and
indentation levels (`views-fieldsets-level-N`).
