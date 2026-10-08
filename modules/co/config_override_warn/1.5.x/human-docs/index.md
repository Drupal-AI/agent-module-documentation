# Config Override Warn — manual setup guide

**Config Override Warn** (`config_override_warn`) shows a warning message on
Drupal's configuration forms whenever a value on the form you are looking at is
currently being **overridden** — that is, when something outside the stored
configuration is quietly winning. Overrides usually come from `$config[…]` lines
in `settings.php` (common on multi-environment setups) or from a module that
implements Drupal's config override interface. Without this module, an admin can
"save" such a setting and see no effect, because the override keeps taking
precedence. The warning makes that situation visible right where it matters.

For each overridden setting on the form, the module names the exact key and (by
default) shows both the stored value and the value that is actually in effect, so
you can see precisely what has been changed and by how much. It works on core and
contrib configuration forms, and on config-entity edit forms (such as a view or
an image style).

The module is deliberately tiny: it has **no admin UI, no permissions, no routes
and no menu items**. It just adds the warning message automatically once enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Config Override Warn adds no pages of its own. Its effect appears
inline on the configuration forms you already visit. For example, if a
`$config['system.site']['slogan']` line in `settings.php` pins your slogan, the
**Basic site settings** form (`/admin/config/system/site-information`) will show a
warning that the slogan value has been overridden.

## How to use it

There is nothing to switch on beyond enabling the module. Once it is enabled,
open any configuration form whose settings are overridden in your environment and
you will see the warning at the top of the page. If nothing is overridden, no
warning appears.

### The one setting: showing or hiding overridden values

The module has a single configuration value, `show_values`, and it has **no
settings form** — you change it from the command line or a config import. By
default (`show_values: true`) the warning prints both the original and the
overridden value. If your overrides can contain secrets (API keys, credentials),
set it to hide the values so the warning only names the overridden keys:

```bash
# hide the values (name overridden keys only)
drush config:set config_override_warn.settings show_values 0 -y

# show the values again (the default)
drush config:set config_override_warn.settings show_values 1 -y
```

Because it is ordinary configuration, you can also override this setting
per-environment from `settings.php` — for example, hide values on production
while showing full diffs on your local site:

```php
$config['config_override_warn']['settings']['show_values'] = FALSE; // production
```
