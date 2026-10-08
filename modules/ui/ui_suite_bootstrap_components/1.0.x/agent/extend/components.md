<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Suite Bootstrap components — component reference

All components are SDC (`components/<name>/<name>.component.yml` + `<name>.twig`).

## card ("Card teaser")
Group: Card. Slots: `image` (only first shown), `header`, `content`, `footer`.
Props (all `ui-patterns://attributes`): `header_attributes`, `footer_attributes`,
`row_attributes` (default class `g-0`), `image_col_attributes` (default `col-md-4`),
`content_col_attributes` (default `col-md-8`). Supports a horizontal variant.

## hero
Banner component; ships example stories: `hero.default`, `hero.default_dark`,
`hero.horizontal`, `hero.horizontal_dark` under `components/hero/stories/`.

## features
Feature-grid layout component.

## comment
Styled comment component.

## Consuming
- UI Patterns / UI Suite layouts and Layout Builder select these by group/name.
- Direct Twig: `{{ include('ui_suite_bootstrap_components:card', { header: '...', content: '...' }) }}`.
- Sub-themes attach CSS through each component's `libraryOverrides` (fake library) hook.

## Icons
`ui_suite_bootstrap_components.icons.yml` registers an Icon API pack (Drupal core icons,
path/URL extractors) selectable wherever the Icon API is used.
