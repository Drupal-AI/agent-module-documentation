# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Voting API** module (`votingapi`) — this is the module's dependency, and
  Composer installs it alongside Like and Dislike. Votes are stored and tabulated
  through Voting API.

## Install with Composer

From the project root:

```bash
composer require drupal/like_and_dislike -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Voting API.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/like_and_dislike -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en like_and_dislike -y
```

Enabling Like and Dislike also enables Voting API as a dependency.

## Verify it worked

Go to **Configuration → Search and metadata → Like and Dislike**
(`/admin/config/search/like_and_dislike`) and confirm the settings page loads and
lists your entity types. Remember that no widgets appear until you enable at least
one entity type there and grant the voting permission — see
[Configuration](../configuration/index.md).
