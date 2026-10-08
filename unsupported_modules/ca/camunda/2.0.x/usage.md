<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Camunda BPMN for ECA registers an ECA Modeller plugin that lets you author ECA models as BPMN 2.0 diagrams in the standalone Camunda Modeler desktop application and import/export them to/from the Drupal site.

---

Camunda BPMN for ECA is a thin integration between the ECA (Event-Condition-Action) automation
framework and the standalone Camunda Modeler — a desktop BPMN 2.0 diagram editor. It ships a single
ECA Modeller plugin (`Drupal\camunda\Plugin\ECA\Modeller\Camunda`) that subclasses
`eca_modeller_bpmn`'s `ModellerBpmnBase`, so all the heavy modelling, XML parsing and template
handling comes from the ECA base module; this project only supplies the `bpmn:` XML namespace prefix
and an override that exports element templates to a JSON file. In practice you build the workflow
visually in Camunda Modeler, then import the resulting `.bpmn` file into Drupal where ECA turns it
into an executable model. Because ECA models run with the site's own privileges, an imported model is
executable automation and only trusted users should author or import them. The project depends on
`eca:eca_modeller_bpmn (^2)` and is in the ECA package; it is marked Unsupported/Obsolete on
drupal.org (deprecated in favour of ECA's built-in modeller support). It defines no routes,
permissions, services, config, or drush commands of its own.

---

- Author ECA workflows as BPMN 2.0 diagrams in the desktop Camunda Modeler application.
- Import a `.bpmn` file produced in Camunda Modeler into Drupal as an ECA model.
- Export an existing ECA model to BPMN for editing in Camunda Modeler.
- Register the `camunda` ECA Modeller plugin (`@EcaModeller(id = "camunda")`).
- Provide a visual, diagram-based alternative to hand-editing ECA models.
- Reuse ECA's event / condition / action ecosystem from a BPMN canvas.
- Round-trip models between the Drupal site and the desktop modeller.
- Supply the `bpmn:` XML namespace prefix used when reading BPMN documents.
- Export ECA element templates for Camunda Modeler to `private://camunda.template.json`.
- Model business-rule / workflow automations without writing YAML by hand.
- Share BPMN model files with non-Drupal stakeholders who use Camunda Modeler.
- Version-control BPMN diagrams alongside a project's ECA configuration.
- Prototype automations visually before committing them to a site.
- Let a business analyst draft a flow in Camunda that a developer refines in ECA.
- Serve as the BPMN modeller backend for the ECA modeller UI.
- Keep ECA models human-reviewable as standard BPMN documents.
- Author event-condition-action logic (react to entity/form/cron events, run actions).
- Restrict model authoring/import to trusted administrators (models are executable).
- Use on Drupal 10.3+/11 sites that already run ECA.
- Treat it as a modeller add-on, not an access-control or engine-integration layer.
