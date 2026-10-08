# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Serialization** module (`serialization`) — enabled automatically as a
  dependency.
- The **`SchemaForms`** and **`Shaper`** PHP libraries, needed for turning a
  component's JSON schema into form fields. These are pulled in through the module's
  Composer requirements.
- *(Optional)* **`league/commonmark`** — install it if you want a component's README
  to render as Markdown inside the component picker.

## Install with Composer

From the project root:

```bash
composer require drupal/cl_editorial -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the `SchemaForms`/`Shaper` libraries the
form generator relies on.

To add optional Markdown rendering of component docs:

```bash
composer require league/commonmark
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cl_editorial -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cl_editorial -y
```

## Submodule — Single Directory Components: Tagging

Component Libraries: Editorial bundles one optional submodule, **sdc_tags**, which
adds a system for tagging and grouping SDC components (with its own configuration
UI and a `component_tag` plugin type). Enable it only if you need tagging:

```bash
drush en sdc_tags -y
```

The submodule requires the base `cl_editorial` module, which is already present
once you have installed it above.
