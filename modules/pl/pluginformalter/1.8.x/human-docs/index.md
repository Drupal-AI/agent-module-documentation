# Plugin Form Alter — manual setup guide

**Plugin Form Alter** (`pluginformalter`) is a developer tool that lets you
replace `hook_form_alter()` implementations with tidy, discoverable **FormAlter
plugin classes**. Instead of piling form tweaks into a monolithic `.module`
file, each alteration lives in its own class under
`src/Plugin/FormAlter/`, keyed by the form id (or base form id) it targets,
weighted so multiple alterations run in a predictable order, and easy to unit
test in isolation.

The module provides three plugin types. The main **FormAlter** plugin matches
forms by `form_id` or `base_form_id` (wildcards with `*` are supported), and
your class simply implements `formAlter(&$form, $form_state, $form_id)`. Two
companion types bridge the same idea to subforms: **ParagraphsFormAlter** (match
by paragraph type) and **InlineEntityFormAlter** (match Inline Entity Form
subforms by type, entity type, bundle, and so on). If Webprofiler is installed,
its Forms data collector is decorated to show which plugins altered each form.

> **Important — deprecation.** On Drupal 11.2 and later, every FormAlter plugin
> that runs triggers an `E_USER_DEPRECATED` notice, and these plugins **stop
> being called entirely in Drupal 12**. For new work, use core's OOP Hooks
> instead. Plugin Form Alter is best used today to organize existing code and to
> help you migrate legacy `hook_form_alter()` logic toward OOP.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Plugin Form Alter has no admin UI, no settings page, no permissions,
and no Drush commands. It is purely a developer API. Everything happens in code.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. In your own module, create a class under `src/Plugin/FormAlter/` that extends
   `Drupal\pluginformalter\Plugin\FormAlterBase`.
3. Give the plugin an `id`, an optional `label`, an array of `form_id`s **or**
   `base_form_id`s to match (wildcards like `node_*_edit_form` are allowed), and
   an optional integer `weight` to order it against other plugins.
4. Implement `formAlter(array &$form, FormStateInterface $form_state, $form_id)`
   with your changes — add fields, set `#access`, attach submit/validate
   handlers, inject default values, and so on. Override `create()` if you need
   dependency injection.
5. Clear caches so the plugin is discovered.

Base-form-id plugins run before form-id plugins, and within each group the
`weight` decides the order, so several modules can each contribute independent
FormAlter plugins to the same form without stepping on each other. For subforms,
use the **ParagraphsFormAlter** or **InlineEntityFormAlter** variants the same
way, matched by their respective keys.
