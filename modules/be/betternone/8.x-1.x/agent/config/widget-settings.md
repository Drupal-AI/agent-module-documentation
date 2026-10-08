<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better None — widget third-party settings

Everything betternone does is a per-widget setting on an entity **form display**.
Nothing is a site-wide config object; there is no settings route and no admin page.

## Enable

`drush en betternone -y` (or *Extend*). No dependencies beyond Drupal core
`^8.7.7 || ^9 || ^10 || ^11`. Nothing else installs — no config, no schema, no menu links.

## Configure (per widget)

1. Go to **Manage form display** for the entity/bundle
   (e.g. `/admin/structure/types/manage/<bundle>/form-display`).
2. For a field whose widget extends core's `OptionsWidgetBase` (Select list, Check
   boxes/radios, Select (or other) for entity-reference/list/boolean fields), open the
   widget's gear/settings.
3. A **"Better None Option"** fieldset appears (added by
   `betternone_field_widget_third_party_settings_form()` →
   `BetterNoneAlterer::settingsForm()`):
   - **Position** — select of `First` / `Last` / `Remove`.
   - **Label override** — textfield; leave empty to keep the field's default empty label.
4. Save. The values are written into the form display's third-party settings under the
   `betternone` provider (keys `position`, `label`). The widget summary line then shows
   e.g. *"None-option position: First / None-option label: Choose…"* via
   `alterSummary()`.

Widgets that do **not** extend `OptionsWidgetBase` get an empty settings form and are
untouched (the hooks early-return `[]`).

## How the option list is altered

`betternone_options_list_alter()` fires on every options list build. It resolves the
widget (from `$context['widget']`, falling back to a `debug_backtrace()` lookup — a
documented "dirty hack" the author flags with a `@todo` pending core issue #3134618),
and only proceeds for `OptionsWidgetBase`. Then `BetterNoneAlterer::alter(&$options)`:

- Picks the label: the **Label override** if set, else the existing `''` / `'_none'`
  option text, else the translated **`- None -`** default.
- `unset()`s the existing `''` and `'_none'` keys.
- Re-inserts under key **`_none`**:
  - `POSITION_FIRST` → prepended (`['_none' => $label] + $options`).
  - `POSITION_LAST` → appended.
  - `POSITION_REMOVE` → not re-inserted (no empty option at all).

## Default behavior (`fromFieldDefinitionAndWidget()`)

When a widget has no saved betternone settings, the default position is computed:
`remove` if the field storage `isMultiple()` **or** the field `isRequired()`, otherwise
`first`. So an optional single-value select keeps a leading empty option; a required or
multi-value one drops it. A saved third-party `position`/`label` always overrides this.

## Surface summary

- Config: third-party settings on `core.entity_form_display.*`, provider `betternone`
  (`position`, `label`). No config objects, no `config/schema` shipped.
- No routes, permissions, services, plugins, Drush commands, `.install`, or libraries.
- Class: `Drupal\betternone\BetterNoneAlterer` — constants `POSITION_FIRST` (`first`),
  `POSITION_LAST` (`last`), `POSITION_REMOVE` (`remove`).
