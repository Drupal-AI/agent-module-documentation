# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- Core's **Text** module (`text`) enabled — the module's only dependency, which
  Drupal enables automatically.

There are no third-party Composer or PHP library requirements.

> **Plan your data protection first.** Aadhaar is highly regulated personal data
> (UIDAI / DPDP Act). Before you collect any real numbers, decide how you will
> **encrypt** the field at rest, **restrict** access to it, and **mask** it in
> display. See the overview's [How to use it](../index.md#how-to-use-it) for the
> checklist — the widget validates format only and does not protect the data on
> its own.

## Install with Composer

From the project root:

```bash
composer require drupal/aadhaar_number_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/aadhaar_number_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aadhaar_number_widget -y
```

Once enabled, the Aadhaar Number widget is selectable on the *Manage form
display* screen for text fields. There is no configuration form. See
[How to use it](../index.md#how-to-use-it) in the overview — and add the
encryption, access restriction, and masking before collecting live data.
