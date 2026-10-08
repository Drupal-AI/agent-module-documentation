<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How REST Views works

Core Views REST Export runs fields through the Render API, flattening values into strings.
REST Views bypasses that with a handler + wrapper objects + normalizers.

## 1. The `field_export` Views handler

`rest_views_views_data_alter()` iterates all Views data and, for every handler whose
`field.id === 'field'`, clones it into a new `<field>_export` entry with
`field.id = 'field_export'` and the title suffix "(serializable)"; argument/filter/sort are
removed (only the field handler is duplicated). The class `EntityFieldExport` extends core
`EntityField` and overrides `renderItems()` to:

- render only the sub-items that are render arrays,
- keep multi-value output as an array (`$this->multiple`), single as the sole value,
- wrap the result in `SerializedData::create($data)`.

`render_item()` returns `$rendered['#data']` directly when an element is `#type => 'data'`.

## 2. Wrapper objects

- `SerializedData` — holds arbitrary data, `jsonSerialize()` returns it verbatim.
- `RenderableData` — holds a render array to be rendered during normalization.

Both implement `MarkupInterface` (with `__toString() === '[...]'`), so the Render API passes
them through instead of casting to string.

## 3. Normalizers (tagged services)

| Service | Class | Role |
|---|---|---|
| `serializer.normalizer.serialized` | `DataNormalizer` | Unwraps a `SerializedData` back into its raw data during serialization. |
| `serializer.normalizer.render` | `RenderNormalizer` | Renders a `RenderableData` render array (injects `@renderer`). |

So at serialization the serializer encounters the wrapper and emits real JSON (array, object,
bool, number) instead of the placeholder string. The export **field formatters**
(`boolean_export`, `number_export`, `entity_reference_export`, …) produce `#type => 'data'`
elements carrying `SerializedData`, which is why they only work with the `field_export` handler.

No caching, config, or services beyond the two normalizers and the wrappers; there are no
plugin *types* — the module provides plugin instances (one Views field plugin and several field
formatters).
