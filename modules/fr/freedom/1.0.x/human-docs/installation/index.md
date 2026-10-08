# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** (`commerce`) enabled — this is a hard dependency, since the
  whole module exists to override a Commerce service. Drupal will pull it in as a
  dependency if it isn't already on.

There are no third‑party Composer or PHP library requirements, and no additional
recommended modules.

## Install with Composer

From the project root:

```bash
composer require drupal/freedom -W
```

Note the Composer package is **`drupal/freedom`**, but the module you enable is named
**`freedom_commerce`** (the project is `freedom`; its Commerce sub‑module is
`freedom_commerce`). The `-W` (`--with-all-dependencies`) flag lets Composer update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/freedom -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en freedom_commerce -y
```

There is nothing to configure afterwards — the module takes effect immediately.

## Verify it worked

Open the **Commerce dashboard** and check the admin toolbar: the promotional **Inbox**
panel and its toolbar indicator should be gone, and the inbox local action should no
longer appear in the admin menus. Commerce will also no longer make outbound requests
for marketing messages.

## Removing it

To bring back the default Commerce inbox behaviour, simply uninstall the module:

```bash
drush pmu freedom_commerce -y
```
