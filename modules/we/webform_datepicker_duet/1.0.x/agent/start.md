<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform datepicker Duet (webform_datepicker_duet) — agent index

**Per-element 'Use Duet datepicker' option for Webform date elements, swapping the native input for the Duet Date Picker component.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^9 || ^10 || ^11
- **Requires:** webform
- **Element property:** `use_duet` (default FALSE; registered translatable)
- **Hooks:** `hook_webform_element_default_properties_alter`, `hook_webform_element_translatable_properties_alter`, `hook_webform_element_configuration_form_alter` (adds checkbox on `date` elements), `hook_preprocess_input__date_duet`, `hook_theme_suggestions_alter` (`input__date_duet`)
- **Library:** `webform_datepicker_duet/duet` (attached when the element opts in)
- **No routes/permissions/config**

**Security:** no routes, permissions or endpoints; only augments Webform element rendering. No access implications.
