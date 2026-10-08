# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/persistent_visitor_parameters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/persistent_visitor_parameters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en persistent_visitor_parameters -y
```

Then configure which parameters to capture and how long to keep them — see
"How to set it up" in the [overview](../index.md).

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Registration tracking** | `persistent_visitor_parameters_user_registration` | Attaches the captured parameters (UTM / referrer / form source) to a user when they register, so you can see where each registered user originally came from. |

Enable it only if you want registration attribution:

```bash
drush en persistent_visitor_parameters_user_registration -y
```

## Verify it worked

Visit a page on your site with a tracking query string, for example
`?utm_source=newsletter&utm_medium=email`. Then browse to another page and, from
your own code or a debugging tool, read
`\Drupal::service('persistent_visitor_parameters.cookie_manager')->getCookie()` —
the captured values should still be present, confirming they persisted across the
navigation.
