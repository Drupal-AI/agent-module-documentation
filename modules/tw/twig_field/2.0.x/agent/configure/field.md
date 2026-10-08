# Configure a Twig field

No global settings page. You add a **Twig template** field (type `twig`) to a bundle, then configure its
widget on *Manage form display* and formatter on *Manage display*.

## Field type — `TwigItem`

- One property `value` (`string`), stored as a `big` text column.
- Default widget `twig`, default formatter `twig`.
- Field setting `display_mode` (`field.field_settings.twig`): an entity view display id
  (`<entity_type>.<bundle>.<view_mode>`) or `''` (None). When set, that display is rendered and each of
  its field components is exposed to the template as a Twig variable (see Context below).

## Widget — `TwigWidget` ("Template editor")

CodeMirror-backed editor (uses `CodeMirrorPluginTrait`; required modes `xml`, `twig`, `javascript`,
`css`). Widget settings (schema reuses `field.widget.settings.codemirror_editor`):
- `rows` (default 5), `placeholder` (default '').
- CodeMirror flags: `toolbar`, `lineWrapping`, `lineNumbers`, `foldGutter`, `autoCloseTags`,
  `styleActiveLine` (mode is fixed to `html_twig`, not user-selectable).
- A "Variables" select + "Insert" button (footer, client-side only) let the editor drop an available
  context key into the template. Footer is stripped in `massageFormValues()` before save.
- **Validation:** `#element_validate => validateTemplate()` compiles the template with
  `renderer->renderInIsolation()` using only the global context; a Twig error blocks the save with
  `Template error: …`.

## Formatter — `TwigFormatter` ("Rendered Twig template")

Each item is rendered as:
```php
['#type' => 'inline_template', '#template' => $item->value, '#context' => $context]
```
So the stored value is **executed as Twig**. (Security: see permissions doc + the by-design note there.)

## Twig context available in templates

1. **Global** (`twig_field_default_context()` in `twig_field.module`):
   `theme`, `theme_directory`, `base_path`, `front_page`, `is_front`, `language`, `is_admin`
   (`access administration pages`), `logged_in`.
2. **Per-field** (only if the field's `display_mode` setting is set): the referenced entity view display
   is built; every rendered component field becomes a context variable keyed by field name (the Twig
   field itself is removed to avoid recursion; per-field `#cache` metadata is merged with the entity's).
3. **Host entity**: the entity object keyed by its entity type id (e.g. `node`, `taxonomy_term`).

Both the widget's variable picker and the formatter's context can be extended by other modules — see
[../hooks/twig_field.md](../hooks/twig_field.md).
