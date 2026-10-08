# Views Advanced Routing — manual setup guide

**Views Advanced Routing** (`views_advanced_routing`) unlocks Symfony/Drupal
routing features that the Views UI doesn't otherwise expose. It adds a Views
**display extender** that lets you paste raw route `defaults`, `requirements`, and
`options` — the same YAML sections you'd write in a `*.routing.yml` file —
directly onto a View's page or feed display.

With it you can do things Views alone can't: attach an entity **parameter
converter** so a path like `node/%node/tab` upcasts `%node` into a real Node
object, wire a View into an existing entity's route hierarchy as a local task
(tab), add custom route **requirements** such as a parameter regex or an access
check, or set route **options** like `_admin_route: TRUE`. The values you enter
are validated as YAML and test‑built into a real Symfony Route before they're
saved, and they're stored inside the View config entity, so they deploy together
with the View.

Setup is two stages: you enable the display extender once, site‑wide, in the
Views settings, and then you fill in the Route YAML per display on whichever
Views you want to customize. The module has no permissions, Drush commands, or
services of its own — it all works through Views' own configuration.

> **A note on trust.** The Route settings give an administrator the same power as
> editing a `routing.yml` file, including access requirements and route options.
> That's a code‑level capability, so scope the *Administer views* permission to
> trusted people only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the display extender and set
   route YAML on a display.

## Where it lives in the admin menu

You turn the feature on under **Structure → Views → Settings → Advanced**
(`/admin/structure/views/settings/advanced`), in the *Display extenders* section.
After that, the per‑display **Route** settings appear inside each individual
View's edit screen under **Structure → Views**. Both require the *Administer
views* permission.
