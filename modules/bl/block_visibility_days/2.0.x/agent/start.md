<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Visibility Days (block_visibility_days) — agent index

A single core **Condition plugin** that adds a **day-of-week** visibility rule to blocks. A block
with the condition set renders only on the checked weekdays. No dependencies, no permissions, no
config page, no services, no routes, no submodules. Core requirement `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 2.0.0.

- **The condition plugin — form, config keys, evaluate logic, how to use it** →
  [plugins/condition.md](plugins/condition.md)

## What it actually is

- One plugin: `BlockVisibilityDays` (id **`block_visibility_days`**, label *"Days Visibility"*) in
  `src/Plugin/Condition/BlockVisibilityDays.php`, extending core `ConditionPluginBase`.
- Because it is a Condition plugin, it appears automatically on every block's **Configure >
  Visibility** settings (Structure > Block layout), like core's own Pages/Roles/Content-type
  conditions. No configuration form of its own.
- Ships one JS behavior (`js/block_visibility_days.js`, library `block_visibility_days/block_visibility_days`,
  deps `core/jquery` + `core/drupal`) that renders the vertical-tab **summary** of checked days on
  the block form. Purely cosmetic.

## Mechanism (from source)

- `buildConfigurationForm()` adds a `days_visibility` fieldset with a `days` **checkboxes** element,
  options `Sun..Sat` → `Sunday..Saturday`, and attaches the summary library.
- `evaluate()` reads `$this->configuration['days_visibility']`, `array_filter()`s the checked days;
  if **none** are checked it returns **TRUE** (always show). Otherwise it compares core PHP
  `date('D')` (three-letter current day) against the checked keys via `in_array()` and returns
  TRUE/FALSE.
- `defaultConfiguration()` = `['days_visibility' => ['days' => '']]`. `submitConfigurationForm()`
  stores the submitted `days_visibility` values. `summary()` is empty (no server-side summary text).

## Scope / caveats

- **Day-of-week only.** There is no date-range, start/end date, or calendar feature in the 2.0.0
  source — older project text mentioning dates does not match the code.
- Uses the server's local timezone via `date('D')`; no per-user/site timezone handling.
- Controls block **display** only — it is a presentation condition, not an access-control mechanism.
  Hiding a block does not protect its underlying data.
- No `*.permissions.yml`, no `config/schema/*`, no `config/install/*`, no `*.install`, no
  `*.module`, no `*.services.yml`, no routing — just the plugin, the JS, and the info/libraries yml.
