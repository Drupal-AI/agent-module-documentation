<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URL-friendly Options — agent index

Enforces that option-list field **keys** are URL-friendly (alphanumeric + hyphens only), so they
work as clean URL segments / Views contextual-filter arguments. No admin page (`configure: null`),
no config, no permissions, no Drush, no plugins. It only alters the field settings form and adds a
status-report check.

- **What it enforces, the regex, and the machine-name hyphen override** →
  [configure/enforcement.md](configure/enforcement.md)
- **Exempt a field from validation: `hook_url_friendly_options_bypass_field_validation()`** →
  [hooks/bypass.md](hooks/bypass.md)

Key facts:
- Validation lives in `url_friendly_options_form_field_config_edit_form_alter()` +
  `url_friendly_options_validate()`; the pattern is `^[a-zA-Z0-9-]*[a-zA-Z0-9]+$`.
- `hook_requirements()` (runtime) flags existing `list_string` field storages with non-compliant
  keys on the status report.
- It never rewrites existing values — it blocks saving new/edited non-compliant keys.
- Depends on core `options`.
