# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other Drupal module
  dependencies — the toolkit builds only on Drupal core's component and plugin
  layers.

## Install with Composer

From the project root:

```bash
composer require drupal/dx_toolkit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dx_toolkit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dx_toolkit -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DX Toolkit Demo** | `dx_toolkit_demo` | Working examples of every plugin system and pattern the toolkit provides — ServiceInjector plugins with derivers, EntityGenerator implementations, and ServiceInstance usage. Enable it as a learning reference; you would not normally keep it enabled in production. |

To enable the demo:

```bash
drush en dx_toolkit_demo -y
```

## Verify it worked

Because DX Toolkit is a code library, the real test is that its classes are
available to your custom code — enable the module, then reference a toolkit base
class or helper from your own module and confirm it resolves. Enabling
`dx_toolkit_demo` and inspecting its example plugins is a quick way to confirm
everything loaded.
