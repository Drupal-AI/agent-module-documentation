# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — part of every standard Drupal install,
  and enabled automatically as a dependency.

### Recommended companion modules

These are not required, but Mentions is more capable with them:

- **[Token](https://www.drupal.org/project/token)** — for token support in the
  mention input/output patterns.
- **[Views](https://www.drupal.org/project/views)** (in core) — to list all
  mentions, mentions by user, and so on.
- **Libraries API** plus the **jQuery textcomplete** library — enables
  autocompletion that suggests usernames while you type a mention.

## Install with Composer

From the project root:

```bash
composer require drupal/mentions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mentions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mentions -y
```

## Verify it worked

Enabling the module is not enough on its own — the Mentions **filter** must be
turned on for at least one text format before mentions render. Follow
[Configuration](../configuration/index.md) to enable the filter, then type
`[@username]` (using a real account name) in a field that uses that format and
confirm it renders as a linked `@username`.
