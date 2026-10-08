# Configuration

Conflict has **no settings form**. It works out of the box with sensible
defaults, and its single option — how conflicts are presented to the editor — is
set through configuration rather than an admin page. If you never touch it,
conflicts are resolved with the **inline** UI.

## The resolution strategy

When Conflict finds fields that genuinely clash, it presents them for the editor
to resolve in one of two ways:

- **Inline** — the conflict‑resolution UI is embedded directly in the entity edit
  form. This is the shipped default.
- **Dialog** — conflicts are presented in a modal dialog.

You choose the strategy per **entity type** and **bundle**, with fallbacks. For a
given entity, Conflict looks up the most specific setting first and falls back to
broader ones:

1. the setting for that exact entity type and bundle, then
2. the default for that entity type, then
3. the global default (which is `inline` unless you change it).

## Setting it

The option lives in the `conflict.settings` config object. Because there is no
form, you set it with the config API, Drush, or a config import. For example, to
use a modal dialog for Article nodes:

```php
\Drupal::configFactory()->getEditable('conflict.settings')
  ->set('resolution_type.node.article', 'dialog')
  ->save();
```

To change the global default for every entity type and bundle:

```php
\Drupal::configFactory()->getEditable('conflict.settings')
  ->set('resolution_type.default.default', 'dialog')
  ->save();
```

You can read the current configuration with Drush:

```bash
drush cget conflict.settings resolution_type
```

To drop a bundle‑specific override so it falls back to the default again, clear
that key (for example `resolution_type.node.article`) and save.

> The resolution values are plain strings (`inline` or `dialog`), so setting them
> with `drush cset` is fine here. Take the usual care with `drush cset` on
> boolean‑typed config in other modules, where the string `"false"` would be cast
> to boolean `TRUE`.

## Extending comparison (developers)

Conflict decides which fields clash using pluggable **field comparators**. The
default comparator handles all fields, but a developer can write a custom
comparator to treat a particular field type or field as never‑conflicting,
always‑conflicting, or compared in a special way. See the sibling
[`agent/plugins/field-comparator.md`](../agent/plugins/field-comparator.md) for
the plugin details.
