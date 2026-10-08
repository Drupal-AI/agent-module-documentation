<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Trim (there is nothing to configure)

Trim has **no configuration**: `configure` is `null` in `trim.info.yml`, it ships no
`config/` directory, no settings form, no permissions, and no config schema. Enabling the
module is the entire setup:

```bash
drush en trim -y
```

From that moment every content entity form trims surrounding whitespace from its string
values. There is no per-field, per-bundle, or site-wide toggle — it is all-or-nothing and
applies to all content entity forms.

## The one piece of persistent state: module weight

The only thing "set" on install is Trim's module weight, written to `core.extension`:

```bash
drush cget core.extension module.trim
# 'core.extension:module.trim': 1001
```

`trim_install()` sets it to **1001** so Trim's `hook_form_alter` runs last and its validator
ends up first (see [../api/mechanism.md](../api/mechanism.md)). If some other module needed
to trim/alter values *after* Trim, you would raise that module's weight above 1001; you
normally never touch Trim's weight. To restore the default:

```php
// drush php:eval
module_set_weight('trim', 1001);
```

## Turning it off

There is no "disable trimming for field X" setting. To stop trimming, uninstall the module:

```bash
drush pmu trim -y
```

## Exportable config

Because the weight lives in `core.extension`, it travels with a normal configuration export;
there is no Trim-specific config to export or import.
