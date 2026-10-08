<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define & toggle features

Admin UI at `/admin/config/system/feature_toggle` (the `configure` route
`feature_toggle.feature_toggle_form`, menu under *Configuration → System*).

## The two storages (important)

Feature **definitions** and feature **status** live in different places:

| What | Where | Shape |
|---|---|---|
| Definitions (name, label, description) | **config** `feature_toggle.features` | `features.<name>: {name, label, description}` |
| On/off status | **key-value** store, collection `feature_toggle`, key `flags` | `{<name>: true|false}` |

So flipping a feature on/off is **not** a config change (it won't show in `drush config:export`);
it is a key-value write. `feature_toggle_uninstall()` clears the `feature_toggle` key-value
collection.

## Manage from the UI

1. Go to `/admin/config/system/feature_toggle` (the list of features with a checkbox each).
2. **Add feature** (`/admin/config/system/feature_toggle/add`): enter a **Feature Name** (label)
   and a **Machine name** (lowercase, numbers, hyphens), plus an optional description. Save.
3. On the list, tick/untick features and **Save** to toggle their status.
4. Edit / delete a feature from its row (requires `administer feature_toggle`).

## Manage from code

```php
use Drupal\feature_toggle\Feature;

$manager = \Drupal::service('feature_toggle.feature_manager'); // FeatureManagerInterface
$status  = \Drupal::service('feature_toggle.feature_status');   // FeatureStatusInterface

// Create a feature (definition -> config):
$feature = new Feature('beta_checkout', 'Beta Checkout', 'The new checkout flow.');
$manager->addFeature($feature);          // throws if it already exists

// Turn it on (status -> key-value), fires an event + clears cache tags:
$status->setStatus($feature, TRUE);

// Read status anywhere:
$on = $status->getStatus('beta_checkout'); // bool

// Update label/description, or delete (removes both config entry and status flag):
$manager->updateFeature(new Feature('beta_checkout', 'Beta Checkout v2'));
$manager->deleteFeature('beta_checkout');
```

## Read state via drush

```bash
# Definitions (config):
drush cget feature_toggle.features features
# Status (key-value): quickest via php:eval
drush php:eval 'print json_encode(\Drupal::keyValue("feature_toggle")->get("flags", []));'
# Toggle:
drush feature_toggle:set beta_checkout 1   # alias: drush ftset beta_checkout 1
```

## Cache

`setStatus()` (and add/update/delete) invalidate the cache tags `feature_toggle_list` and
`feature_toggle:<name>`. Tag your feature-dependent render arrays with `feature_toggle:<name>` so
they rebuild when the flag changes. The Condition plugin and route access check already add these.
