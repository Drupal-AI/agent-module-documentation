<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Core Condition plugin: `eca_condition`

`src/Plugin/Condition/ECACondition.php` — class `ECACondition extends ConditionPluginBase`.

```php
@Condition(
  id = "eca_condition",
  label = @Translation("ECA Condition")
)
```

This is a **standard Drupal Condition plugin**, so it appears wherever core exposes conditions
(e.g. block visibility on *Structure → Block layout → Configure block → Conditions*). Its verdict is
not computed here — it is delegated to an ECA model. See
[../api/eca-integration.md](../api/eca-integration.md) for the ECA half.

## Install & enable

```bash
composer require drupal/eca_condition
drush en eca_condition -y
```

Requires the **ECA** module (`eca:eca ^2`); enabling pulls it in. No sub-modules, no permissions,
no config form of its own.

## Configuration (`buildConfigurationForm`)

One field plus core's condition scaffolding:

| Config key | Form element | Meaning |
|---|---|---|
| `eca_conditions` (const `CONDITIONS`) | textarea, `#required = FALSE` | One **condition ID per line** ("List of ECA condition event"). Each ID is matched by an ECA model. |

`defaultConfiguration()` sets `eca_conditions => ''`. The core **`negate`** checkbox is present but
`$form['negate']['#access'] = FALSE` hides it, so negation is not offered. `submitConfigurationForm()`
stores the textarea value; `summary()` returns the plugin label.

## Evaluation (`evaluate()`)

1. Read `eca_conditions`. If `trim()` is empty (`mb_strlen == 0`) → return **FALSE**.
2. Split on newlines: `preg_split("/\r?\n/", $conditions)`.
3. For each non-empty line, call `_eca_condition_hook_handler()->condition($condition)` (the
   `.module` helper resolving service `eca_condition.hook_handler`).
4. If **any** line returns falsy → return **FALSE** (short-circuits).
5. All lines truthy → return **TRUE**.

So a plugin instance is an **AND** over its listed condition IDs; each ID's TRUE/FALSE is produced by
an ECA model that reacts to the `eca_condition:condition_event` event and sets the result with the
`eca_condition_result` action. An ID with no matching model (no result set) resolves FALSE
(`ConditionEvent::$result` defaults to `FALSE`).

## Practical setup

1. Place the "ECA Condition" condition on a block (or any condition consumer) and enter one or more
   condition IDs, one per line.
2. Build an ECA model: react to event **"ECA Condition"** (`eca_condition:condition_event`), branch
   on the `[condition_id]` token, compute your logic, then run action **"ECA Condition: set result"**
   with value True/False.
3. The block shows only when every listed ID's model set the result TRUE.
