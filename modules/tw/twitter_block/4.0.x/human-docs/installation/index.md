# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and it
  is what lets you place the timeline block. Drupal enables it as a dependency
  automatically.

There are no third-party PHP library or Composer requirements. Note that the live
timeline is rendered by Twitter's own `widgets.js`, which the block loads from
`//platform.twitter.com/widgets.js` at view time, so visitors' browsers need to be
able to reach that external script for the embed to appear.

## Install with Composer

From the project root:

```bash
composer require drupal/twitter_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twitter_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twitter_block -y
```

The module ships no submodules and no settings form. Once enabled, the **Twitter
block** becomes available under the *Twitter* category on **Structure → Block
layout** — see [the index page](../index.md#how-to-use-it) for how to place and
configure it.
