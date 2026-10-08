# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8.0 || ^9 || ^10`).
- The **Acquia Site Studio** module (`cohesion`) enabled. This is a hard
  dependency and is Acquia's commercial product — the module only does anything
  on a site that already runs Site Studio.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_studio_per_component_libs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/site_studio_per_component_libs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_studio_per_component_libs -y
```

That is the whole install — there is no configuration form and no permissions to
grant.

## Define your per‑component libraries

The module only attaches libraries you have defined in your theme. In your active
theme's `*.libraries.yml`, add one library per Site Studio component you want to
enhance, naming each library after the component's machine name (UID):

```yaml
cpt_my_component_machine_name:
  css:
    component:
      css/cpt_my_component_machine_name.css: {}
  js:
    js/cpt_my_component_machine_name.js: {}
```

## Verify it worked

Add or edit a node that uses a component you have created a matching library for,
then view the page. The component's CSS/JS should now load on that page — and be
absent from pages that do not use the component.
