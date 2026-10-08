<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Contextual Filter Validator: Number Range (contextual_filter_range_validator) — agent index

A single **Views argument-validator plugin** (`id = "range"`) that makes a View contextual filter accept
only numeric arguments within a configured inclusive min/max range. No routes, no permissions, no services,
no module config. Version **2.0.2**. Core `^9.5 || ^10 || ^11`.

- **Dependencies:** core `views` only (`contextual_filter_range_validator.info.yml`).
- **Plugin provided:** `Drupal\contextual_filter_range_validator\Plugin\views\argument_validator\RangeArgumentValidator`
  (`@ViewsArgumentValidator(id = "range", title = "Range")`), extending core `ArgumentValidatorPluginBase`.
- **Hooks:** `contextual_filter_range_validator_help()` (help.page text only) in the `.module`.
- **Config:** none of its own — the min/max options are stored inside the View's contextual-filter config.
- Validation constrains input format, **not access** (not an access-control mechanism).

## Solution docs
- [Range argument validator plugin](plugins/range.md) — options form, validation logic, how to configure and operate.
