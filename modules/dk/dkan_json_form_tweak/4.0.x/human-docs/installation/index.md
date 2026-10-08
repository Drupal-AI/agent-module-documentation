# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **DKAN** site (`dkan`) — specifically DKANv2 or newer.
- The **JSON Form Widget** module (`json_form_widget`), which generates the
  schema‑driven metadata forms this module enhances.

There are no additional PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_json_form_tweak -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_json_form_tweak -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dkan_json_form_tweak -y
```

## Verify it worked

Go to the DKAN content type's **Manage form display** tab (for example the *data*
type). You should find new **JSON Form** options — navigation, close details and
remove multi‑value — that you can enable. Turn them on (see
[Configuration](../configuration/index.md)) and open a dataset edit form to see the
navigation panel and close/remove controls appear.
