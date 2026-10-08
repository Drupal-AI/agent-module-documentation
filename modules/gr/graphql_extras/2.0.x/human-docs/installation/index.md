# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **GraphQL** module (`graphql`), version **3.x** — the field plugins are
  written against the GraphQL v3 schema system.

There are no additional Composer or PHP library requirements.

> **Heads-up:** This module is *not covered* by Drupal's security advisory
> policy and is only minimally maintained. Review it before using it on a
> production site.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql_extras -y
```

The GraphQL module is enabled automatically as a dependency if it isn't already.

## Verify it worked

There is no settings page. Open GraphiQL (or your GraphQL explorer) against a
GraphQL v3 server and confirm the new fields appear in the schema — for example
query `{ currentUrl currentLanguage }` and check that you get sensible values
back.
