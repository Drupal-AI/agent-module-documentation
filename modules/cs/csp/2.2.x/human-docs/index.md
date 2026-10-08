# Content Security Policy — manual setup guide

**Content Security Policy** (`csp`) builds and emits `Content-Security-Policy`
(and `Content-Security-Policy-Report-Only`) HTTP response headers for your Drupal
site, hardening it against cross-site scripting and data-injection attacks without
hand-editing headers.

A Content Security Policy works by telling the browser to load scripts, styles,
images, frames, and other resources only from origins the policy explicitly
allows. This module gives site builders a settings form to configure two
independent policies — a lenient **Report-Only** policy for testing and a stricter
**Enforce** policy — each with per-directive source lists (`script-src`,
`style-src`, `img-src`, `frame-ancestors`, and many more). It automatically
discovers the external hosts that Drupal's asset libraries need and adds them to
the right directives, so most core and contrib assets keep working out of the box.

It can emit cryptographic **nonces** and **hashes** so inline scripts and styles
are allowed without resorting to `unsafe-inline`, supports **Trusted Types** and
`upgrade-insecure-requests`, and offers pluggable **reporting handlers** (none, a
custom report URI, or the report-uri.com service) to collect violation reports.
Developers can adjust a policy at runtime through an event, and everything is
stored as standard Drupal configuration, so it exports and deploys across
environments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional extras submodule.
2. [Configuration](configuration/index.md) — the two policies, their directives,
   nonces and hashes, reporting handlers, and the recommended report-then-enforce
   workflow.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Content Security Policy**
(`/admin/config/system/csp`) and is gated by the **Administer CSP configuration**
permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form and start with the **Report-Only** policy so nothing is
   blocked yet — you are just collecting information.
3. Add a reporting handler and browse your site (and its admin pages) to gather
   violation reports, then relax the directives until legitimate resources stop
   being flagged.
4. When the policy is clean, enable the **Enforce** policy with the same directives
   so the browser actually blocks disallowed resources. See
   [Configuration](configuration/index.md) for the details.
