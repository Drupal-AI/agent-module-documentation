<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fences_presets — agent start

Submodule of **fences** (project: `fences`). Adds a `fences_preset` **config entity** that
bundles the eight Fences wrapper settings (field/label/items-wrapper/item tags + classes)
under a name, plus a **"Select Preset"** dropdown injected into each field's Fences
settings section. Picking a preset copies its tag values into the field's Fences controls via
JavaScript — the selector itself is **not saved**; you still save the field normally, so a
preset is a template, not a live binding.

Manage presets at **Configuration → User interface → Fences → Presets**
(route `entity.fences_preset.collection`), gated by permission `administer fences_preset`.
Ships four default presets: `default`, `inline`, `inline_label`, `none`. Preset config keys
(schema `fences_presets.fences_preset.*`): `field_tag`, `field_classes`,
`field_items_wrapper_tag`, `field_items_wrapper_classes`, `field_item_tag`,
`field_item_classes`, `label_tag`, `label_classes` (note: **no** `fences_` prefix, unlike the
per-field third-party settings). Requires `fences`.

- Manage/create/apply presets, the four defaults, config keys → [configure/presets.md](configure/presets.md)
- Parent module (per-field Fences settings & the tag registry) → [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)
