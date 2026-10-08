# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: >=11.1`).
- The following modules, which Composer installs for you as dependencies:
  - **Address** (`address`)
  - **Name** (`name`)
  - **Telephone** (core `telephone`)
  - **Image** (core `image`)
  - **Datetime** (core `datetime`)
  - **Inline Entity Form** (`inline_entity_form`)
  - **Primary Entity Reference** (`primary_entity_reference`)
- No additional PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/crm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required field modules (Address, Name, and the rest) alongside CRM.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crm -y
```

Enabling CRM also enables its dependencies. If you want to explore CRM with sample
data, the project also ships a demo recipe (Simpsons contact and relationship data)
you can apply on a fresh site — see the project page for the full demo walkthrough.

## Verify it worked

Go to **Structure → CRM → Contact types** (`entity.crm_contact_type.collection`).
You should see the three default contact bundles — Person, Household, and
Organization. You can also browse the contact portal at `/crm/contact`. From here,
head to [Configuration](../configuration/index.md) to tailor contact types and
fields, and review the access model.
