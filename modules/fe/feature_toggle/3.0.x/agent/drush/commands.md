<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

From `src/Drush/Commands/FeatureToggleCommands.php` (autowired via `drush.services`/`AutowireTrait`).

## `feature_toggle:set <name> <value>` (alias `ftset`)

Set a feature's on/off status.

- `name` — the feature **machine name** (must already exist as a defined feature).
- `value` — `0` (off) or `1` (on). Any other value errors with "Flag must be 0 or 1."

```bash
drush feature_toggle:set beta_checkout 1
drush ftset beta_checkout 0
```

Behaviour:
- Validates the feature exists via `FeatureManagerInterface::getFeature()`; if not, throws
  `\InvalidArgumentException` listing the available feature names.
- Calls `FeatureStatusInterface::setStatus($feature, (bool) $value)` — same path as the UI, so it
  fires the `feature_toggle.update` event and clears the `feature_toggle_list` /
  `feature_toggle:<name>` cache tags.
- Prints `Feature '<name>' toggled to <value>.`

That is the only command; there is no create/list Drush command — define features in the UI or via
`FeatureManagerInterface::addFeature()` (see [api/services.md](../api/services.md)).
