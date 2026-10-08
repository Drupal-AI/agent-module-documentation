# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The third‑party **AOS** JavaScript library, installed manually into
  `/libraries/aos` (see below). It is *not* shipped with the module or pulled in
  by Composer.

There are no other Drupal module dependencies and no PHP library requirements.

## Install the module with Composer

From the project root:

```bash
composer require drupal/animate_on_scroll -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/animate_on_scroll -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the AOS library (required)

The AOS JS/CSS is not bundled. Download it from the AOS GitHub project and
extract it into your Drupal root so that these two paths exist:

```
/libraries/aos/dist/aos.js
/libraries/aos/dist/aos.css
```

Source: <https://github.com/michalsnik/aos> (the project README points at
`master.zip`). Until `libraries/aos/dist/aos.css` exists, the module reports an
error on **Reports → Status report** (`/admin/reports/status`) and shows a
warning at install time.

## Enable the module

```bash
drush en animate_on_scroll -y
```

Once the module is enabled and the library is present, the AOS assets load on
every page and initialize automatically. From there, animate elements by adding
`data-aos` attributes to your markup — see [the overview](../index.md#how-to-use-it).
