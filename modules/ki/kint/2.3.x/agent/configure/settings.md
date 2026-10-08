<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kint settings & helper functions

Form `SettingsForm` (id `kint_admin_settings`) at route `kint.form`
(`/admin/config/development/kint`, permission `administer site configuration`).

## `kint.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `early_enable` | bool | `false` | allow dumps before authentication (else output waits for permission check) |
| `date_format` | string (nullable) | `[c]` | PHP date format for the dump footer timestamp |
| `rich_theme` | string | `original.css` | rich-renderer CSS theme, or a full path to a custom CSS file |
| `use_kint_trace_in_devel` | bool | `true` | override Devel's `ddebug_backtrace` with Kint's trace |

Built-in theme options: `original.css` (Default), `aante-light.css`, `aante-dark.css`,
`solarized.css`, `solarized-dark.css`, or `custom` (then a custom CSS path).

```bash
drush cget kint.settings rich_theme
```
```php
\Drupal::configFactory()->getEditable('kint.settings')
  ->set('rich_theme', 'solarized-dark.css')
  ->set('early_enable', TRUE)
  ->save();
```

Applied by `kint_initialize_kint_settings()` (sets `Kint::$enabled_mode`, `RichRenderer::$theme`,
timestamps) whenever the config loads.

## Helper functions (`kint.helper.*`)

Each dump helper is a config object named `kint.helper.<function_name>` (prefix
`kint.helper.`, see `HelperManager::HELPER_CONFIG_PREFIX`):

| Key | Meaning |
|---|---|
| `renderer` | FQCN of a Kint renderer: `Kint\Renderer\RichRenderer` / `PlainRenderer` / `CliRenderer` / `TextRenderer` |
| `cli_detection` | bool — use the CLI renderer when Kint detects CLI |
| `mode` | `default` (normal dump), `exit` (dump & die), `messenger` (dump to Drupal messages) |

Ships `kint.helper.d` (Rich) and `kint.helper.s` (Plain), creating the global `d()`/`s()`
functions. The settings form's **Helper functions** table adds/removes them (names must be valid
PHP function names). Create one programmatically:

```php
\Drupal::configFactory()->getEditable('kint.helper.dd')
  ->set('renderer', 'Kint\\Renderer\\RichRenderer')
  ->set('cli_detection', TRUE)
  ->set('mode', 'exit')          // dump & die
  ->save();
```
