# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No contributed‑module dependencies — the module **bundles** the Mustache.php and
  Mustache.js libraries.
- Be aware the project is marked **Unsupported / no further development**; there
  will be no new releases, so review it accordingly before use.

## Install with Composer

From the project root:

```bash
composer require drupal/mustache_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mustache_templates -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mustache_templates -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mustache Token** | `mustache_token` | Decorates the token system for richer token handling inside templates. |
| **Mustache Views** | `mustache_views` | A Views style/integration so Views output can be templated with Mustache. |
| **Mustache Magic** | `mustache_magic` | The `MustacheMagic` `{{...}}` helper plugins, plus a `/m/sync` endpoint that re‑renders a stored template by an unguessable salted hash and enforces entity view access. |

Enable any of them with `drush en`, for example:

```bash
drush en mustache_magic -y
```

Each submodule requires the base module, which is already present once you have
installed it above.

## After enabling

- Turn on the **Mustache** filter for a trusted text format at **Configuration →
  Content authoring → Text formats and editors**
  (`/admin/config/content/formats`).
- Grant **view mustache debug messages** at **People → Permissions** if you want
  the debug `{{show.*}}` output to appear.

## Verify it worked

In a text format that has the Mustache filter enabled, author a snippet such as
`{{site.name}}` and view the rendered content — it should print your site name.
That confirms the filter and rendering engine are working.
