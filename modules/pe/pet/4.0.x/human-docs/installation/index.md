# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Token** module (`drupal/token`) — required, for token substitution in subjects and
  bodies.
- Core's **Options** module (`options`) — required, and part of Drupal core.
- *Optional:* **MimeMail** (`drupal/mimemail`) for HTML email with a plain-text alternative;
  **Rules** (`drupal/rules`) if you want the legacy Rules integration (see the note below).

## Install with Composer

From the project root:

```bash
composer require drupal/pet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Token module and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pet -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pet -y
```

Drupal enables Options and Token automatically as dependencies.

## Optional: MimeMail

If you want to send HTML email with a plain-text alternative (or send plain-text-only), also
install and enable MimeMail:

```bash
composer require drupal/mimemail -W
drush en mimemail -y
```

When MimeMail is present, PET's template form and preview expose the extra plain-text/HTML
options.

## A note on Rules

The module ships a legacy Rules integration written for the Drupal 7 Rules API. It is **not
functional** with the modern Rules module on Drupal 10/11 unless ported — treat Rules-based
sending as non-working, and drive sends from the interactive form or from custom code instead.

## Next steps

Grant the PET permissions carefully (see [Configuration](../configuration/index.md) — note
that *View PET entity* also reaches the send page), then create your first template at
**Structure → PETs**.
