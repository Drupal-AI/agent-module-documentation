# Common Overrides — manual setup guide

**Common Overrides** (`common_overrides`) gives you a small back‑end
configuration surface for tweaking behaviors that Drupal core hard‑codes or makes
awkward to override. In its current release, it lets you customize the heading on
the **node search results** page — both the heading **text** and the HTML **tag**
(`h1`–`h6`) used to wrap it.

The problem it solves: core's search results title is baked into the search
controller, so changing it normally means a custom module or theme override.
Common Overrides handles that for you with a route subscriber that swaps in its
own search controller and applies your configured heading — useful, for example,
to give the search results page an SEO‑friendly `h1` with wording you choose,
without writing code.

It has no other module dependencies and does nothing visible until you set the
heading text/tag on its settings form. Configuration is gated by the standard
**Administer site configuration** permission. Because the module is **not covered
by Drupal's security advisory policy**, and its heading markup is built by
concatenating your chosen tag and text, keep the settings restricted to trusted
administrators (both inputs are admin‑controlled, and the tag comes from a fixed
list).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the search results heading text
   and tag.

## Where it lives in the admin menu

The settings form lives at **Configuration → Common Overrides**
(`/admin/config/common_overrides`).

> **Note:** the module's `info.yml` "configure" link points at a route name that
> does not match the actual settings route, so the automatic **Configure** link on
> the Extend/modules page may be dead. If so, navigate directly to
> `/admin/config/common_overrides`.

See [Configuration](configuration/index.md).
