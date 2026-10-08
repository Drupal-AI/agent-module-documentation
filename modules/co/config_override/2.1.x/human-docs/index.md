# Config Override — manual setup guide

**Config Override** (`config_override`) gives developers structured, organised ways to
override Drupal configuration per environment — from a site file, from a module, or from
**environment variables** — instead of accumulating a growing pile of
`$config['…']['…'] = …;` lines in `settings.php`.

Drupal's underlying configuration *override* system is excellent, but its only front end is
hand‑written PHP in `settings.php`. On a real project that turns into dozens of override
lines spread across several environment‑specific include files, with no structure, no
discoverability, and no way for a module to ship its own overrides. Config Override supplies
the missing organisation through three override sources: a **site‑level** override folder, a
**module‑provided** mechanism (a module contributes overrides via YAML files), and an
**environment‑variable** source backed by `symfony/dotenv`. That last one is the interesting
one — it lets configuration be driven by environment variables in exactly the way
containerised, twelve‑factor deployments expect.

This is **developer infrastructure**: there are no routes, no permissions, and no admin UI.
You wire it up in code and configuration files, not by clicking through the site. It
requires Drupal `^10 || ^11` and the `symfony/dotenv` library (pulled in automatically by
Composer).

Two behaviours follow from the fact that this builds on core's override system, and both
are worth stating plainly:

- **Overrides are runtime‑only.** An overridden value is what the site actually *uses*, but
  `drush config:export` still writes the stored (un‑overridden) value. That is exactly what
  you want for per‑environment differences — the export stays environment‑neutral — but it
  regularly confuses people who expect the export to match what they see on the site.
- **Overridden values are not editable in the admin forms.** Core deliberately shows and
  saves the stored value while ignoring form edits for keys that are overridden. This is
  correct behaviour, but it surprises site builders who try to change an overridden setting
  through the UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form and adds no
admin menu items. Setup happens in `settings.php`, in a module's YAML, or via environment
variables, as described below.

## How to use it

Config Override offers three ways to provide overrides; pick whichever fits each case:

- **Site‑wide override folder.** Point `settings.php` at an `'override'` directory (the
  module's `README.md` documents the exact setting). Configuration placed there overrides
  the active configuration site‑wide — a tidier home than inline `$config` lines.
- **Module‑provided overrides.** A custom module can ship override YAML files so that
  installing the module applies sensible defaults or environment‑specific values. This is
  the way to package overrides for reuse across several sites.
- **Environment variables.** Backed by `symfony/dotenv`, this source lets an environment
  variable (or a `.env` file) drive a configuration value — ideal for container deployments,
  per‑environment API endpoints, and keeping production differences out of Git. See the
  module's `README.md` for the naming convention that maps a variable to a config key.

> **Secrets belong in a Key, not an override.** The environment‑variable source is perfect
> for per‑environment *endpoints* and non‑secret differences, but configuration overrides
> are readable by anything that can read config. For genuine secrets (API keys, passwords),
> prefer a [Key](https://www.drupal.org/project/key) entity backed by an environment
> variable. On DDEV you can set the variable with
> `ddev dotenv set .ddev/.env --my-var=<value>` and then `ddev restart`.

> **Not the same as Config Ignore / Config Split.** Those modules decide *what gets
> exported*; Config Override decides *what value is used at runtime*. It is common to use
> both.
