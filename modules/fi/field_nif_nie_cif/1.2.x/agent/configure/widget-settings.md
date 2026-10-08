<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — widget settings

No admin config page (`configure: null`, no permissions). Configuration is per field, via the
**form display** widget settings for the `nif_nie_cif_default` widget (Manage form display →
gear icon on the NIF NIE CIF field). Settings are stored in the entity form display config
(`entity_form_display.*`) under the field's `settings`.

## Settings (schema `field.widget.settings.nif_nie_cif_default`)

- `allowed_types` — sequence of strings; which identification types editors may enter. Canonical
  order/values: `NIF`, `NIE`, `CIF`. **At least one required** (validated; empty selection errors
  with "Select at least one identification type."). Default: all three.
- `auto_detect` — boolean. `FALSE` (default) shows a **type select** plus number field. `TRUE`
  shows a **single smart input** (type is hidden and inferred from the number); the select is
  removed.

Widget `defaultSettings()`: `allowed_types = ['NIF','NIE','CIF']`, `auto_detect = FALSE`.

## Behavior notes

- Invalid/empty legacy `allowed_types` falls back to all supported types.
- With `auto_detect` on, an entered number is normalized and identified; if it validates but its
  detected type is not in `allowed_types`, it is rejected ("@type identification numbers are not
  allowed in this field.").
- With manual mode, if a stored value's type is no longer allowed, the select does not preselect it —
  the editor must choose an allowed type and enter a valid matching number before saving.
- Widget `settingsSummary()` reports the allowed types and whether the type is detected or selected.

## Setting it in exported config (example)

```yaml
# entity_form_display.*.yml → content.<field_name>.settings
settings:
  allowed_types:
    - NIF
    - NIE
  auto_detect: true
```

The Webform element (`nif_nie_cif`, submodule) has **no** allowed-types/auto-detect settings — it
always auto-detects and accepts any valid NIF/NIE/CIF.
