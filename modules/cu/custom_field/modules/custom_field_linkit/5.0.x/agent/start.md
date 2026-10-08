<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Field - Linkit integration — agent index

Adds Linkit widgets & formatters to the parent
[custom_field](../../../../5.0.x/agent/start.md) module. No configure route, no permissions, no
Drush, no new plugin types. Depends on `custom_field` + `linkit`.

Plugin ids it registers (used per column inside a `custom` field):
- `CustomFieldWidget` **`linkit`** → for a `link` column (autocomplete internal/external links)
- `CustomFieldWidget` **`linkit_url`** → for a `uri` column
- `CustomFieldFormatter` **`linkit`** / **`linkit_url`** → render the linked value via a Linkit profile

- **Assign the Linkit widget/formatter to a column, where it is stored, Linkit profile setting** →
  [configure/linkit-subfield.md](configure/linkit-subfield.md)

Key facts: subfield widget id lives in the entity **form** display at
`component.settings.fields.<column>.type`; subfield formatter id in the entity **view** display at
`component.settings.fields.<column>.format_type`. The Linkit profile is a per-subfield setting.
