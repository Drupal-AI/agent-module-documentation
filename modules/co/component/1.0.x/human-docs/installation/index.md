# Installation

> **Read the cautions first.** This release fatals on every cache clear once
> enabled, and can leave modules half-installed if it fatals mid-install. See
> [Before you enable it](../index.md#before-you-enable-it--two-important-cautions)
> in the overview before proceeding, and prefer core Single Directory Components
> for new sites.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies and no third‑party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/component -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en component -y
```

## Example submodule

The project ships **`component_example`**, a set of sample components showing how
component settings forms work, how form parameters are passed into a component,
and how to share libraries. Enable it if you want a working reference to copy
from:

```bash
drush en component_example -y
```

## Define a component

The module discovers any `*.component.yml` file placed in a `component/`
subfolder of a module or theme. A minimal example:

```yaml
name: Widget
machine_name: widget
type: block
js:
  widget.js: {}
css:
  widget.css: {}
```

Put that file alongside `widget.js` and `widget.css` and the component becomes a
placeable block.

## Verify it worked

Go to **Structure → Block layout**, click **Place block** in any region, and
your discovered component(s) should appear in the block list. (Be aware that
rebuilding the cache to pick up new components can trigger the fatal described in
the cautions above.)
