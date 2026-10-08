# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module (standard in Drupal).
- A working **CiviCRM** installation integrated with Drupal (the `civicrm`
  module), including the **Form (Afform) core extension**. The **Form Builder**
  extension is also recommended so you can see and configure Afforms via a GUI.

> **Install CiviCRM first.** CiviCRM must be present and working before you enable
> this module, since the block lists and renders CiviCRM's Afforms.

## Install with Composer

From the project root:

```bash
composer require drupal/civicrm_afform_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/civicrm_afform_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en civicrm_afform_block -y
```

## Verify it worked

Go to **Structure → Block layout** and click **Place block**. The **CiviCRM Afform
Block** should appear in the list of available blocks, and when you configure it the
**CiviCRM Form Name** drop-down should be populated with your Afforms. Place one,
choose a form, save, and view the page to confirm the form renders.

> **Note:** this module is not covered by Drupal's security advisory policy and its
> declared core support stops at Drupal 10; check compatibility before using it on
> Drupal 11.
