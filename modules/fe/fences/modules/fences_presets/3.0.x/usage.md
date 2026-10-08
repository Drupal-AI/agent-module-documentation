Fences Presets is a submodule of Fences that lets you define reusable, named bundles of Fences wrapper-tag settings (a "preset") and apply them to a field's Fences configuration in one click.

---

Part of the **fences** project, this submodule adds a `fences_preset` config entity that stores the same eight values a per-field Fences configuration uses (field/label/items-wrapper/item tags and their classes) under a friendly name. Presets are managed at **Configuration → User interface → Fences → Presets** (route `entity.fences_preset.collection`), where you can add, edit, duplicate, and delete them; the `administer fences_preset` permission gates that UI. It ships four default presets — **Default** (core-like `div`s), **Inline** (field as `span`, everything else `none`), **Inline Label** (label and item as `span`), and **None** (all tags `none`, markup stripped). On any field's Manage-display Fences section, the submodule injects a **"Select Preset"** dropdown (via `hook_fences_field_formatter_third_party_settings_form_alter`) whose JavaScript copies the chosen preset's tag values into the field's Fences form controls. Crucially the selector itself is **not** saved — it only fills in the real Fences settings, which you then save normally, so a preset is a convenience template rather than a live link. Presets are plain config entities (schema `fences_presets.fences_preset.*`), so they export and deploy like any other config. It depends on `fences`.

---

- Define a reusable "Inline" markup bundle and apply it to many metadata fields.
- Apply the built-in **None** preset to strip all wrapper markup from a field.
- Use the **Inline Label** preset to put a label and value on the same line.
- Standardize field markup across a site by sharing a small set of presets.
- One-click apply a preset instead of setting eight tag values by hand.
- Duplicate an existing preset as a starting point for a variant.
- Create a "Card item" preset that sets item tags/classes for grid layouts.
- Export presets as config to reuse the same markup conventions across sites.
- Give editors/site builders a curated list of approved field-markup styles.
- Build a `<ul>`/`<li>` list preset for multi-value fields.
- Keep a heading-label preset (label as `h3`) for consistent field headings.
- Reset a field to core-like markup with the **Default** preset.
- Manage all field-markup conventions from one Presets admin screen.
- Speed up configuring many fields on a new content type.
- Restrict who can manage presets via the `administer fences_preset` permission.
- Prototype markup quickly by switching presets while configuring a field.
- Provide a `<section>`-based semantic preset for landmark regions.
- Share a company style guide's field markup as named presets.
- Apply a compact "inline" style to author/date/tag metadata rows.
- Seed new environments with default presets on install.
