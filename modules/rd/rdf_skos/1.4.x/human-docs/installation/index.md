# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **SPARQL Entity Storage** module at **^2.0.0-beta1**
  (`drupal/sparql_entity_storage`), pulled in with Composer.
- A **triplestore** (typically Virtuoso) reachable from your site, exposed to
  Drupal as a **`sparql_default`** database connection in `settings.php`.

> **Critical:** without the `sparql_default` connection in place, Drupal will not
> bootstrap once this module is enabled. Set up the triplestore first — see the
> warning on the [overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/rdf_skos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies and bring in SPARQL Entity Storage at the required version.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rdf_skos -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Configure the SPARQL connection first

Before enabling the module, add a `sparql_default` connection to your
`settings.php` pointing at your triplestore, and confirm the triplestore is
running and reachable. This step is what prevents the
*"The specified database connection is not defined: sparql_default"* failure.

## Enable the module

```bash
drush en rdf_skos -y
```

If you need multilingual concept labels to resolve, also enable the language
mapping submodule:

```bash
drush en rdf_skos_language_mapping -y
```

## Verify it worked

After enabling, run a Drush command such as `drush status` and confirm it
completes without the `sparql_default` error — that confirms the SPARQL
connection is wired up correctly. Then point the module at your SKOS graph IRIs
and check that concept schemes and concepts load as entities.
