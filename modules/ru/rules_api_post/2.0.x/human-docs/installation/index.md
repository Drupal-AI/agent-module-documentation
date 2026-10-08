# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Rules** module (`rules`) — this action plugin plugs into Rules.
- For the `hal_json` REST format the action uses, the relevant web‑services modules:
  **HAL**, **Serialization**, **RESTful Web Services**, and **HTTP Basic
  Authentication** (plus **REST UI** if you want a UI to configure REST). `hal_json`
  now lives in the contrib **HAL** module rather than core.

This project is not covered by Drupal's security advisory policy and is marked as no
longer under active development — it's best treated as example/starter code.

## Install with Composer

From the project root:

```bash
composer require drupal/rules_api_post -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rules_api_post -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rules_api_post -y
```

Enabling it also imports the bundled demo content types and example Rule so you can
study the full pattern.

## Verify it worked

Go to **Configuration → Workflow → Rules** (`/admin/config/workflow/rules`). When you
add or edit an action in a reaction rule, the **API POST** action should appear in
the action list. The imported example rule and demo content types confirm the module
installed its sample configuration.
