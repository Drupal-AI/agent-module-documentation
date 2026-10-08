# IMCE Dynamic File Path — manual setup guide

**IMCE Dynamic File Path** (`imce_dfp`) lets an [IMCE](https://www.drupal.org/project/imce)
profile compute its upload folder **dynamically** instead of pointing at one
fixed directory. Normally an IMCE profile browses and uploads into a set path; with
this module you can make that path depend on something — for example the current
user, or a token — so different people (or contexts) land in different folders
automatically. That keeps uploads organised without hand-maintaining a separate
profile for every case.

This is a **developer-oriented** module. The dynamic paths are produced by small
`ImceDfp` plugins that you write in your own custom module — each plugin returns
the folder path(s) IMCE should use — and you then reference the plugin by name in
an IMCE profile's folder configuration. Out of the box the module provides the
plumbing (the plugin type and the profile integration); the actual path logic is
yours to supply in code.

A word on access, because it matters here: IMCE controls file browsing and upload
*within the directories a profile allows*, so when you compute a path dynamically
you must make sure the result stays **inside the intended, permission-scoped
area**. A plugin that resolves to a path outside a user's allowed folder would
widen file access, so validate what your plugin returns. IMCE's own per-profile
permissions still govern who can browse and upload at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (IMCE is required).

There is **no dedicated settings form** for this module. You wire a dynamic path
into an IMCE profile and supply the logic with a plugin, described in "How to set
it up" below.

## Where it lives in the admin menu

The dynamic path is configured inside IMCE's own configuration at **Configuration
→ Media → IMCE** (`/admin/config/media/imce`), on the profile you edit. The plugin
that produces the path lives in your custom module's code.

## How to set it up

1. Install and enable the module (see [Installation](installation/index.md)). IMCE
   must be installed.
2. **Write an `ImceDfp` plugin** in a custom module — place a plugin class in
   `my_module/src/Plugin/ImceDfp` that implements the module's plugin interface
   and returns the folder path(s) IMCE should use from its `getPaths()` method.
   Give the plugin an id (for example `my_plugin`).
3. Go to **Configuration → Media → IMCE** (`/admin/config/media/imce`) and create
   or edit a **profile**.
4. In the profile's folder path configuration, reference your plugin by its id,
   using the form `dfp_plugin: my_plugin`.
5. Save the profile. IMCE will now use the folder(s) your plugin computes.

> **Validate the computed path.** Make sure your plugin only ever returns paths
> inside the area the profile is meant to expose — a path that escapes it would
> broaden what users can reach.
