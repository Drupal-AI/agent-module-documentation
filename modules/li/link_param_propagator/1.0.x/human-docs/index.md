# Link Param Propagator — manual setup guide

**Link Param Propagator** (`link_param_propagator`) automatically carries query
parameters — UTM campaign tags, referral IDs, and similar tracking parameters —
across your site's links as a visitor browses, so campaign attribution survives
internal navigation and your analytics stay clean. When someone arrives on a
landing page with `?utm_source=…&utm_medium=…` in the URL, the module appends
those parameters to the links they click, keeping the data attached all the way
through to a conversion.

You manage everything from a simple configuration page with **rules**. Each rule
pairs a list of parameters to propagate with a **CSS target selector** that scopes
where it applies — for example only links inside `#main-content` or `.promo` — so
you can avoid over‑tagging the whole page. You can add as many rules as you need,
one per section or block.

The approach is deliberately non‑invasive: your stored content is never modified.
The parameters are appended **client‑side at render time** by a small JavaScript
behaviour, which means visitors must have JavaScript enabled for propagation to
happen. It needs no modules beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — create propagation rules, each with
   its parameters and target selector.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Link Param Tracking**
(`/admin/config/system/link_param_propagator`, config
`link_param_propagator.settings`).

## How to use it

1. Enable the module.
2. Go to **Configuration → System → Link Param Tracking**.
3. Add one or more rules, giving each a label, the parameters to propagate, and
   the DOM region to apply it to (see [Configuration](configuration/index.md)).
4. Save. As visitors browse, matching parameters are appended to the links inside
   your chosen regions — no content changes and no per‑link editing required.
