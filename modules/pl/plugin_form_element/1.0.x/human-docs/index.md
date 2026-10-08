# Plugin form element — manual setup guide

**Plugin form element** (`plugin_form_element`) gives developers two Form API
elements — `plugin` and `plugins` — that let a plugin's configuration form be
embedded directly inside any Drupal form. Instead of hand‑building the UI to select
and configure pluggable components, you drop in a form element and it renders the
right configuration form for you.

The two elements cover the common cases:

- **`#type => 'plugin'`** renders the configuration form for a *single*
  pre‑selected plugin — for example one condition or one action whose ID you
  already know.
- **`#type => 'plugins'`** provides a full **multi‑item UI backed by vertical
  tabs**, where users can add, configure, and remove several plugins from any
  plugin manager. It supports AJAX add/remove, an optional `#cardinality` limit on
  how many plugins can be added, and an optional `#allowed_plugins` allowlist of
  which plugins appear in the Add menu.

Both work with any plugin manager implementing `PluginManagerInterface`, support
`FilteredPluginManagerInterface` for context‑aware filtering, and are fully
compatible with `PluginFormInterface` and `PluginWithFormsInterface`. On submit,
the `plugins` element returns a UUID‑keyed array of plugin configurations, ready to
store and reinstantiate later.

It is purely a developer/Form‑API tool with no content or access‑control role, and
it ships a `plugin_form_element_test` submodule used for testing and examples.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
use its elements in your own form code, described in "How to use it" below.

## How to use it

Add one of the elements to a form array in code. For a single, already‑chosen
plugin:

```php
$form['condition'] = [
  '#type' => 'plugin',
  '#title' => $this->t('Condition'),
  '#plugin_manager' => 'plugin.manager.condition',
  '#default_value' => ['id' => 'language', 'langcodes' => ['en' => 'en']],
];
```

To let users pick and configure several plugins from a manager:

```php
$form['conditions'] = [
  '#type' => 'plugins',
  '#title' => $this->t('Conditions'),
  '#plugin_manager' => 'plugin.manager.condition',
  '#cardinality' => -1,                              // -1 = unlimited
  '#allowed_plugins' => ['language', 'request_path'], // optional allowlist
  '#default_value' => $saved_config,                  // keyed by UUID
];
```

On submit, `$form_state->getValue('conditions')` returns a UUID‑keyed array of
plugin configurations you can store and later reinstantiate.
