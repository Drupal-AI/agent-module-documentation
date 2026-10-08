# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`) — this is
  the declared dependency and is enabled automatically.
- The **[Token](https://www.drupal.org/project/token)** module is an additional
  requirement noted by the project, since the tokens are surfaced through Token's
  browser. Install it if it isn't already present.

Note the project states it is currently compatible with **Group version 1** — make
sure that matches your setup before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/group_relationship_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_relationship_tokens -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_relationship_tokens -y
```

If Token isn't installed yet, add it too:

```bash
composer require drupal/token -W
drush en token -y
```

## Verify it worked

Open a token browser anywhere it appears (for example the Pathauto pattern form).
Expand the tokens and confirm you can see chained `[group_relationship:…]` tokens
for the entity types your group relationships connect to.
