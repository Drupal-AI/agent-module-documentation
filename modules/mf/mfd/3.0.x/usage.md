<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets editors fill in multiple languages' translatable fields on a single node form instead of one translation at a time.

---

The module supplies a `multilingual_form_display` field type/widget/formatter (`src/Plugin/Field/...`) that, when added to a translatable bundle, exposes the other languages' translatable field inputs on the node form. `hook_form_node_form_alter()` (`mfd.module`) attaches a submit handler `mfd_form_submit` (only for users with the **`edit multilingual form`** permission), which after the entity saves iterates every non-current language, collects `<field>_<langcode>` values from the submitted form, and writes them into each existing translation (`$translation->set(...); $translation->save()`). Extensive validation guards keep the setup coherent: you cannot mark an mfd field translatable (`language_content_settings_form` validate), cannot add an mfd field to a non-translatable bundle (`field_ui_field_storage_add_form` validate), and cannot disable translation on a bundle that has an mfd field (`node_type_edit_form` validate). Permissions: `edit multilingual form` and `show multilingual translate table`. Requires `content_translation`, `language`, `locale`; also pulls the `tribus-studio/versioncontrol` composer library (used only to set a status message). No routes/services of its own.

---

- Edit English and other languages' fields together on one node form.
- Speed up translation of content with many translatable fields.
- Avoid switching between per-language translation edit pages.
- Add a Multilanguage Form Display field to a translatable content type.
- Restrict inline multilingual editing to users with `edit multilingual form`.
- Optionally show a translation table on node view (`show multilingual translate table`).
- Save all language translations in a single submit.
- Prevent adding the mfd field to a non-translatable bundle (guarded by validation).
- Prevent disabling translation while an mfd field is present.
- Prevent marking the mfd field itself translatable.
- Keep translations in sync without a separate translation workflow.
- Support Drupal 9.4+ and 10 with core content translation.
- Reduce editor errors from context-switching between languages.
- Work with any translatable field type on the bundle.
- Streamline multilingual data entry for editors managing several languages.
- Set a 'Translation saved' status message after submit.
