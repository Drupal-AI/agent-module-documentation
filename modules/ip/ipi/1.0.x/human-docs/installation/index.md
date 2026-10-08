# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11||^12`).
- The **Paragraphs** ecosystem, which Composer/Drupal will need alongside IPI:
  Paragraphs (`paragraphs`), Paragraphs Library (`paragraphs_library`),
  Paragraphs Browser (`paragraphs_browser`), and Entity Browser's entity-form
  integration (`entity_browser_entity_form`).
- The willingness to **apply patches** and **import a configuration file** by
  hand — this module explicitly requires both (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/ipi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ipi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Apply the required patches

Before enabling IPI, apply the patches the module ships/references for
**Paragraphs Browser** and **Drupal core**. The most robust way to keep these is
with [`cweagans/composer-patches`](https://www.drupal.org/docs/develop/using-composer/manage-dependencies#patches),
declaring each patch in your `composer.json` so they re-apply on every install.
Consult the module's `README` for the exact patch files.

## Enable the module

```bash
drush en ipi -y
```

Drupal will enable the Paragraphs, Paragraphs Library, Paragraphs Browser and
Entity Browser dependencies at the same time if they are not already on.

## Import the shipped configuration

IPI requires you to **manually import one configuration file** it provides. Follow
the steps in the module's `README` (typically importing the single config item
via *Configuration → Development → Configuration synchronization → Import →
Single item*, or with `drush config:import` for a partial import).

## Verify it worked

Open a content type or paragraph type that uses a Paragraphs field and edit that
field's settings — you should now see the option to scope which paragraph types
are available. In the editor, open the paragraphs browser: only the in-scope types
should appear, and any library paragraphs should show with a pink background.
