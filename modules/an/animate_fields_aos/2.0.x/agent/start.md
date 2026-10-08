<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animate Fields AOS (animate_fields_aos) — agent index

Adds scroll-triggered animations to **field output** using the **AOS (Animate On Scroll)** JS library.
Works by extending each field formatter's third-party settings — no code, no dedicated config page,
no config entity. Version **2.0.0**. Core `^9 || ^10 || ^11`. Package `Other`. No module dependencies.

## What it provides
- **Hook `animate_fields_aos_field_formatter_third_party_settings_form()`** — adds an "AOS Animations"
  details element to every field formatter settings form (Manage Display → gear icon).
- **Hook `animate_fields_aos_preprocess_field()`** — emits `data-aos-*` attributes on the field wrapper
  and attaches the `animate_fields_aos/animate_fields_aos` library.
- **Hook `animate_fields_aos_help()`** — renders README.md on the module help page.
- **Service `animate_fields_aos.attributes_manager`** (`Drupal\animate_fields_aos\AttributesManager`,
  a `DefaultPluginManager` using `YamlDiscovery` on `*.options.yml`) — builds the animation / anchor /
  easing option lists.
- **Permission** `edit animate fields formatter settings` — gates the formatter settings form.
- **Config schema** `field.formatter.third_party.animate_fields_aos` — 8 keys stored per formatter.
- **Library** `animate_fields_aos` — external AOS 3.0.0-beta.6 CSS/JS from cdnjs + `js/script.js`
  (`AOS.init()`), depends on `core/jquery`, `core/drupal`.
- **No routing, no forms, no drush, no entities, no plugin types for third parties.**

## Solution docs
- [Formatter third-party settings & rendering](fields/formatter-settings.md) — the form, the eight
  settings, schema, permission, and how attributes reach markup.
- [AttributesManager service & options.yml](api/attributes-manager.md) — the option-list service and
  how to extend the available animations.
