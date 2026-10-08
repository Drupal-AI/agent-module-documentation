# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Locale** module (`locale`) — this is a hard dependency and Drupal will
  enable it automatically when you turn on this module. Locale is what stores the
  interface translations the module exposes.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_interface_translations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_interface_translations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_interface_translations -y
```

Enabling this module pulls in core Locale as a dependency if it is not already on.

## Assign permissions

This is the important post‑install step, because the module's endpoints are gated
by the permissions it provides. Go to **People → Permissions**
(`/admin/people/permissions`) and grant them deliberately:

- Grant the **read** permission to the role(s) your front end uses to fetch UI
  strings — this is generally low‑sensitivity.
- Grant the **write** permission **only** to trusted operators or services.
  Translations are shown to every visitor, so anyone who can write them can inject
  text into your interface. Do not grant this to anonymous or general
  authenticated roles.

## Verify it worked

With the read permission assigned, call the retrieve‑translations endpoint from
your front end (or a tool like `curl`) and confirm you get back the site's
translated interface strings. If you granted the write permission to a trusted
service, confirm that submitting a string or override through the write endpoint
updates the corresponding translation in core's **User interface translation**
page (`/admin/config/regional/translate`).
