# Ironstar — manual setup guide

**Ironstar** (`ironstar`) provides **platform support and configuration recipes**
for Drupal sites hosted on the [Ironstar](https://ironstar.io/) platform, an
Australian managed Drupal/AWS hosting provider. Rather than adding a visible
feature, it ships the kind of environment integration a host provides so that
Drupal behaves correctly on its infrastructure — currently, recommended
configuration for the **Fastly**, **Memcache**, and **Monolog** modules so they are
set up to take advantage of the underlying Ironstar platform.

Its value is **operational, not feature-facing**. If your site runs on Ironstar,
this module helps caching, logging, and edge behaviour line up with what the
platform expects. On any other infrastructure it has no purpose.

The security-relevant angle for a host-integration module like this is usually
reverse-proxy / trusted-host handling and environment configuration — follow
Ironstar's own guidance for those. The module also provides its own permissions for
administering its settings, and includes a small settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — where the platform settings live and
   how they relate to the host's recipes.

## Where it lives in the admin menu

Ironstar provides a settings form defined by the `ironstar.settings` configuration.
It is reached from the site's configuration area behind the module's administer
permission — see [Configuration](configuration/index.md).
