# Installation

## Requirements

- **Drupal 11.2+ or 12** (`core_version_requirement: ^11.2 || ^12`).
- **PHP 8.3 or newer**, with the **DOM** extension (`ext-dom`) — both used to parse and
  build the BPMN XML.
- The **Modeler API** module (`drupal/modeler_api` `^1.0`) — Composer installs it. This
  is the framework BPMN.iO plugs into.
- The **`mtownsend/xml-to-array`** PHP library (`^2.0`) — Composer installs it
  automatically for converting BPMN XML.
- A **model‑owner** module to actually model something — for example **ECA** or **AI
  Agents**. BPMN.iO is the editor; the owner provides the models.
- The **Claro** or **Gin** admin theme (or a subtheme). The modeler renders only under
  these.

## Install with Composer

From the project root:

```bash
composer require drupal/bpmn_io -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Modeler API and the
`mtownsend/xml-to-array` library along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/bpmn_io -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bpmn_io -y
```

Drupal enables Modeler API automatically as a dependency. BPMN.iO has no settings form
of its own — once enabled, select it as the modeler in a model‑owner module (ECA, AI
Agents) and make sure your admin theme is Claro or Gin, as described in the
[overview](../index.md#how-to-use-it).
