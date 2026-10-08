<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `featureflags` condition plugin (FeatureFlagStatus)

Source: `src/Plugin/Condition/FeatureFlagStatus.php`.

`@Condition(id = "featureflags", label = "Feature flags")`, extending core
`ConditionPluginBase` and implementing `ContainerFactoryPluginInterface` (injects
`entity_type.manager`). Because it is a standard condition plugin it appears wherever Drupal
collects conditions — most notably **block visibility** (Block UI → *Visibility* → *Feature
flags*), but also any custom condition set.

## Configuration

`defaultConfiguration()` adds `flags => []` and `conjunction => 'OR'`.

`buildConfigurationForm()` renders:

- `flags` — `checkboxes`, options from `getFeatureFlagOptions()` (all `featureflag` entities keyed
  by id → label).
- `conjunction` — `radios`, required, `OR` (at least one selected flag active) or `AND` (all
  selected flags active).

`submitConfigurationForm()` keeps only the checked flags (`array_filter(array_values(...))`); if
none are checked it `unset()`s both `flags` and `conjunction` so the plugin is treated as inactive
(no condition applied).

## Evaluation

`evaluate()` loads the selected `featureflag` entities and reads each flag's `getState()`:

- `OR`: returns `TRUE` as soon as any selected flag is active; if none are, returns `FALSE`.
- `AND`: returns `FALSE` as soon as any selected flag is inactive; if all pass, returns `TRUE`.
- With no flags selected, `AND` returns `TRUE` and `OR` returns `FALSE`.

Negation is handled by the base plugin (the *Negate the condition* checkbox); `summary()`
describes the resulting sentence, e.g. *"Returns true if any of the flags Foo, Bar are active"*.

## Cache & dependencies

- `getCacheTags()` merges each selected flag's `getCacheTagsToInvalidate()`, so a block using this
  condition is invalidated when a referenced flag's config changes. (Flag *state* changes should
  additionally be covered by the `featureflags:{id}` cache context on the rendered output — see
  [../api/flag-checks.md](../api/flag-checks.md).)
- `calculateDependencies()` adds each selected flag as a config dependency
  (`config: featureflags.flag.{id}`), so exporting a block that uses the condition pulls the flag
  definitions along.

## Use it

1. Place or edit a block; in *Visibility*, open *Feature flags*.
2. Tick one or more flags and choose *OR* or *AND*.
3. Optionally tick *Negate the condition* to hide the block when the flags match.
