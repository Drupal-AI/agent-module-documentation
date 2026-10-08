<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Camunda BPMN for ECA (camunda) — agent index

Thin ECA Modeller plugin that lets ECA models be authored as **BPMN 2.0** diagrams in the standalone
**Camunda Modeler** desktop app and imported/exported to/from Drupal. "Camunda" = the desktop BPMN
diagram editor, NOT the Camunda BPM engine — there is **no** REST client, external API, or callback here.

- **Version dir:** 2.0.x (installed 2.0.0). Core `^10.3 || ^11`. PHP `>=8.1`. Package: ECA.
- **Dependency:** `eca:eca_modeller_bpmn (^2)` (composer `drupal/eca ^2.0`). All real logic lives there.
- **License:** GPL-2.0-or-later. Status on drupal.org: **Unsupported / Obsolete** (deprecated).

## What it provides
- One plugin: `Drupal\camunda\Plugin\ECA\Modeller\Camunda` (`@EcaModeller(id = "camunda")`),
  extends `Drupal\eca_modeller_bpmn\ModellerBpmnBase`.
  - `xmlNsPrefix()` → returns `'bpmn:'` (namespace prefix for BPMN documents).
  - `exportTemplates()` → writes `getTemplates()` (from the base class) as JSON to
    `private://camunda.template.json`.
- **No** routes, permissions, services, hooks, config objects/schema, drush commands, or submodules.
- Entire source is one 34-line file: `src/Plugin/ECA/Modeller/Camunda.php`.

## Operate it
- Author/edit models in Camunda Modeler; import the `.bpmn` via ECA's modeller UI. Imported models are
  executable ECA automation running with site privileges — restrict authoring/import to trusted users.

## Solution docs
- [Plugin: Camunda ECA Modeller](plugins/modeller.md) — the plugin, its two overrides, and how ECA uses it.
