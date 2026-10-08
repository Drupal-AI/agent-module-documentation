<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FZ152 — Contact — configuration

Form `Fz152ContactSettings` at `/admin/config/system/fz152/contact` (route `fz152.contact`,
permission `administer fz152`). It enumerates every `contact_message` bundle (from
`entity_type.bundle.info`) and renders three fields per bundle:

- `contact_<bundle>_enable` (checkbox) → stored as `enabled`.
- `contact_<bundle>_weight` (number) → stored as `weight`.
- `contact_<bundle>_checkbox_title` (number) → stored as `checkbox_title` (which of the parent's
  `checkbox_title_N` labels to use).

Each bundle persists to its own config object **`fz152_contact.settings.<bundle>`** (schema
`fz152_contact.settings.*`), always saved with `langcode: ru` so config_translation works.

`Fz152ContactService::getForms()` (service `fz152_contact.service`) reads those objects and, for each
`enabled` bundle, returns:
```
['form_id' => 'contact_message_<bundle>_form', 'weight' => …, 'checkbox_title' => …]
```
The **parent** module (`fz152.module` and `fz152_consent.module`) calls this service, merges the
result into its form-match patterns, and performs the checkbox injection / consent logging. This
submodule itself only stores settings and exposes the form list — it has no `hook_form_alter`.
