<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Camunda ECA Modeller plugin

`Drupal\camunda\Plugin\ECA\Modeller\Camunda` — the module's only class and only functional code.

## Definition
- Annotation: `@EcaModeller(id = "camunda")`. Registered as an ECA Modeller plugin, discoverable by
  the ECA framework (`eca` / `eca_modeller_bpmn`).
- Extends `Drupal\eca_modeller_bpmn\ModellerBpmnBase` (from the `eca_modeller_bpmn` submodule of the
  `eca` project), which itself extends ECA's `ModellerBase`. Nearly all behaviour — parsing the BPMN
  XML into an ECA model, rendering/round-tripping, template gathering — is inherited from that base.

## What this subclass overrides
Only two protected/public methods are implemented here:

1. `xmlNsPrefix(): string` → returns the literal `'bpmn:'`. The base uses this prefix when it reads
   BPMN 2.0 documents, so element lookups target the `bpmn:` namespace as emitted by Camunda Modeler.

2. `exportTemplates(): ModellerInterface` (`@throws \JsonException`) →
   `file_put_contents('private://camunda.template.json', json_encode($this->getTemplates(), JSON_THROW_ON_ERROR));`
   `getTemplates()` is provided by the base class and returns the ECA element templates (the set of
   available events/conditions/actions and their properties). This override serialises them to a
   single fixed file in the site's **private** filesystem so the Camunda Modeler desktop app can load
   them as element templates. The path is a constant — not derived from any request input — and the
   payload is Drupal-generated ECA metadata, not user-submitted content.

## How it is used (workflow)
- ECA's modeller UI lists this plugin as an available modeller. A `.bpmn` diagram built in the
  standalone Camunda Modeler is imported through ECA; the base class parses it (using the `bpmn:`
  prefix from `xmlNsPrefix()`) and stores it as an executable ECA model. Export reverses the process.
- Because the resulting ECA model runs with the site's privileges (as all ECA models do), authoring
  and importing models is a trusted-administrator operation — treat an imported model as executable
  automation, not as data.

## What it does NOT do
- No HTTP/REST client, no calls to a Camunda BPM engine or any external service, no credentials, no
  webhooks/callbacks, no routes, no permissions, no services, no config or schema, no drush commands.
  To understand the actual modelling/import/export mechanics, read `eca_modeller_bpmn`'s
  `ModellerBpmnBase` and ECA's `ModellerBase`, not this module.
