<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A code-only example submodule that shows, via hook implementations, how to add custom icons and pictograms to the DSFR for Drupal picker.

---

`dsfr4drupal_picker_examples` is a demonstration submodule of DSFR for Drupal - Picker. It ships one hook class (`Dsfr4drupalPickerExamplesHooks`) that exercises every extension point the picker exposes: it declares a new `custom` icon group and a new `custom` pictogram group through the provider hooks (`hook_dsfr4drupal_picker_icons`, `hook_dsfr4drupal_picker_pictograms`), removes the built-in `buildings` group through the matching alter hooks, appends a `css/icons.custom.css` stylesheet to the parent module's `dsfr.icons` library via `hook_library_info_alter`, and maps its custom pictogram identifier to an SVG under `core/misc/logo/` via `hook_dsfr4drupal_picker_pictogram_path_alter`. It installs no fields, entities, configuration or demo content — enable it only to study or copy the pattern.

---

- Learn how to register a custom icon group in the DSFR picker without patching the base module.
- Learn how to register a custom pictogram group in the DSFR picker from code.
- See how to remove an unwanted built-in icon group (here, `buildings`) with `hook_dsfr4drupal_picker_icons_alter`.
- See how to remove an unwanted built-in pictogram group with `hook_dsfr4drupal_picker_pictograms_alter`.
- Copy the pattern for resolving a custom pictogram machine name to a real SVG file path.
- Add project-specific glyphs (e.g. `example-icon-thumbsup`, `example-icon-thumbsdown`) that render through CSS `::before` content.
- Understand how to attach an extra stylesheet to the picker's `dsfr.icons` library via `hook_library_info_alter`.
- Use as a scaffold for a company icon set that lives alongside the official DSFR icons.
- Use as a scaffold for a bespoke pictogram set backed by files instead of media.
- Reference the modern `#[Hook]` attribute style plus the `#[LegacyHook]` shims in the `.module` file.
- Reference the autowired hook-class `services.yml` wiring pattern for hook classes.
- Confirm that new groups appear in the icon/pictogram picker dialogs and CKEditor buttons after enabling.
- Verify custom icon sizing helpers (`fr-icon--lg/sm/xs`) work against your own glyphs.
- Test that removing a group hides it everywhere the picker is used.
- Prototype changes to the icon/pictogram catalogue before writing your own submodule.
- Teach new developers the picker's hook API in one small, self-contained module.
- Validate that your custom pictogram path resolves correctly in rendered output.
- Serve as a template you copy into a custom module and then disable the example.
