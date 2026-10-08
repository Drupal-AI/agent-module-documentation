<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Localization quick links speeds up interface/config translation with an on-page widget from the toolbar.

---

The module records the interface strings encountered while rendering a page (via a `string_translator` service) and exposes an on-page widget that links each string to its translation form, so translators can jump straight to the relevant `admin/config/regional/translate` entry. A settings form (`administer languages`) controls behaviour and a toggle route (`use localization quick links ui` permission) turns the widget on/off. It streamlines translation workflow without changing stored strings itself.

---

- Translate the Drupal interface directly from the page.
- Jump from an on-page string to its translation form.
- Surface a translation widget from the toolbar.
- Record interface strings used on the current page.
- Toggle the on-page widget per user.
- Speed up locale/config translation workflows.
- Gate widget use behind a dedicated permission.
- Gate settings behind `administer languages`.
- Help translators find untranslated strings quickly.
- Reduce hunting through the translate UI.
- Support interface and configuration translation.
- Integrate with core Locale and Toolbar.
- Provide a settings form for behaviour.
- Support Drupal 8.8, 9, and 10.
- Improve multilingual editorial productivity.
- Link strings to their `translate` admin entries.
