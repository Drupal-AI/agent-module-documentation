# Configuration Rewrite — manual setup guide

**Configuration Rewrite** (`config_rewrite`) lets one module change configuration that
*another* extension already owns — deep‑merging or replacing values — by shipping YAML
files in its own `config/rewrite/` directory. Those files are applied automatically
when the module is installed. It is a developer and site‑builder tool, mostly used
inside install profiles, distributions, and "glue" modules.

The gap it fills: Drupal core's `config/install/` mechanism can only *create*
configuration that does not yet exist — it cannot touch config another module already
installed. So if you want your module to, say, add a permission to the existing
`authenticated` role, tweak a View someone else shipped, or set a few `system.site`
values, you would normally have to write custom `hook_install()` code. Configuration
Rewrite replaces that imperative PHP with declarative YAML.

When your module is installed, its `config.rewriter` service scans your
`config/rewrite/` folder. For each file named after an existing config object (e.g.
`system.site.yml`), it loads the live config, deep‑merges your YAML on top of it, and
saves the result. An optional `config_rewrite:` key in the file switches the strategy
to replacing the whole object, or only selected keys. Multilingual overrides are
supported, and the service can also be called directly from code.

There is **no admin UI, no permissions, and no Drush commands** — it is pure
build‑time plumbing. This guide is written for a **human**; if you want terse,
token‑cheap references for an AI coding agent — the exact YAML format, control keys,
and the service methods — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

You use Configuration Rewrite from inside a module of your own:

1. In your module, create a `config/rewrite/` directory.
2. Add a YAML file **named after the config object you want to change** — for example
   `config/rewrite/system.site.yml` to rewrite `system.site`, or
   `config/rewrite/user.role.authenticated.yml` to adjust that role.
3. Put only the keys you want to change in the file. They are **deep‑merged** onto the
   existing config, so everything you do not mention is left alone. List values (like a
   role's `permissions`) are appended, so adding a permission adds to the existing set
   rather than replacing it.
4. Install your module. The rewrites are applied automatically as it installs. The
   target config **must already exist** — you can only rewrite, never create.

To change the strategy, add a top‑level `config_rewrite:` key: `config_rewrite: replace`
swaps the entire object, and `config_rewrite: { replace: [key.path, …] }` replaces only
the listed keys (a listed key you omit from the file is deleted). Language‑specific
overrides go in `config/rewrite/language/<langcode>/`. See the
[`agent/`](../agent/start.md) docs for worked examples and for calling the
`config.rewriter` service directly from code.
