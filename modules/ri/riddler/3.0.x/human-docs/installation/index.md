# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **CAPTCHA** module (`drupal/captcha` ^2) enabled — this is the dependency
  Riddler builds on, and Composer pulls it in.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/riddler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `drupal/captcha`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/riddler -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en riddler -y
```

This enables Riddler and, if it isn't already on, the CAPTCHA module. Riddler ships
one example riddle so you can see how it works before writing your own.

## Permissions

Riddler adds no permission of its own — managing riddles and attaching the challenge
are both gated by CAPTCHA's **Administer CAPTCHA settings** permission. Grant that
(at **People → Permissions**) to the administrators who should manage bot
protection.

## Next step

Create your own riddles and attach the Riddler challenge to the forms you want to
protect — see [Configuration](../configuration/index.md).
