<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better None Widget Option (betternone) — agent index

Improves the default **"- None -"** empty option that Drupal's options/select field
widgets show for optional, single-value fields. Per widget (in *Manage form display*)
an editor can **move** the empty option to first/last, **remove** it, or **rename** it
to a custom label. Pure form-display enhancement — no routes, permissions, services,
entities or config objects of its own. Core requirement `^8.7.7 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 8.x-1.x. No dependencies beyond core.

- **The three hooks, the alterer, every setting, how to configure it** →
  [config/widget-settings.md](config/widget-settings.md)

## What it actually is (from source)

- Three hooks in `betternone.module`, all gated on `$widget instanceof OptionsWidgetBase`:
  - `hook_options_list_alter()` → `BetterNoneAlterer::alter()` rewrites the `$options` array.
  - `hook_field_widget_third_party_settings_form()` → `BetterNoneAlterer::settingsForm()`
    adds a *Better None Option* fieldset (Position select + Label override textfield) to
    the widget's third-party settings on *Manage form display*.
  - `hook_field_widget_settings_summary_alter()` → `BetterNoneAlterer::alterSummary()`
    appends the chosen position/label to the widget's settings summary line.
- One class: `Drupal\betternone\BetterNoneAlterer` (`src/BetterNoneAlterer.php`).
  Built via `fromFieldDefinitionAndWidget()`, which reads the widget's third-party
  settings under provider **`betternone`** (keys `position`, `label`).
- Settings persist as **third-party settings on the entity form display config entity**
  (`core.entity_form_display.*`), under the `betternone` provider — the module ships no
  config of its own. No permissions, no Drush, no services, no plugins, no `.install`.

## Positions (`BetterNoneAlterer` constants)

`POSITION_FIRST` (`first`), `POSITION_LAST` (`last`), `POSITION_REMOVE` (`remove`).
Default when unset: `remove` for multi-value or required fields, otherwise `first`
(so optional single-value fields keep a leading empty option).
