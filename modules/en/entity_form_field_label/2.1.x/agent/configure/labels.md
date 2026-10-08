# Relabeling a field per mode

No admin page. You set overrides inside the settings of a field **widget** (form) or **formatter**
(display).

## UI steps

1. Go to *Manage form display* (for form labels) or *Manage display* (for display labels) of the
   bundle/mode, e.g. `/admin/structure/types/manage/article/form-display`.
2. Click the gear/settings for the field.
3. Tick **Rewrite label**. A **New label** textfield appears (via `#states`).
4. Enter the new label, or leave it empty to remove the label entirely.
5. Update, then Save.

Repeat on each form/display mode to give the field different labels per mode.

## Stored settings

Third-party settings namespace `entity_form_field_label`:

| Key | Type | Meaning |
|---|---|---|
| `rewrite_label` | int/bool | Whether the override is active. |
| `new_label` | string | Replacement label; empty string = hide the label. |

Schema: `field.widget.third_party.entity_form_field_label` and
`field.formatter.third_party.entity_form_field_label` (both `new_label` + `rewrite_label`). These live
inside the `entity_form_display` / `entity_view_display` config, so they export and deploy with it.

Example (in an entity form display config):

```yaml
content:
  field_attachments:
    type: file_generic
    third_party_settings:
      entity_form_field_label:
        rewrite_label: 1
        new_label: 'Documents'
```

## Composite fields — the `||` separator

For multi-part fields (e.g. Date Range, name), separate one label per sub-element with `||`:

```
Event Start Date||Event End Date
```

`hook_field_widget_complete_form_alter()` splits `new_label` on `||` and applies each part to the
corresponding child element (`_entity_form_field_label_replace_title_recursive`). Single-value fields
just use the whole string.

## How it is applied

- **Forms:** `entity_form_field_label_field_widget_complete_form_alter()` — special-cases
  `entity_reference`/`entity_reference_revisions` (also sets `#field_title` and per-delta titles for
  multi-value), `color_field_type` (ignores `color`/`opacity` children), and a default recursive
  title-replace path.
- **Display:** `entity_form_field_label_preprocess_field()` sets `$variables['label']` from the
  formatter's third-party settings.
- **Summaries:** a "Label alterations: …" line is appended to the widget/formatter settings summary.

## Caveats

- The module's own README notes some field types may not be supported and may need a small code tweak.
- Hiding the label uses `#title_display => invisible` (still present for screen readers on the form
  path); on display it simply replaces `$variables['label']`.
