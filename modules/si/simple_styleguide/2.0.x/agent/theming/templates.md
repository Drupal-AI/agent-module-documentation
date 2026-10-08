<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: templates, theme hooks, library

Defined in `simple_styleguide_theme()` and the `templates/` directory.

## Theme hooks

- **`simple_styleguide`** — the whole page. Variables:
  `default_patterns` (array of enabled built-in keys), `default_colors` (parsed palette:
  each item has `hex`, `rgb`, optional `class`, `description`), `custom_patterns` (array of
  loaded `styleguide_pattern` entities, each with a `template` render array), `form` (the
  embedded `StyleguideExamples` demo form). Template: `templates/simple-styleguide.html.twig`,
  which `include`s per-section partials in `templates/includes/` (`headings.html.twig`,
  `text.html.twig`, `lists.html.twig`, `blockquote.html.twig`, `rule.html.twig`,
  `table.html.twig`, `alerts.html.twig`, `breadcrumbs.html.twig`, `forms.html.twig`,
  `buttons.html.twig`, `pagination.html.twig`).
- **`simple_styleguide_pattern`** — one custom pattern. Variables: `pattern_id`, `pattern`
  (raw HTML). Template: `templates/simple-styleguide-pattern.html.twig`.

## Per-pattern template suggestion

`hook_theme_suggestions_simple_styleguide_pattern()` adds
`simple_styleguide_pattern__<pattern_id>`. So to override the markup of the custom pattern with
id `card`, add `simple-styleguide-pattern--card.html.twig` to your theme.

To restyle the whole page, override `simple-styleguide.html.twig` (or the individual
`includes/*.html.twig`) in your theme.

## Library

`simple_styleguide.default` (in `simple_styleguide.libraries.yml`): `css/simple-styleguide.css`
(theme group) + `js/simple-styleguide.js`, depending on `core/drupal` and `core/jquery`. It is
attached for the styleguide render output. Override or extend it from a theme with a
`libraries-override`/`libraries-extend` in your `*.info.yml` if you need different styling.

## noindex

`hook_page_attachments_alter()` injects `<meta name="robots" content="noindex, nofollow">` on
the `simple_styleguide.controller` route, so the styleguide page is never indexed even if the
`access style guide` permission is granted broadly.
