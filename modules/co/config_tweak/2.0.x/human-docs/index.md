# Configuration Tweak — manual setup guide

**Configuration Tweak** (`config_tweak`) is a developer utility that strips certain
unwanted or circular dependencies out of your exported configuration, so Drupal's
**Configuration updates report** stays "clean" — showing no spurious changes between
your active configuration and what is stored on disk. If you have ever exported
configuration and then watched the same items show up as "changed" on every
environment for no real reason, this is the class of problem it addresses.

It hooks into the configuration export process and removes dependencies that would
otherwise cause churn. Currently it offers two tweaks:

- **Break circular dependency in entity reference** — removes the dependency an
  entity-reference field records on its target bundles.
- **Break circular dependency in Entity Browser** — removes the dependency an Entity
  Browser records on its view widget.

Both are opt-in per instance: a field or Entity Browser widget only has its
dependency stripped when you add `dependencies_optional: yes` to the relevant part of
its config YAML. (Using it with Entity Browser also requires a patch, referenced in
the module's README, from drupal.org issue 3035036.) A single settings form lets you
toggle which tweaks are active.

This is squarely a developer and site-building tool. It has no runtime routes, no
data-mutation endpoints, and makes no external calls — its entire effect is limited
to what gets written into your exported configuration. The settings form is gated by
the `administer site configuration` permission. This is the 2.0.x branch for core
10.4 or 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the two tweaks, and
   how to opt individual fields and widgets in.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Config
tweak** (`/admin/config/development/config_tweak`), behind the `administer site
configuration` permission.
