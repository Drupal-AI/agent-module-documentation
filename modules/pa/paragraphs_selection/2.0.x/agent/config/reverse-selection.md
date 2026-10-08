<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring reverse selection

## Turning it on for a paragraph field

There is no module settings page. You enable the model per field:

1. On an `entity_reference_revisions` field that targets `paragraph` entities, open the field's
   **Reference** settings (Manage fields → the paragraph field → field settings).
2. Set **Reference type / handler** to **Paragraphs Selection** (plugin id `paragraph_reverse`).
3. The handler shows the same drag-drop bundle list as core Paragraphs: tick **Enabled** for each
   paragraph type this field should offer and set its **weight**. The parent handler's allow/exclude
   behaviour is available as `negate` (exclude the ticked types instead of allowing them).
4. Save. There is no per-widget or per-page config — placement is a field-level decision.

Requires the same privilege as any field configuration (e.g. *administer <entity type> fields*);
the module adds no permissions of its own.

## Where the configuration actually lives

Editing happens in the field UI, but the field does **not** store the result. On save,
`paragraphs_selection_field_config_presave()`:

- writes a third-party setting **on each paragraphs_type bundle** —
  `third_party_settings.paragraphs_selection.fields: [{id: <field-config-id>, weight: <n>}]` — one
  entry per field that offers the bundle;
- removes `target_bundles` and `target_bundles_drag_drop` from the field's `handler_settings`;
- keeps only `handler_settings.self_field_id: <field-config-id>` on the field.

So the exported field config for a `paragraph_reverse` field is minimal; the real placement data is
distributed across the `paragraphs.paragraphs_type.*` config entities. Config schema for both lives
in `config/schema/paragraps_selection.schema.yml`. At add-widget time
`ReverseParagraphSelection::getSortedAllowedTypes()` rebuilds the allowed list from those bundle
settings, weight-sorted — the field-side list is not consulted.

Implication for config management: to add a paragraph type to a field, you can edit the type's
bundle config directly (or re-save the field through the UI); the placement travels with the bundle
in config exports.

### `negate`

When the handler's exclude behaviour is chosen, `negate` is stored as `1` and
`paragraphs_selection_field_config_presave()` inverts each bundle's `enabled` flag — the ticked
types become the ones **excluded**, everything else is allowed. `ReverseParagraphSelection::buildConfigurationForm()`
also uses `negate` to compute the default checkbox state when re-opening the form.

## Paragraphs Sets support (submodule)

Enable `paragraphs_selection_paragraphs_sets_support` when you also use `paragraphs_sets` (it also
pulls in `paragraphs_sets_alter`). It adds an **"Availability"** YAML textarea to each Paragraphs Set
form. Enter which fields the set is available on, for example:

```yaml
fields:
  - name: node.page.elements
    weight: 10
```

`name` is the field config id (`<entity_type>.<bundle>.<field_name>`); `weight` orders the set in
the widget. This is stored as the set's `paragraphs_selection.selection` third-party setting. An
event subscriber on `ParagraphsSetsAlterEvents::USE_PARAGRAPHS_SET` then makes the set usable on a
`paragraph_reverse` field only if `selection.fields` lists that field id (and applies the weight);
a set with no matching entry is hidden on that field. The submodule ships no config schema for this
`selection` setting.
