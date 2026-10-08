# DROWL Admin Dashboard — manual setup guide

**DROWL Admin Dashboard** (`drowl_admin_dashboard`) gives your site a central
administrative dashboard — a friendly overview and landing page for the people
who maintain the site. Instead of hunting through the admin menu, site managers
land on one screen that gathers the key entry points (content, configuration,
status) in a single place, which makes for a much better onboarding experience.

The dashboard is shown only to users who hold the **Access Admin Dashboard**
permission, so you decide who sees it. The dashboard aggregates administrative
information, but it does not grant any access of its own — each viewer still only
sees what their normal admin permissions allow. It has no other content or access
role.

A note on versions, from the module's own project page: the **2.x** line
documented here is built on `page_manager` plus Layout Builder. Later releases
moved to a simpler, more hard‑coded approach (3.x uses a Twig template plus
`twig_tweak`; 4.x uses core's new Navigation module). If you upgrade away from 2.x
later, remember to remove the page‑manager variant as part of that upgrade.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the dashboard permission.

There is **no settings form** for this module — the only thing to set up is who
may see the dashboard, covered under "Grant access" in Installation.

## Where it lives in the admin menu

Once enabled, the dashboard becomes the administrative overview screen for any
user with the **Access Admin Dashboard** permission. It adds no configuration
page of its own.
