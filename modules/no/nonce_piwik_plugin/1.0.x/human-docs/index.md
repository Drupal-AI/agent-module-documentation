# Nonce Piwik Plugin — manual setup guide

**Nonce Piwik Plugin** (`nonce_piwik_plugin`) adds [Piwik PRO](https://piwik.pro/)
analytics tracking to your Drupal site and — crucially — renders the tracking
script with a fresh **Content Security Policy (CSP) nonce** on every request. It
does this through the **Nonce Generator** module's plugin system, emitting the
Piwik PRO bootstrap as a `NonceScript` plugin (`PiwikScript`).

The problem it solves is specific: adding an inline analytics tag to a site that
enforces a strict CSP normally forces you to allow `unsafe-inline`, which weakens
the whole policy. This module instead gives the inline bootstrap script a
per‑request nonce that matches the CSP header, so you can keep a strict policy and
still load analytics. The nonce is applied both to the inline bootstrap and to the
dynamically loaded tracking script.

It depends on **Nonce Generator** (which does the nonce/CSP work) and core's
**Path Alias** module, and you'll need a Piwik PRO account and container. The
module does **not** track anything until you configure it: you must enter your
Piwik PRO container URL and site ID and enable tracking. From the settings form
you also control the data‑layer variable name, secure/`SameSite=Strict` cookie
options, and fine‑grained visibility rules by request path, user role and content
type (admin, batch and node‑edit paths are excluded by default). Note that you
must also configure your site's CSP separately so it permits the Piwik PRO host —
this module provides the nonce, not the CSP policy itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Nonce Generator.
2. [Configuration](configuration/index.md) — enter your Piwik PRO details and tune
   the visibility, cookie and data‑layer settings.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Security → Nonce Piwik
Plugin** (`/admin/config/security/nonce-piwik-plugin`), gated by the *Administer
site configuration* permission.
