# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1.0`).

The base module has no dependencies of its own. Each **submodule** depends on the base
`hook_event_dispatcher` module (Composer/Drush pull it in automatically). Two
submodules need extra modules present: **Webform Event Dispatcher** needs the contrib
**Webform** module, and **JSON:API Event Dispatcher** relates to core's JSON:API.

Two optional modules are *suggested* (not required): **Token** (for extra tokens and a
token browser) and **Paragraphs**.

## Install with Composer

From the project root:

```bash
composer require drupal/hook_event_dispatcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed. This one Composer package contains the base module and all the submodules; you
choose which to enable in the next step.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hook_event_dispatcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enabling the **base module alone** gives you the dispatch machinery but **no events**.
Enable the submodule that owns the hook you want to subscribe to — for most sites that
is Core Event Dispatcher, which also enables the base module for you:

```bash
drush en core_event_dispatcher -y
```

## The submodules

Enable only what you use:

| Submodule | Machine name | Events for |
|-----------|--------------|-----------|
| **Core Event Dispatcher** | `core_event_dispatcher` | entity, form, theme, block, file, menu, token, language, page, options, and general core hooks |
| **Field Event Dispatcher** | `field_event_dispatcher` | field widget/formatter/info hooks |
| **Media Event Dispatcher** | `media_event_dispatcher` | media hooks |
| **Path Event Dispatcher** | `path_event_dispatcher` | path / alias hooks |
| **Preprocess Event Dispatcher** | `preprocess_event_dispatcher` | `template_preprocess_*` / preprocess hooks |
| **User Event Dispatcher** | `user_event_dispatcher` | user hooks (login, cancel, etc.) |
| **Views Event Dispatcher** | `views_event_dispatcher` | Views hooks |
| **Toolbar Event Dispatcher** | `toolbar_event_dispatcher` | toolbar hooks |
| **JSON:API Event Dispatcher** | `jsonapi_event_dispatcher` | JSON:API hooks |
| **Webform Event Dispatcher** | `webform_event_dispatcher` | Webform hooks (needs the contrib Webform module) |

For example, to subscribe to Views and user hooks as well as core ones:

```bash
drush en core_event_dispatcher views_event_dispatcher user_event_dispatcher -y
```

## Next steps

There is no configuration screen. Once the right submodule is enabled, write an event
subscriber in your own module — see the "How to use it" summary on the
[overview page](../index.md) and the [`agent/`](../agent/start.md) docs for full code
examples.
