<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "core" ECA modeller plugin

eca_cm **implements** ECA's `EcaModeller` plugin type (defined by the `eca` module); it does not
define a new plugin type. It contributes a single modeller:

```php
// src/Plugin/ECA/Modeller/Core.php
/**
 * @EcaModeller(
 *   id = "core",
 *   label = "ECA Classic Modeler",
 *   description = "Simple modeler using the Drupal form API."
 * )
 */
class Core extends \Drupal\eca\Plugin\ECA\Modeller\ModellerBase { … }
```

- Plugin id: **`core`** (this is the value stored as `modeller` on models it authors).
- Base class: `ModellerBase` from ECA; controller `CoreModeller` drives the add/edit/delete forms.
- Unlike graphical modellers (BPMN.js based), this one renders plain Drupal forms, so it works
  without JavaScript and is screen-reader friendly.

## How a model is stored

Every ECA model — regardless of modeller — is an **ECA config entity**: `eca.eca.<id>`. In
ECA 3.x the entity's **`config_export`** is only:

```
id, uuid, status, weight, template, events, conditions, gateways, actions
```

Note what is **not** exported to `eca.eca.*` config: there is **no `modeller` key and no `label`
key** stored there. The modeller association is handled at runtime by ECA / the `modeler_api`
layer (ECA passes `modeller` to `Eca::create()`, but it is not a persisted config property), and
the human label lives in the modeller's model data, not in `config_export`. So you cannot filter
persisted config by `modeller === 'core'`. Identify models by their **machine id** and inspect
`status`:

```bash
# list all ECA model ids + status
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("eca")->loadMultiple() as $e) {
  print $e->id()." status=".var_export($e->status(),TRUE)."\n";
}'
drush cget eca.eca.<id>          # raw config: id/status/weight/template/events/conditions/…
```

Create one programmatically (roughly what `/admin/config/workflow/eca/add/core` does before you
add components):

```php
\Drupal::entityTypeManager()->getStorage('eca')->create([
  'id' => 'my_model', 'label' => 'My model', 'modeller' => 'core', 'status' => TRUE,
  'events' => [], 'conditions' => [], 'actions' => [], 'gateways' => [], 'version' => '1.0.0',
])->save();
```

(`label`/`modeller`/`version` are accepted by `create()` but are not written to `eca.eca` config
export; the real UI flow persists label/modeller through the modeller service.) The
`events`/`conditions`/`actions` keys are filled in by adding components through the forms
described in [configure/build-model.md](configure/build-model.md).
