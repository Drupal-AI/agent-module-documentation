# Sites — manual setup guide

**Sites** (`sites`) turns a single Drupal installation into a multi‑site
platform, where each "site" is a plugin‑defined context that scopes content,
configuration, URL generation, permissions and language — all within one codebase
and one database. There are no separate Drupal instances to run and none of the
shared‑files complexity of core's traditional multisite: everything lives in one
install, and the notion of "which site am I on" becomes a first‑class, plugin‑driven
context.

The problem it solves is running several domain‑scoped sites — per‑group or
per‑brand microsites, for example — from shared content and configuration. You
define what a site *is* in a lightweight PHP class (a Site plugin), and Sites
handles the rest: it scopes content access so readers and editors only see the
content that belongs to their site, it generates URLs against the active site's
domain or path prefix, and it integrates a site cache context so pages stay correct
and fast across site boundaries. Per‑site configuration overrides let each site
carry different settings, language and appearance.

Because the definition of a site is code, **this module needs development work
rather than a settings form to become useful**: after enabling it you implement a
`SitePlugin` — an annotated PHP class extending `SitePluginBase` — that declares
which content and settings belong to each site. There is no configuration UI. It
depends on the **Environment Context** module and requires Drupal 10.3+ (the
project targets Drupal 11/12 for its plugin approach). It ships several submodules
for common patterns — path prefixes, path aliases, Pathauto, language negotiation,
ECA integration and a frontend preview switcher — and an `sites_example` submodule
with annotated example implementations to copy from.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and where to start writing your Site plugin.

## How to use it

Sites has no admin settings page — the work happens in code:

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enable the **`sites_example`** submodule to get annotated example Site plugin
   implementations you can learn from.
3. Implement your own **`SitePlugin`** — an annotated PHP class extending
   `SitePluginBase` — that defines which content and settings belong to each site.
4. Enable the submodules for the patterns you need (path prefixes, path aliases,
   Pathauto, language negotiation, ECA, the preview switcher).

This is an early release (1.0.0‑alpha1), so pin your version and test against your
target Drupal core.
