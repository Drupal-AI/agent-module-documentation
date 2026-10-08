# Component — manual setup guide

**Component** (`component`) lets a front-end developer expose a JavaScript
component to Drupal as a placeable block by writing a single YAML file — no
block plugin, no PHP, no custom module. You drop a `*.component.yml` file next
to your component's JS and CSS in a `component/` subfolder of any module or
theme, and the module auto-discovers it and makes it available as an ordinary
block called `ComponentBlock`. Because it behaves like any core block, you can
place it in regions, give it visibility conditions, and even add a
configuration form so site builders can tune it.

The appeal is the reduced boilerplate: making a JS widget available to site
builders normally means a block plugin, a settings form, a library definition
and a template — four files for something the front-end developer already
finished. Component replaces all of that with one declarative file that says
"here is the component, here are its settings, here is its library," and keeps
that definition sitting right next to the component's code. It has no module
dependencies and ships an example submodule (`component_example`) that
demonstrates forms, parameters, and shared libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Before you enable it — two important cautions

Please read these before installing on a site you care about.

- **This release fatals on every cache clear once enabled — verified.** The
  module registers a discovery service tagged for cache clearing but that
  service does not implement the method Drupal's cache-clearer calls, so a
  `drush cr` throws a fatal error (`Call to undefined method …
  clearCachedDefinitions()`). Worse, module installation *ends* with a cache
  clear — so enabling `component` can fatal **mid-install**, leaving it (and any
  other modules enabled in the same batch) in a half-installed state that
  reports as "Enabled" but never actually ran its install steps. Recovery means
  removing the affected modules from `core.extension` and re-enabling them
  without `component`. Treat this version as not safely installable until that
  one-line upstream fix lands. This documentation was written from source for
  that reason.
- **Single Directory Components (SDC) are now in Drupal core.** The maintainers
  themselves note that Component may be discontinued because core SDC covers the
  same ground. For new work, prefer core SDC.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its example submodule).

There is **no configuration page** for this module — components are defined in
YAML files in your codebase, and each component is configured per-block like any
other block once placed.

## Where it lives in the admin menu

Component adds no admin settings page. Once enabled and once your
`*.component.yml` files are discovered, each component appears as a block in
**Structure → Block layout** (and in Layout Builder), where you place and
configure it exactly like a core block.
