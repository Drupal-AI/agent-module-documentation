# Bynder Select2 — agent index

UI helper for [Bynder](../../../../4.4.x/agent/start.md): a Select2-backed form element and field widget used
by the Bynder upload widget for tag/metaproperty multi-selects. Depends only on `bynder`. No config, no
permissions, no schema. Requires the Select2 library at `/libraries/select2/`.

- **The form element, the field widget, drupalSettings, and remote-data option** →
  [plugins/select2.md](plugins/select2.md)

Key facts:
- Form element `bynder_select2_simple_element` (`src/Element/BynderSelect2SimpleElement.php`, extends core
  `Select`).
- Field widget `bynder_select2_simple_widget` (`src/Plugin/Field/FieldWidget/`, extends
  `OptionsSelectWidget`; field types `list_string`, `list_integer`; `multiple_values = TRUE`).
- Library `bynder_select2/bynder_select2.widget` → `js/bynder_select2.js` (+ Select2 from
  `/libraries/select2/dist/`).
- Per-instance settings in `drupalSettings.bynder_select2[<class>]`: `selector`, `placeholder_text`,
  `multiple`, optional `loadRemoteData.url`.
