# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

That's the whole hard list — there are no module dependencies and no third‑party
PHP libraries. One optional note: **language switching** only works when core's
**Language** module (`language`) is enabled. Without it the service still renders
entities fine; it just can't force a specific language, and the language services
are wired as optional so the module runs happily without them.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_render_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_render_context -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_render_context -y
```

There are no submodules and no configuration step. Once enabled, the
`entity_render_context.renderer` service is available for injection or via
`\Drupal::service()`.

## Verify it worked

Since there's no UI, verify from code or a quick Drush eval — for example, render a
node and check you get HTML back:

```bash
drush php:eval "print \Drupal::service('entity_render_context.renderer')->renderEntity(\Drupal\node\Entity\Node::load(1));"
```

If node 1 exists, you should see its rendered HTML. See the [overview](../index.md)
for the full API.
