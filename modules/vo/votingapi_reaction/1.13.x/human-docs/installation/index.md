# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Voting API** (`drupal/votingapi` `^3.0 || ^4.0`) — the contrib module that
  actually stores and tallies votes. Composer pulls it in for you.
- Core's **File** module (`file`) — enabled automatically as a dependency; it
  backs the uploaded reaction icons.

## Install with Composer

From the project root:

```bash
composer require drupal/votingapi_reaction -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Voting API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/votingapi_reaction -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en votingapi_reaction -y
```

Enabling it also enables Voting API and File if they aren't already on. The module
ships its six default reactions (angry, laughing, like, love, sad, surprised) as
vote types you can use immediately or replace.

Next, add a Reaction field and grant permissions — see
[Configuration](../configuration/index.md).
