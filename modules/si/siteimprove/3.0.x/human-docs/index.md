# Siteimprove.ai Plugin — manual setup guide

**Siteimprove.ai Plugin** (`siteimprove`) connects Drupal to the Siteimprove.ai
platform and brings its content, accessibility, SEO and analytics insights right
into the editing workflow. Instead of leaving Drupal to check a page in
Siteimprove, editors see the Siteimprove overlay while they work, run a
pre‑publish content check, and re‑check a page immediately after making a fix.

Siteimprove is a SaaS platform that audits sites for content quality,
accessibility, SEO and analytics. This module is the bridge: on configured entity
routes — nodes, taxonomy terms and groups, on both their canonical view and their
edit form — it injects the Siteimprove overlay and its JavaScript, and it requests
a short‑lived authentication token from Siteimprove's token endpoint so the
overlay can talk to the platform. It also adds a "prepublish" content check and a
"recheck" action so an editor can re‑scan a page without leaving Drupal. For
content teams already using Siteimprove, this puts the platform's findings where
the work actually happens and removes the context switch.

The module needs configuration to work: you install its one dependency
(`js_cookie`), enter or generate the Siteimprove token on the settings form, grant
the overlay permissions to your editor roles, and pick the frontend‑domain plugin
that matches your setup. It has no submodules of its own, though a companion
module (`siteimprove_domain_access`) exists for sites using Domain Access.

On the security side, this is a well‑behaved integration: the settings form is
gated by the `administer siteimprove` permission, and the token is fetched
server‑side over HTTPS from `https://my2.siteimprove.com/auth/token` with normal
certificate verification left on (it is not disabled). There are no anonymous or
mutating endpoints. Note that enabling Siteimprove *Analytics* on your site is out
of scope for this module — refer to Siteimprove's own documentation or the
separate Siteimprove.ai Analytics module for that.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its `js_cookie` dependency).
2. [Configuration](configuration/index.md) — enter the token, grant permissions,
   choose which routes load the overlay, and set the frontend domain.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Siteimprove.ai**
(`/admin/config/system/siteimprove`), behind the `administer siteimprove`
permission. By default the overlay is only available to administrators — grant the
`use siteimprove` permission to other roles to open it up.
