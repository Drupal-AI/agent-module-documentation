# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other Drupal modules are required.
- A **Tailwind CSS executable** available on the server (see below). This is the one
  real external requirement.

## Install the module with Composer

From the project root:

```bash
composer require drupal/tailwind_jit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tailwind_jit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tailwind_jit -y
```

## Install Tailwind CSS

Tailwind JIT calls out to a Tailwind CSS executable to do the compilation. Choose
one of these:

- **Standalone CLI build (recommended, and the choice when Node.js is not available
  on your server).** Download the standalone Tailwind CSS CLI binary for your OS.
  On a Linux x64 system using Composer, you can pull in a patched build that bundles
  `postcss-nested` and `postcss-import`:

  ```bash
  composer require webtourismus/tailwindcss-cli
  ```

- **Node.js / npm.** If Node.js is available you can install Tailwind via npm and
  invoke it with `npx`. This is *not* recommended, because the standalone CLI is
  faster than `npx`.

## Point settings.php at the executable

In your `settings.php`, add a `$settings['tailwind_jit_executable']` variable
containing the path to the Tailwind executable. Use either an absolute path or a
path relative to the Drupal root (usually `/web`):

```php
// Absolute path to a standalone CLI binary:
$settings['tailwind_jit_executable'] = '/usr/bin/tailwindcss-macos-arm64';

// ...or a path relative to the Drupal root:
$settings['tailwind_jit_executable'] = '../vendor/bin/tailwindcss';

// ...or, for the Node.js install:
$settings['tailwind_jit_executable'] = 'npx tailwindcss';
```

## Next step

The compiler is not active until you switch it on in your theme settings — continue
to [Configuration](../configuration/index.md).
