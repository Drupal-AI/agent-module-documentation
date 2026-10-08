# Preprocess — manual setup guide

**Preprocess** (`preprocess`) is a developer API module that lets you move
`hook_preprocess_HOOK()` logic out of your bulky `THEME.theme` or `MODULE.module` files
and into small, focused **Preprocess plugin** classes — one class per theme hook.

If you've ever had a `mytheme_preprocess_node()` function grow into a wall of `if
($variables['...'])` branches, this module is the cure. Instead of one giant preprocess
function, you write a dedicated plugin class for each theme hook you want to touch. Each
plugin declares the single hook it handles and implements one method that receives the
template variables and returns them modified. The module runs the right plugins for each
theme hook automatically — including for theme-hook *suggestions* like `node__article`,
so you can target a suggestion without writing `if ($hook == 'node__article')` guards.

The payoff is preprocessing that's structured, testable and easy to read: each hook's
logic lives in its own class, multiple modules can each contribute a plugin for the same
hook, and you can refactor a legacy `.theme` file hook-by-hook. The module's dispatch is
registered to run **last**, so your plugin changes apply on top of core and theme
preprocessing.

This module has **no UI, settings, permissions or Drush** — it's purely an API. On its
own it does nothing until you (or another module/theme) provide Preprocess plugins.

This guide is written for a **human**, with a developer orientation. For terse,
token-cheap references aimed at an AI coding agent — including the plugin interface, base
class and manager services — read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

Nowhere — Preprocess is a developer API with no admin pages, settings, or menu items.
You use it by writing plugin classes in your own modules and themes.

## How to use it

A Preprocess plugin is a small class that handles exactly one theme hook. There are two
ways to register one:

1. **A class annotation** (modules only). Put a plugin class in your module's
   `src/Plugin/Preprocess/` directory, extend `PreprocessPluginBase`, add a
   `@Preprocess(id = "...", hook = "...")` annotation naming the theme hook, and
   implement `preprocess(array $variables): array`. Annotation discovery does **not**
   scan themes, so this route is for modules.

2. **A `NAME.preprocessors.yml` file** (modules **and** themes). Map a plugin id to its
   `class` and `hook` in a `yourtheme.preprocessors.yml` (or
   `yourmodule.preprocessors.yml`) file. This is the way to register preprocessing from a
   **theme** without writing a PHP hook.

The **`hook`** value is the theme hook whose variables the plugin should modify —
exactly what you'd put after `hook_preprocess_` — for example `node`, `node__article`,
`page`, `block`, `field`, `image`, or `views_view`.

Some things worth knowing:

- **Theme-provided plugins** are only active when that theme (or a base theme of it) is
  the active theme — so a base theme's preprocessing applies to its sub-themes
  automatically.
- **Several plugins** can target the same hook; they all run in turn.
- After adding or changing a plugin, **rebuild caches** (`drush cr`) so it's discovered.

For the exact interface, base class, annotation keys and the manager services that
dispatch the plugins, see the agent docs:
[`agent/plugins/preprocess-plugin.md`](../agent/plugins/preprocess-plugin.md) and
[`agent/api/manager.md`](../agent/api/manager.md).
