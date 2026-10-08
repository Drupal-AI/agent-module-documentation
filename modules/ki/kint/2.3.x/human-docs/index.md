# Kint — manual setup guide

**Kint** (`kint`) brings the Kint PHP dumper into Drupal — a richer, more readable
replacement for `var_dump()` / `print_r()` when you are debugging. It gives you
two dump helper functions, **`d()`** (an interactive "rich" dump you can expand,
search and copy access‑paths from) and **`s()`** (a plain‑text dump), usable in
both PHP and Twig, all tuned for Drupal so you are not drowned in internal service
objects.

Out of the box Kint blacklists heavy Drupal internals (the module handler,
database connection, config factory, entity adapters) so dumps of entities and
render arrays stay legible, and it adds a parser that understands Drupal fieldable
entities. Because dump output is developer‑sensitive, it is **permission‑gated**:
after login, only users with the **View kint output** (`access kint dumps`)
permission see dumps, and an `early_enable` setting controls what shows before
authentication.

Kint also integrates with the **Devel** module — when Devel is installed you can
select Kint as its dumper so `dpm()` and friends render through Kint, and you can
have Kint replace Devel's backtrace with its nicer one. It plays nicely with the
CSP module too (nonce support), so dumps still appear on hardened sites.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent — including the helper‑config internals and the renderer
class names — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Kint
   libraries with Composer, and enable it.

## Where it lives in the admin menu

Kint's settings form is at **Configuration → Development → Kint**
(`/admin/config/development/kint`), gated by the core **Administer site
configuration** permission. The dump output itself is controlled by the separate
**View kint output** (`access kint dumps`) permission.

## How to use it

Once installed and enabled, grant **View kint output** to the roles that should
see dumps, then use the helpers in your code or templates:

```php
d($variable);   // rich, interactive dump
s($variable);   // plain-text dump
```

```twig
{{ d(variable) }}   {# in a Twig template (needs Twig development mode) #}
```

**When output actually appears:**

- **After login** — the user needs the **View kint output** permission. Grant it
  with, for example, `drush role:perm:add developer 'access kint dumps'`.
- **Before login** — governed by the `early_enable` setting (off by default).
- **Twig dumps** — additionally require Twig development mode
  (**Configuration → Development → Development settings**).
- **Via Devel** — if Kint is chosen as Devel's dumper, Devel's permissions apply.

## Configuring Kint

The settings form at **Configuration → Development → Kint** lets you tune:

- **Rich renderer theme** — the CSS theme for the interactive dump: Default,
  Aante light, Aante dark, Solarized, Solarized dark, or a **custom** CSS file
  path.
- **Footer date format** — the PHP date format for the timestamp shown at the
  bottom of a dump (default `[c]`).
- **Override Devel's backtrace** — whether to replace Devel's `ddebug_backtrace`
  with Kint's trace (on by default; only relevant with Devel).
- **Helper functions** — a table where you add or remove dump helpers. Each helper
  is a function name (like the built‑in `d` and `s`, or a custom `dd`) with its own
  **renderer** (Rich, Plain, Cli, or Text), a **CLI detection** toggle, and a
  **mode**: normal dump, **dump‑and‑die** (stop execution after dumping), or
  **dump‑to‑messenger** (show the dump as a Drupal status message). This is how you
  create, say, a `dd()` that dumps and halts.

The settings page even renders a live demo dump of its own configuration — if you
see nothing there, your role is probably missing the **View kint output**
permission.
