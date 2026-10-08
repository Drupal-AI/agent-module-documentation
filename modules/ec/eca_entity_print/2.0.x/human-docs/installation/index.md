# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- The **ECA** base module (`eca`) — installed automatically as a dependency.
- The **Entity Print** module (`entity_print`), installed and configured with a
  working PDF engine (for example Dompdf or wkhtmltopdf). Entity Print is not a
  hard dependency in the module's info, so require it explicitly if it is not
  already present.

There are no third‑party PHP library requirements declared by this module itself
(the PDF engine is Entity Print's concern). You will also want one of ECA's
modelling tools installed (BPMN.iO or the ECA Classic Modeller).

## Install with Composer

From the project root:

```bash
composer require drupal/eca_entity_print drupal/entity_print -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and update any
shared dependencies as needed. Requiring `drupal/entity_print` alongside it ensures
the rendering module is present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_entity_print -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_entity_print entity_print -y
```

This also enables `eca` if it is not already on.

## Verify it worked

Open an ECA model at **Configuration → Workflow → ECA**, add an action, and confirm
the "print entity/View to file" actions provided by this module appear in the list.
Run a test model and check that a file entity is created with the rendered document.
