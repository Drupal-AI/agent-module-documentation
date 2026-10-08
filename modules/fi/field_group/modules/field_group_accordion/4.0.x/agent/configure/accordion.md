# Configure accordion groups

> Deprecated: jQuery UI is end-of-life. For new sites use **Details** or **Tabs**
> ([field_group configure](../../../../field_group/4.0.x/agent/configure/field-groups.md)).

Two `FieldGroupFormatter` plugins are added (they extend field_group's plugin type):

| Format | id | Role |
|---|---|---|
| Accordion | `accordion` | Outer container; holds accordion items |
| Accordion item | `accordion_item` | One collapsible section |

## Steps

1. On **Manage form display** / **Manage display**, **Add group** → choose **Accordion**.
2. Add one or more **Accordion item** groups and set their `parent_name` to the Accordion
   (drag them under it in the UI).
3. Drag fields into each Accordion item.

## Settings

- Accordion item: `label`, `open` (whether this section starts expanded / is the active pane).
- Stored as third-party settings on the display config entity (schema
  `field_group_accordion.field_group_formatter_plugin.schema.yml`), so it exports with config.

## Rendering / theming

Render elements: `src/Element/Accordion.php`, `src/Element/AccordionItem.php`. Templates you
can override: `field-group-accordion.html.twig`, `field-group-accordion-item.html.twig`. The
widget behavior comes from `js/accordion.js` and the core `jquery_ui_accordion` library.
