# AMP Optimizer — manual setup guide

**AMP Optimizer** (`amp_optimizer`) runs Google's **AMP Toolbox Optimizer** over
your site's rendered HTML so that pages are served as server-side-optimized AMP.
AMP pages normally do a lot of work in the browser to render their components;
the optimizer does much of that work ahead of time on the server, which improves
AMP validation and makes pages load faster.

Under the hood the module hooks into Drupal's response pipeline: as a page's HTML
response is being finalized, the module hands the markup to the AMP Toolbox
transformation engine and replaces the response with the optimized output. Any
errors from the optimizer are logged to the `amp_optimizer` channel so you can
troubleshoot.

Two design choices are worth knowing. It only processes **HTML responses**, and
it only runs for **anonymous visitors** — logged-in users (editors previewing
content) get the unoptimized output, so their editing experience is unaffected.
This makes it a good fit for optimizing the cached HTML that most of your traffic
sees.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its library
   dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — the settings form for the
   optimizer.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Web services → AMP →
Optimizer** (`/admin/config/services/amp/optimizer`), gated by the
**Administer site configuration** permission.
