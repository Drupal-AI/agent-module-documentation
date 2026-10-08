# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **GraphQL** module (`graphql`), version **4.1** or newer.
- The **Simple OAuth** module (`simple_oauth`), version **6.0** or newer — it
  issues and validates the tokens whose scopes the directive checks.

There are no additional Composer or PHP library requirements beyond those
modules.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_oauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will pull in GraphQL and Simple OAuth if they are
not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_oauth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with GraphQL and Simple OAuth:

```bash
drush en graphql simple_oauth graphql_oauth -y
```

## Verify it worked

There is no settings page for this module. To confirm it is working, add the
OAuth directive to a test field in your schema, then query it twice: once with
no token (or a token missing the scope), which should be denied, and once with a
token carrying the required scope, which should succeed. Set up your OAuth
consumers and scopes under **Configuration → People → Simple OAuth** first.
