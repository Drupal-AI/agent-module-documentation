# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Tamper** module (`tamper:tamper`) enabled.
- Core's **Taxonomy** module (`drupal:taxonomy`) enabled — the plugin looks up and
  creates taxonomy terms.
- To use it in a Feeds import you also need the **Feeds** and **Feeds Tamper**
  modules (`drupal/feeds`, `drupal/feeds_tamper`).

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_tamper_term_hierarchy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will bring in Tamper if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_tamper_term_hierarchy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_tamper_term_hierarchy -y
```

This also enables Tamper and Taxonomy if they aren't on yet. If you haven't
already, enable Feeds and Feeds Tamper too, so the plugin is available inside a
Feed type's Tamper tab:

```bash
drush en feeds feeds_tamper -y
```

## Verify it worked

Open a Feed type's **Tamper** tab at **Structure → Feed types**
(`/admin/structure/feeds`). When you add a plugin to a taxonomy term reference
field, **Import Taxonomy Terms Hierarchy** should appear in the list of available
tampers.
