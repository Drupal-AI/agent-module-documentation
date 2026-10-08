# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer (`php: 8.1`).
- A project that is a **Git repository** (the module installs its hooks into the
  project's `.git/hooks` directory).

PHPCS and Drupal Rector are set up by the module as part of its job, so you don't
need to configure them separately first.

## Install with Composer

From the project root:

```bash
composer require drupal/git_hooks_drupal_practice -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/git_hooks_drupal_practice -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en git_hooks_drupal_practice -y
```

Enabling the module creates the **pre‑commit** and **commit‑msg** hook scripts in
your project's `.git/hooks` directory.

## Verify it worked

Make a small change, stage it, and try to commit with a message that breaks the
convention (for example just `test`). The commit should be rejected by the
commit‑msg hook. Then commit with a proper message such as `ABC-123: adjust the
example` — if your staged code passes PHPCS and Rector, the commit goes through.
You can also look directly in `.git/hooks` and confirm the `pre-commit` and
`commit-msg` files are present.
