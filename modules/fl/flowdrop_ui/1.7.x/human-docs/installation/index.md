# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).

FlowDrop UI has **no module dependencies** and no third‑party Composer or PHP library
requirements — the JavaScript editor is shipped as a pre‑built bundle inside the
module. In practice you rarely install it on its own; it comes in as a dependency of
the FlowDrop modules that use it.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_ui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Choosing a version.** This is the **1.7.x** line, which uses the `window.FlowDrop`
> mount functions. Composer installs whichever release matches your other FlowDrop
> modules; if you need the newer render‑element API, require the **2.0.x** line
> instead.

## Enable the module

```bash
drush en flowdrop_ui -y
```

## Verify it worked

There is no visible admin page. To confirm the module is active, check that the
`flowdrop_ui/editor` library is available and that any FlowDrop tool depending on it
renders its workflow canvas. Developers can verify the global `window.FlowDrop` object
exists on a page where the editor library is attached.
