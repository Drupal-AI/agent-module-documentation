# Theming field groups

Groups render through core render elements plus a couple of field_group templates and theme
hooks (registered in `field_group.module`: `field_group_theme()`).

## Templates (override in your theme)

| Template | Group format |
|---|---|
| `field-group-html-element.html.twig` | HTML element (`html_element`) |
| `horizontal-tabs.html.twig` | Horizontal tabs container |
| `field-group-accordion.html.twig` / `field-group-accordion-item.html.twig` | Accordion (deprecated submodule) |

Details, Fieldset and Vertical tabs reuse **core** templates
(`details.html.twig`, `fieldset.html.twig`, `vertical-tabs.html.twig`).

## Render elements

Defined under `src/Element/`: `HtmlElement`, `HorizontalTabs`, `VerticalTabs`. The
`html_element` format lets editors choose the wrapper tag, add classes/attributes and an
optional label tag straight from the group settings — usually enough without a template
override.

## Theme suggestions

`field_group_theme_suggestions_alter()` adds suggestions so you can target a group by name,
e.g. override `field-group-html-element--<group-name>.html.twig`. `field_group.field_ui.css`
and `formatters/tabs/horizontal-tabs.css` style the admin/tabs UI; attach your own CSS/JS to
a group with `#attached` from `hook_field_group_pre_render()`
([../hooks/hooks.md](../hooks/hooks.md)).
