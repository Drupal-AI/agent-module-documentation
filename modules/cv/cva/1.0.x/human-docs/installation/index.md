# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **`twig/html-extra`** PHP package (`^3.12`), which provides the underlying
  `html_cva` function. Composer installs it automatically as a dependency of this
  module.

No other Drupal modules are required.

Optional: **`tales-from-a-dev/twig-tailwind-extra`** adds a `tailwind_merge`
filter that de-duplicates conflicting Tailwind classes emitted by `html_cva`.
Require it separately if you want it.

## Install with Composer

From the project root:

```bash
composer require drupal/cva -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install `twig/html-extra`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cva -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cva -y
```

There's nothing to configure — enabling the module makes the `html_cva` function
available in your templates.

## Verify it worked

Add `{{ html_cva(base: 'x').apply({}) }}` to a template (or run it through
`\Drupal::service('twig')->renderInline(...)`) — it should render `x` without a
Twig error about an unknown function or a sandbox violation. Then use it as shown
in [How to use it](../index.md#how-to-use-it).
