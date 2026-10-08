# Preprocessor Plugins — manual setup guide

**Preprocessor Plugins** (`preprocessors`) lets developers manage Drupal template
preprocessing through the **Plugin API**. Instead of scattering
`hook_preprocess_*` functions across a theme or module — and watching your
`THEME.theme` file grow into something no one wants to open — you implement each
piece of preprocessing as a discoverable, reusable plugin class. That brings an
object-oriented structure to preprocessing, including dependency injection, and
keeps related logic in its own file.

Under the hood the module integrates deeply with Drupal's **theme registry**,
inserting its preprocess callbacks at precise points among the existing preprocess
functions provided by core and other contrib, rather than running its own single
catch-all hook. This lets it respect the correct loading order of hooks, base
hooks, and registered preprocess functions.

This is a **developer/theming tool**. It has no content, no access control, and no
settings screen — you set it up entirely in code, by adding a small YAML file and a
plugin class to your theme. See "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Is this module still the right choice?** With Preprocess Hook Attributes
> supported in Drupal 11.2, and object-oriented (OOP) theme hooks in Drupal 11.3,
> this module is no longer recommended if you are on those versions or later — use
> the core attributes or OOP theme hooks instead. On earlier versions, or if you
> want plugin classes inside themes, it still does the job, but it is now only
> minimally maintained. For an even lighter-weight approach, see the sibling
> [Preprocessor Files](https://www.drupal.org/project/ppf) module, which uses plain
> per-template PHP files instead of plugins.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Everything is set up in your theme's code, described below.

## Where it lives in the admin menu

Preprocessor Plugins adds no admin page. You use it entirely from within your
theme's codebase.

## How to use it

Plugins are discovered in themes via **YAML discovery**. The pattern is a small
`*.preprocessors.yml` file at the root of your theme plus a plugin class.

1. Create `MY_THEME.preprocessors.yml` at the root of your theme:

   ```yaml
   MY_THEME.preprocessor.node:
     class: '\Drupal\MY_THEME\Plugin\preprocessors\NodePreprocessor'
     hooks:
       - node
     weight: 0
   ```

2. Create the class at
   `MY_THEME/src/Plugin/preprocessors/NodePreprocessor.php`:

   ```php
   <?php

   namespace Drupal\MY_THEME\Plugin\preprocessors;

   use Drupal\preprocessors\PreprocessorPluginBase;

   final class NodePreprocessor extends PreprocessorPluginBase {

     public function preprocess(array &$variables, string $hook, array $info): void {
       // Works just like the body of hook_preprocess_node().
       $variables['foo'] = 'bar';
     }

   }
   ```

3. Clear caches (`drush cr`). The `preprocess()` method now runs for the `node`
   template exactly as a traditional preprocess hook would, and you can inject
   services into the class like any other plugin.
