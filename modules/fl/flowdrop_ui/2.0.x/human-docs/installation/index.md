# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).

FlowDrop UI has **no module dependencies** and no third‑party Composer or PHP library
requirements — the JavaScript editor is shipped as a pre‑built bundle inside the
module. In practice you rarely install it on its own; it comes in as a dependency of
the FlowDrop modules that use it (for example `flowdrop`, `flowdrop_workflow`,
`flowdrop_runner`).

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

> **Choosing a version.** This is the **2.0.x** line, which uses the `flowdrop_editor`
> render element and the `Drupal.flowdropUi` API — a breaking change from the 1.7.x
> `window.FlowDrop` mount functions. Make sure the FlowDrop modules you build on expect
> the 2.x editor before pinning to this line.

## Enable the module

```bash
drush en flowdrop_ui -y
```

## Verify it worked

There is no visible admin page. To confirm the module is active, add a
`flowdrop_editor` render element to a test route (or check a FlowDrop tool that depends
on it) and confirm the workflow canvas renders. Developers can verify that
`drupalSettings.flowdropUi.instances` is populated and that `Drupal.flowdropUi` is
defined on a page containing an editor.
