<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enhances Webform `date` elements with the accessible Duet Date Picker via a simple per-element checkbox.

---

The module registers a `use_duet` element property (default off) on Webform elements and adds a *Use Duet datepicker* checkbox to the configuration form of `date` elements (`hook_webform_element_configuration_form_alter`). When enabled for an element, a theme suggestion (`input__date_duet`) and template are used and the Duet library is attached in preprocess, replacing the browser-native date input with the Duet Date Picker web component. The `use_duet` property is also registered as translatable.

Setup: install with Webform, edit a Webform `date` element, tick *Use Duet datepicker*, and save. No settings form, permissions or routes are added; it operates purely through Webform's element property/alter hooks and a template.

---
- Turn a Webform date field into a Duet date picker.
- Enable the accessible Duet picker per element with a checkbox.
- Keep native date inputs on elements where the option is off.
- Provide a consistent cross-browser date UI in webforms.
- Improve keyboard/screen-reader accessibility of date entry.
- Attach the Duet library only when the element opts in.
- Use a dedicated `input__date_duet` template for styled rendering.
- Mark the use_duet property as translatable for multilingual forms.
- Add a modern date picker without custom JavaScript.
- Apply the picker to multiple date elements independently.
- Offer a touch-friendly date UI on mobile webforms.
- Standardise date entry across a multi-step webform.
- Leave existing date elements unchanged until opted in.
- Localise date-picker labels via the translatable property.
- Enhance a booking or event webform's date field.
- Style the Duet element via the dedicated template override.
