<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: theme hooks, templates & bundled SDC

Declared in `cl_editorial_theme()` (`hook_theme()`).

## Theme hooks

| Hook | Render element | Template | Used by |
|---|---|---|---|
| `cl_component_selector` | `element` | `templates/cl-component-selector.html.twig` | wrapper around the `cl_component_selector` form element |
| `form_element__radio__cl_component` | `element` | `templates/form-element--radio--cl-component.html.twig` | each component radio (renders name, status, thumbnail, README) |

Each radio row is populated (in `ComponentSelectorElement::processRadios()`) with variables such as
`#human_name`, `#machine_name`, `#component_description`, `#component_status`, `#group`,
`#thumbnail_url`, and `#readme` (admin-filtered HTML). Override the templates in your theme to
restyle the picker.

## Libraries

Defined in `cl_editorial.libraries.yml`:
- `cl_editorial/options-filter` — JS (`core/once`) + CSS that powers the searchable component list.
- `cl_editorial/filter-settings` — CSS for the allowed/forbidden filter sub-form
  (`ComponentFiltersFormTrait` attaches it).

## Bundled SDC: `cl_editorial:component-card`

A demo Single Directory Component at `components/component-card/` (`component-card.component.yml`,
`.twig`, `.css`). Props: `name`, `machineName`, `id`, `description`, `status`
(experimental|stable|deprecated|obsolete), `thumbnailHref`, `group`. Render it like any SDC:

```php
$build['card'] = [
  '#type' => 'component',
  '#component' => 'cl_editorial:component-card',
  '#props' => [
    'name' => 'Button',
    'description' => 'A call to action',
    'status' => 'stable',
    'group' => 'Atoms',
    'thumbnailHref' => '',
  ],
];
```

sdc_tags' tagging admin page uses this component to preview tagged components.
