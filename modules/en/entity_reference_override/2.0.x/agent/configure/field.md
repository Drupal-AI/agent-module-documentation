# Configure — the entity_reference_override field

No global config. Everything is per-field, set on **Manage fields / Manage form display /
Manage display** of any fieldable bundle. (Field UI: add a field, pick **"Entity reference
w/custom text"** under *Reference*.)

## Storage & field settings

Field type `entity_reference_override` (subclass of core `EntityReferenceItem`). It reuses all
the normal entity-reference storage/field settings (`target_type`, `handler`,
`handler_settings`, cardinality) and adds:

- **Two storage columns:** `override` (varchar, length 4094, nullable) and
  `override_format` (varchar 255, nullable).
- **Field settings** (`field.field_settings.entity_reference_override` schema):
  - `override_label` (string) — the label shown above the custom-text box (and the placeholder
    for multi-value instances). Default `Custom text`.
  - `override_format` (string) — a text-format id, or empty/NULL. **NULL = "Single line, no
    markup"**, a plain textfield; this is the only mode in which you can override a **label** or
    a **CSS class**. Choosing any filter format turns the override into a `text_format` (WYSIWYG)
    element for overriding an actual **text field**.

Set programmatically via the field config's `settings`:

```php
$field_config->setSetting('override_label', 'Display title');
$field_config->setSetting('override_format', NULL); // plain line
$field_config->save();
```

## Widgets (Manage form display)

Both add the override text element beside the reference input (via `OverrideTextWidgetTrait`):

- `entity_reference_override_autocomplete` — **default**, extends the core autocomplete widget.
- `entity_reference_override_select` — extends the core options-select widget.

When `override_format` is a real format the box becomes a 2-row `text_format` area restricted to
that format; a form `#element_validate` (`entity_reference_override_validate_custom_text`)
flattens the `{value, format}` back into the `override` / `override_format` columns.

## Formatters (Manage display)

### `entity_reference_override_label` (default)

Renders the referenced entity's label as a link, then applies the override according to the
**`override_action`** setting (radios, required, default `title`):

| `override_action` | Effect when an override value is present |
|---|---|
| `title` | Replace the link text with the override |
| `title-append` | Append ` (override)` to the label |
| `suffix` | Add ` (override)` as a suffix after the link |
| `class` | Add the override string as a CSS class on the link |
| `hide` | Render nothing extra (hide) |

```bash
# via config: the formatter setting lives on the entity view display
drush php:eval "\$d=\Drupal::service('entity_display.repository')->getViewDisplay('node','article'); \
\$c=\$d->getComponent('field_my_ref'); \$c['settings']['override_action']='suffix'; \
\$d->setComponent('field_my_ref',\$c)->save();"
```

### `entity_reference_override_entity`

Renders the **full referenced entity** (extends the core "Rendered entity" formatter) and, using
its own `override_action` setting, can inject the override text into a chosen **stringy field**
(`string`, `text_long`, or `email`) on the rendered entity — i.e. replace one field of the
referenced entity for this placement only.

## Constraints

There is exactly **one** override text field per instance, so only **one** aspect (title, class,
note, or one field) can be overridden at a time. There is no permission and no settings form.
