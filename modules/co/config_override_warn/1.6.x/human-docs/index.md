# Config Override Warn — manual setup guide

**Config Override Warn** (`config_override_warn`) shows a warning message on a
Drupal configuration form whenever one of the values on that form is currently
being **overridden** — either by a `$config[…]` line in `settings.php` or by a
module that implements Drupal's runtime config-override system. The warning tells
an administrator, right where it matters, that "saving" this setting won't actually
change what the site uses, because the override will keep winning.

This solves a common and confusing problem: you edit a value on a config form, you
save it, and nothing appears to change — because a per-environment override is
quietly taking precedence. Config Override Warn makes that situation visible on the
form itself, listing the overridden keys (and, optionally, the overridden values),
so no one wastes time "fixing" a setting that is pinned elsewhere.

The module works the moment you enable it — there is nothing you need to configure
and no admin page to visit. It has no permissions, no routes, and no plugins: it is
a single form alteration plus a small service. It works on core config forms (like
Basic site settings), on config-entity edit forms (a View, an image style, a text
format), and on the People → Permissions form.

One thing worth knowing: to inspect exactly which keys are overridden, the module
uses PHP reflection to reach into a couple of protected core methods and properties.
This is a deliberate, documented trade-off (there is no other way to get the
information) and it only runs on pages that render configuration forms, so the
performance impact is minimal.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. It has a single setting,
`show_values`, described under "The one optional setting" below.

## How to use it

Once enabled, just edit configuration as you normally would. If any value on the
form you open is currently overridden, Config Override Warn adds a warning message
at the top of the page naming the overridden keys. If nothing is overridden, no
message appears and the form behaves exactly as before. It is entirely passive — it
never disables or changes a field, it only informs you.

## The one optional setting

The module has a single setting, `show_values` in the `config_override_warn.settings`
config object, which defaults to `true`. When it is on, the warning shows both the
stored (original) value and the overriding value. When it is off, the warning only
names the overridden keys without printing their values — which is what you want on
a production site where an overridden value might be a secret such as an API key or
a password.

There is **no settings form** for this, so you change it from the command line or
via a config import. For example, to hide the values:

```bash
drush config:set config_override_warn.settings show_values false -y
```

A common pattern is to keep `show_values` off in production while turning it on for
local development, using a per-environment override of the module's own setting.
