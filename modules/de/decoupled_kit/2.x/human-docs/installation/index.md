# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **JSON:API Resources** module (`drupal/jsonapi_resources`) — a hard
  dependency that Decoupled Kit builds its endpoints on. Drupal will enable it as a
  dependency.

There are no PHP or front‑end library requirements beyond those.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_kit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in JSON:API Resources
and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_kit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_kit -y
```

Enabling the base module pulls in JSON:API Resources automatically if it is not
already on.

## Submodules — enable only what you need

The base module provides the framework; the actual endpoints come from submodules.
The 2.x branch ships these:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Decoupled Kit Block** | `decoupled_kit_block` | An endpoint returning the blocks for the current page — respecting region, visibility, and weight — given the current theme and selected regions. In 2.x this also covers breadcrumbs. |
| **Decoupled Kit Redirect** | `decoupled_kit_redirect` | Integrates with the Redirect module to return redirect data for the current page, so your front end can honour Drupal‑managed redirects. |

Enable the ones you need, for example:

```bash
drush en decoupled_kit_block decoupled_kit_redirect -y
```

## Verify it worked

After enabling a submodule, call its JSON endpoint from your front end (or `curl`)
with the appropriate query parameters (for example a `?path` for the current page)
and confirm you receive the expected JSON — block data for the Block submodule, or
redirect data for the Redirect submodule. Then double‑check that the data returned
respects your intended access rules before wiring it into your front end.
