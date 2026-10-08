# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Block** module (already on for most sites).
- A few contrib libraries that Composer pulls in automatically:
  **js_cookie** (used to remember the last-clicked tab), and — for the optional
  submodules — **jquery_ui_tabs** and **jquery_ui_accordion**.

## Install with Composer

From the project root:

```bash
composer require drupal/quicktabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `js_cookie`, `jquery_ui_tabs`, and
`jquery_ui_accordion`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quicktabs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quicktabs -y
```

The classic horizontal-tabs renderer is available immediately.

## Submodules — enable only what you need

Quick Tabs ships two optional submodules that add alternative presentation styles.
Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Quicktabs Accordion** | `quicktabs_accordion` | An `accordion_tabs` renderer that presents content as a collapsible jQuery UI accordion instead of horizontal tabs — good for FAQ-style sections. |
| **Quicktabs jQuery UI** | `quicktabs_jqueryui` | A `ui_tabs` renderer using the jQuery UI Tabs widget. |

For example, to add the accordion style:

```bash
drush en quicktabs_accordion -y
```

Each submodule requires the base Quick Tabs module, which is already present once
you have installed it above.

Next, head to [Configuration](../configuration/index.md) to build your first tab set.
