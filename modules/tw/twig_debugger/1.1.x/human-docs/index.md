# Twig Debugger — manual setup guide

**Twig Debugger** (`twig_debugger`) adds a single admin checkbox that turns
Drupal's Twig template‑engine **debug mode** on or off — without you having to
hand‑edit `sites/default/services.yml`. Twig debug mode is the standard way theme
developers discover which template renders what: it wraps every rendered template
in HTML comments listing the theme hook, the candidate template‑suggestion file
names, and the actual `.html.twig` file used. That is exactly the information you
need to know which template to override.

Normally you enable this by editing the `twig.config` block in
`sites/default/services.yml` and clearing caches. This module does that for you.
When you save its form with the box ticked, it creates `services.yml` (copied from
`default.services.yml` if none exists yet), sets `debug: true`, `auto_reload: true`,
and `cache: false`, and flushes all caches. Turning the box off deletes that
generated `services.yml` again and flushes caches. It is handy for themers who
don't have shell access, and for keeping debug settings out of version control.

Two things to keep in mind. First, this is a **development‑only convenience** — you
should never leave Twig debugging enabled in production, because it slows rendering
and exposes template internals. Second, the module only writes `services.yml` when
that file does **not already exist**; on a site that already has one, ticking the
box saves the setting but will **not** rewrite your existing file, so you'll need
to set the `twig.config` values by hand. Access to the toggle is gated by its own
permission. The module has no config schema, no plugins, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the one‑checkbox settings form, what
   it writes, and the important caveat about existing `services.yml` files.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Twig
Debugger** (`/admin/config/development/twig-debugger`). Reaching it requires the
**Administer twig debugger configuration** permission
(`administer twig debugger configuration`).
