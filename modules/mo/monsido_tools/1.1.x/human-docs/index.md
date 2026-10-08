# Monsido Tools — manual setup guide

**Monsido Tools** (`monsido_tools`) connects a Drupal site to
**[Monsido](https://monsido.com/)** — a web-governance SaaS platform that covers
accessibility (WCAG) compliance, quality assurance, SEO, and content-policy
checks. The module embeds Monsido's tracking/agent script into your pages and
provides the configuration needed to link the site to your Monsido account, so
Monsido can crawl and analyse the site and report issues back in its own
dashboard.

Use it on sites that are monitored by Monsido and want the on-page Monsido agent
present. It has no dependencies on other modules, adds no content of its own, and
plays no access-control role — it is purely an integration/governance connector.

> **Please note:** this module is **deprecated and unsupported**. Its own project
> page states that Monsido Tools has been superseded by the **Acquia Optimize**
> module, which you should use instead on new or actively maintained sites. Treat
> this guide as reference for existing installations.

Because the module embeds a **third-party JavaScript agent**, factor in the usual
external-script considerations: privacy and cookie/consent obligations, and your
**Content Security Policy** (the Monsido domains must be allowed for the agent to
load). The agent also means Monsido crawls and analyses your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Monsido account and
   control where the agent script loads.

## Where it lives in the admin menu

Once enabled, the module's settings form lives at the route
`monsido.admin_settings` (reachable under **Configuration**). See
[Configuration](configuration/index.md).
