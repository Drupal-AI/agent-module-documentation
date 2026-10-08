# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Field** module (`field`) — part of Drupal core and normally already
  enabled.

There are no third‑party PHP library requirements. The field works on any of
Drupal's supported databases; on Drupal 10 / 11.0 / 11.1 the Views integration
transparently falls back to a pre‑11.2 helper, with no action required.

> **Privacy note.** IP addresses are **personal data** in many jurisdictions.
> Handle stored values in line with your privacy policy and applicable law.

## Install with Composer

From the project root:

```bash
composer require drupal/field_ipaddress -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_ipaddress -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_ipaddress -y
```

## Verify it worked

On any entity's **Manage fields**, add a new field and confirm **IP address**
appears in the field type list. Create the field, then add an entity and enter a
value such as `10.10.10.0/24` — a valid IP, range, wildcard, or CIDR should be
accepted, and clearly invalid input should be rejected inline.
