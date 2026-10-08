# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Token** module (`drupal/token`, `^1.0`), which Composer installs
  automatically as a dependency. Token Or extends Token, so it cannot work
  without it.

There are no other Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/token_or -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/token_or -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en token_or -y
```

There is no configuration. Once enabled, the piped `[a|b|"c"]` token syntax is
valid anywhere tokens are replaced — see the **How to use it** section on the
[overview page](../index.md).

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Token Or Webform** | `token_or_webform` | Extends the same OR/fallback behavior to Webform's own token manager, so piped fallback tokens work inside Webform email handlers and elements. |

Enable it only if you use Webform:

```bash
drush en token_or_webform -y
```
