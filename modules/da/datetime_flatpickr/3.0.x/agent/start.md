<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime Flatpickr — agent index

Field widgets (and a form element) that render core Date/time and Date-range fields with the
[flatpickr](https://flatpickr.js.org/) JS picker. Configured per widget on *Manage form display*; no
global config page (`configure` null), no permissions, no Drush. Depends on core `datetime`. Provides a
config schema for widget settings. Two optional submodules extend it to BEF and Webform.

- **The three widgets, every settings key, where settings live, CDN vs self-hosted library, locale** →
  [configure/widget.md](configure/widget.md)
- **The `datetime_flatpickr` render/form element, `drupalSettings`, and value handling for custom code** →
  [api/element.md](api/element.md)

Submodules (own docs):
- `datetime_flatpickr_bef` → [../../modules/datetime_flatpickr_bef/3.0.x/agent/start.md](../../modules/datetime_flatpickr_bef/3.0.x/agent/start.md)
- `datetime_flatpickr_webform` → [../../modules/datetime_flatpickr_webform/3.0.x/agent/start.md](../../modules/datetime_flatpickr_webform/3.0.x/agent/start.md)

Key facts:
- Widgets: `datetime_flatpickr` (field type `datetime`), `datetime_range_flatpickr` &
  `datetime_range_separate_inputs_flatpickr` (field type `daterange`).
- Settings stored in `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.settings` (schema `datetime_flatpickr_config`).
- Library `datetime_flatpickr/flatpickr` loads flatpickr 4.6.11 from CDN by default; a local
  `libraries/flatpickr` copy overrides it via `hook_library_info_alter`.
