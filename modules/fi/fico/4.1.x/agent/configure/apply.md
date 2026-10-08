<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Applying a condition to a field

fico has **no admin settings page**. You attach conditions per field on a view display.

## Regular formatter fields

1. Go to the entity's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. Click the gear (settings) for a field to open its formatter settings.
3. Expand the **Conditions** details section (added by
   `hook_field_formatter_third_party_settings_form()`, weight 100).
4. Pick a **Condition** from the select; its own settings form appears via AJAX.
5. Fill the condition settings and *Update*, then *Save*.

Only conditions whose declared `types` include the field's field type (or `all`) are offered
(`fico_field_options()`).

## Display Suite (DS) fields

When a display uses a DS layout, `fico_form_entity_view_display_edit_form_alter()` adds the same
**Conditions** section to each DS field's settings row, so DS-managed fields (`dsFields = TRUE`
conditions) can be hidden the same way.

## Where the configuration lives

The selected condition and its settings are saved as the field component's third-party settings:

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>.yml
content:
  field_example:
    third_party_settings:
      fico:
        fico:
          condition: hide_if_empty
          settings:
            target_field: field_other
```

(For DS fields the same `fico.condition` / `fico.settings` keys live in the DS field
configuration.) At render time `fico_entity_view_alter()` loads the plugin and calls `access()`,
which sets `$build[$field]['#access'] = FALSE` when the condition matches — this hides the field
from output only; it does not restrict data access or entity access.
