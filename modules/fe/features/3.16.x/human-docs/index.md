# Features — manual setup guide

**Features** (`features`) packages site configuration into installable "feature"
modules. A bundle of related config — a content type with its fields, form and
view displays, a View, some permissions — can be exported to code, committed to
version control, moved between sites, and reverted back to a known state. In
other words, it turns a slice of your site's configuration into a redistributable
Drupal module.

Under the hood, Features groups configuration objects into **packages** using a
pipeline of **assignment method** plugins (which decide what config belongs in
which package) and then writes them out with **generation method** plugins (to
the filesystem, or as a downloadable tar archive). The behavior of that pipeline
is stored in a `features_bundle` config entity — a "bundle" that namespaces a set
of features and holds per‑assignment settings; a `default` bundle ships out of
the box. The central `features.manager` service detects **overrides** (active
config that differs from what's exported) and **missing** config, so you can
always see how a site has drifted from its stored feature.

A quick word on *when* to reach for Features: on modern Drupal, core's own
configuration sync (CMI), often with **Config Split**, is usually the better way
to move a *whole site's* configuration between environments. Features shines when
you want to bundle a **reusable, distributable** feature — for a distribution,
install profile, or a component you'll drop onto several sites — rather than sync
an entire site. Config exported by Features lands in each feature module's
`config/install` directory, so it installs like any other module's default
config.

Features is driven mostly from the command line (`features:export`,
`features:import`, `features:diff`, `features:status`, and more), and its base
module has **no UI of its own** — the optional **Features UI** submodule
(`features_ui`) adds the admin screens at
`/admin/config/development/features`. It depends on core's **Configuration**
module and the contrib **Config Update** module (used for diffing and reverting).

This guide is written for a **human** getting Features installed and understanding
the workflow. For the full Drush cycle, the `features_bundle` settings, the plugin
types, and the service API, an AI coding agent should read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer (including
   Config Update), enable it, and optionally enable the Features UI.

## Where it lives in the admin menu

The base module adds no admin pages. If you enable the **Features UI** submodule,
the management screens appear at **Configuration → Development → Features**
(`/admin/config/development/features`), where you can review, edit, and export the
config a feature contains. Otherwise you work entirely through Drush.

## How to use it

The core cycle is **export → commit → import (revert)**:

1. Build the configuration you want to package on a working site.
2. Export it into a feature module with `drush features:export`, then commit the
   generated module to version control.
3. On another environment (or after config drifts), re‑apply the exported config
   with `drush features:import`, or bulk‑revert everything with
   `drush features:import:all`.
4. Inspect differences at any time with `drush features:diff`, and check the
   active bundle and enabled assignment methods with `drush features:status`.

Other common tasks include adding specific config items to an existing package
(`drush features:add`), creating a `features_bundle` to namespace one client's or
product's features separately, tuning which config is treated as "core" or "site"
so machine‑specific settings aren't exported, and generating a downloadable tar
archive instead of writing to disk. If you enable Features UI, you can do the
review‑and‑export steps in the browser instead. Developers can implement custom
assignment or generation method plugins, or drive the whole thing from code via
the `features.manager` service — see the [`agent/`](../agent/start.md) docs.
