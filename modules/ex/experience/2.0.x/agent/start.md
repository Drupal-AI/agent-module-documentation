<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Experience (experience) — agent index

Field API module defining an `experience` field type: a work-experience duration entered as years + months and stored as a single unsigned integer number of months (`year * 12 + month`; `Fresher` = 0). Ships a widget, two formatters and a Views numeric filter. No routes, permissions, services, entities or settings page.

- **Version:** 2.0.x (2.0.2, stable) · **Package:** Field types · **License:** GPL-2.0-or-later
- **Core:** `^8 || ^9 || ^10 || ^11` · **Requires:** core `field` (Views needed only for the filter)
- **Config:** none of its own; per-field settings + display config only. One config-schema file for the Views filter.

## What it provides

- **Field type** `experience` — `src/Plugin/Field/FieldType/ExperienceItem.php`; list class `ExperienceFieldItemList`. Storage: one `int` column `value` (unsigned, nullable) = total months. See [fields/field-type.md](fields/field-type.md).
- **Widget** `experience_default` — `ExperienceDefaultWidget`; year + month selects; year range, "Fresher" option and label position are field settings. See [fields/field-type.md](fields/field-type.md).
- **Formatters** `experience_default` (`ExperienceDefaultFormatter`, "X Year(s) Y Month(s)") and `experience_month` (`ExperienceMonthFormatter`, "N Month(s)"). See [fields/formatters.md](fields/formatters.md).
- **Views** `experience_field_views_data()` (`experience.views.inc`) maps the field's `_value` column to the `ExperienceFilter` numeric filter (`@ViewsFilter("experience")`). See [views/filter.md](views/filter.md).
- **Library** `experience/drupal.experience` (`experience.js`) — hides the month select when "Fresher" is selected. Stylesheet `experience.css` attached via `.info.yml`.
- **Help** `hook_help()` for `help.page.experience` in `experience.module`.
