# New Fangled Insight Engine — manual setup guide

**New Fangled Insight Engine** (`nf_insight_engine`) connects your Drupal site to
the **New Fangled Insight Engine** analytics service (from Four Kitchens), sending
usage and content data so you can surface insights about how your site is used. It
is an analytics/tracking integration rather than an on‑site feature — its job is to
report activity to the Insight Engine.

Out of the box it can track **page hits**, register **content creation and updates**
with the Insight Engine, and — when you use **Webform** — track form submissions as
**conversions**. Entity‑reference fields (for example taxonomy terms on your
content) are reported to the Insight Engine as "terms", so your analytics can be
sliced by those relationships. You point it at either the Insight Engine **Sandbox**
or **Production** environment, and there is a **Debug mode** for troubleshooting the
integration.

The only setup is authentication and a couple of options: you generate a **token**
in the Insight Engine, then enter it (along with your chosen environment) on the
module's settings form. Because that token authenticates your site to the service,
store it as a secret — see [Configuration](configuration/index.md). Bear in mind
that this module **sends site/usage data to an external service**, which may include
personal data, so disclose it in your privacy policy as appropriate. It works on
Drupal 9.4 through 11 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — generate and enter your Insight Engine
   token, choose the environment, and store the secret safely.

## How to use it

After you enter a valid token and select an environment (see
[Configuration](configuration/index.md)), the module tracks activity
automatically — page hits, content changes, and (if Webform is present) form
conversions are reported to the Insight Engine. Review your data in the Insight
Engine's own dashboard.
