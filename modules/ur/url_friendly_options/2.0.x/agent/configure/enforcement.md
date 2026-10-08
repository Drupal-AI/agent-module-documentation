<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What URL-friendly Options enforces

The module has **no settings** — enabling it *is* the configuration. It changes two things and
adds one status check.

## 1. Form validation on the allowed-values table

`url_friendly_options_form_field_config_edit_form_alter()` targets `field_config_edit_form` and,
when the field storage subform exposes an `allowed_values` table (i.e. an options list field —
`list_string`, `list_integer`, `list_float`), adds `url_friendly_options_validate` to that
element's `#element_validate`.

On validation it reads
`field_storage.subform.settings.allowed_values` and checks every **key** against:

```
/^[a-zA-Z0-9-]*[a-zA-Z0-9]+$/
```

i.e. only letters, digits and hyphens, and it must end in a letter or digit (a bare `-` or empty
key fails). Any failing keys produce a form error:
*"The following keys are not URL-friendly: … Make sure you use only alpha-numeric characters and
hyphens."* — so the field cannot be saved until fixed.

Helper: `_url_friendly_options_check_allowed_values(array $allowed_values): array` returns the list
of non-compliant keys (reused by the requirements check below).

## 2. Machine-name element override (hyphens, not underscores)

For each row in the allowed-values table it overrides the `key` machine-name element so the
auto-suggested key uses hyphens:

```php
$el['#machine_name']['replace_pattern'] = '[^a-z0-9\-]+';
$el['#machine_name']['replace'] = '-';
```

So typing a label like "Breaking News" suggests the key `breaking-news` instead of
`breaking_news`.

## 3. Status-report requirement — `hook_requirements()`

`url_friendly_options_requirements('runtime')` (in `.install`) iterates all
`FieldStorageConfig` of type `list_string`, and for each non-exempt field checks its
`allowed_values` keys with the same helper. If any are non-compliant it adds a
`REQUIREMENT_ERROR` to the status report listing the offending `entity_type.field_name`; otherwise
a `REQUIREMENT_OK` "All option list keys are URL-friendly."

## Important behaviour

- It does **not** rewrite existing values. Fields saved before the module was enabled keep their
  keys; you just cannot add/edit values until existing keys comply (the form won't validate).
- Validation applies at field-config edit time; the requirements check runs on the status report
  (`/admin/reports/status`) and covers `list_string` storages.
- To exempt a specific field, implement
  [`hook_url_friendly_options_bypass_field_validation()`](../hooks/bypass.md).
