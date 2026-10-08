# Site24x7 Real User Monitoring — manual setup guide

**Site24x7 Real User Monitoring** (`site24x7`) connects your Drupal site to
[Site24x7](https://www.site24x7.com/)'s Real User Monitoring (RUM) service. It adds
the Site24x7 RUM beacon JavaScript to the `<head>` of your pages, and from then on
Site24x7 collects real front-end performance data — how quickly pages actually load
in your visitors' browsers — which you review in your Site24x7 console.

The value of RUM is that it measures the experience of real people on real devices
and networks, rather than a synthetic test. This module is the small piece that gets
the beacon onto your pages correctly: you paste in your RUM key, pick the Site24x7
datacentre your account lives in, and optionally limit which pages and which user
roles are monitored — using the same page/role visibility logic as the popular Google
Analytics module.

The module needs configuration to do anything useful: without a RUM key there is no
beacon to inject, so it prompts you to register a free Site24x7 account and add a RUM
Monitor for your site first. It has no dependencies beyond Drupal core and adds a
single `administer site24x7` permission. If you run the Content-Security-Policy (CSP)
module, the module reminds you to allow the Site24x7 datacentre host in your
`script-src-elem` directive so the beacon is not blocked.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your RUM key, choose a datacentre,
   and scope monitoring by page and role.

## Before you start

Site24x7 RUM only reports to an existing Site24x7 account. Set up a **RUM Monitor**
for your website first (Site24x7 documents this at
`https://www.site24x7.com/help/apm/rum/add-rum-monitor.html`) — that is where your RUM
key comes from.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Site24x7**
(`/admin/config/system/site24x7`, the `site24x7.admin_page` route), behind the
`administer site24x7` permission.
