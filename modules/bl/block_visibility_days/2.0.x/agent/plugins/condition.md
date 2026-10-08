<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugin: `block_visibility_days`

Source: `src/Plugin/Condition/BlockVisibilityDays.php` — class `BlockVisibilityDays extends
ConditionPluginBase`. Annotation:

```
@Condition(
  id = "block_visibility_days",
  label = @Translation("Days Visibility"),
)
```

Being a core Condition plugin, Drupal's block system discovers it automatically. It surfaces on
**every block's Configure > Visibility** tab (Structure > Block layout, `/admin/structure/block`),
alongside core's Pages / Content types / Roles conditions. Nothing else is needed to expose it.

## Install / enable

`drush en block_visibility_days -y` (or Extend page). No dependencies, no config import, no
permissions to grant. It works immediately for anyone who can already administer blocks
(core permission `administer blocks`).

## Configuration model

Stored inside the block config entity's `visibility` under the plugin id, shaped as:

```
days_visibility:
  days:
    Sun: 0 | 'Sun'
    Mon: 0 | 'Mon'
    ... Sat
```

- Form: `buildConfigurationForm()` builds a `days_visibility` **fieldset** containing a `days`
  **checkboxes** element. `#options` = `Sun=>Sunday, Mon=>Monday, Tue=>Tuesday, Wed=>Wednesday,
  Thu=>Thursday, Fri=>Friday, Sat=>Saturday`. `#default_value` reads
  `$this->configuration['days_visibility']['days']`.
- `defaultConfiguration()` returns `['days_visibility' => ['days' => '']] + parent::defaultConfiguration()`
  (the parent adds the standard `negate` / context keys).
- `submitConfigurationForm()` writes `$form_state->getValues()['days_visibility']` back into
  `$this->configuration['days_visibility']`.
- **No config schema ships** (`config/schema/` absent). The keys therefore have no typed-data
  definition; they store as untyped mapping data under the block entity.

## Evaluate logic

`evaluate()`:
1. `$days = $this->configuration['days_visibility'];`
2. `$days_visibility = array_filter($days['days']);` — drops the unchecked (0/'') entries.
3. If `empty($days_visibility)` → return **TRUE** (no restriction: block always shown).
4. `$today = date('D');` — server-local three-letter day (e.g. `Mon`).
5. If `in_array($today, $days_visibility)` → **TRUE**, else **FALSE**.

`summary()` is defined but empty, so the block-listing/vertical-tab server summary shows nothing;
the checked-day summary you see on the form is produced client-side.

## The JS summary (cosmetic)

`js/block_visibility_days.js` (library `block_visibility_days/block_visibility_days`, deps
`core/jquery`, `core/drupal`) defines `Drupal.behaviors.blockVisibilityDaysSettings`. It calls
`drupalSetSummary` on `[data-drupal-selector="edit-visibility-block-visibility-days"]`, joining the
checked days' labels (or `"Not restricted"` when none) for the vertical-tab summary. No effect on
evaluation.

## Operating notes

- Leave all boxes unchecked to keep a block visible every day (step 3 short-circuits to TRUE).
- `negate` (inherited from the parent condition) inverts the result if enabled — e.g. show the
  block on all days EXCEPT the checked ones.
- Timezone: `date('D')` uses PHP's configured/local timezone; there is no site- or user-timezone
  handling, so the "day" boundary is server-local midnight.
- Combine with core visibility conditions on the same block; core ANDs the enabled conditions.
- Day-of-week only — no date range exists in this source.
