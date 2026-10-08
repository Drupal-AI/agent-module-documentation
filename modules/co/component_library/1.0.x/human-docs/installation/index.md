# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Entity API** module (`entity`).
- The **CodeMirror Editor** module (`codemirror_editor`) — provides the in-browser
  code editor for components.
- Core's **Layout Builder** module (`layout_builder`).

Note this release is an early **alpha** (1.0.0-alpha6) and is not covered by
Drupal's security advisory policy — weigh that, together with the markup/JS
injection note below, before using it on production.

## Install with Composer

From the project root:

```bash
composer require drupal/component_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity API,
CodeMirror Editor, and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component_library -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en component_library -y
```

This enables Entity API, CodeMirror Editor, and Layout Builder as dependencies if
they are not already on.

## Submodules

Enable these only if you need them:

- **Component Library Engine** (`component_library_engine`) — the engine
  submodule for rendering/processing components.
- **Component Library Workspaces** (`component_library_workspaces`) — integrates
  with core Workspaces so you can publish component changes together with a
  workspace.
- **Group Component Library** (`gcomponent_library`) — integrates with the
  contributed **Group** module (which it requires) so each group can select its
  own component styles/variants. Only relevant on sites using Group.

For example:

```bash
drush en component_library_workspaces -y
```

## Grant permissions carefully

Because components hold markup and template code, editing them is a powerful
capability. At **People → Permissions** (`/admin/people/permissions`), grant the
component-editing permissions only to trusted developer/site-builder roles.

## Verify it worked

After enabling, open the module's component-management interface and confirm you
can create a component and edit its template/CSS/JS with the CodeMirror editor.
Components you build should then be available to place through Layout Builder.
