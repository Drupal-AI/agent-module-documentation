# Marker.io — manual setup guide

**Marker.io** (`markerio`) embeds the [Marker.io](https://marker.io/) visual
feedback and bug‑reporting widget into your Drupal site. With it in place,
permitted users can report issues — complete with annotated screenshots and
browser/console context — directly from any page, without leaving the site. It's
a natural fit for QA testers on a staging site, editors flagging content
problems, or clients giving feedback during a review.

Marker.io is a SaaS product: the widget UI, screenshot capture, and issue routing
(into Jira, GitHub, and other trackers) all happen on Marker.io's side. Drupal's
job is simply to load the widget with your **project key** and, for logged‑in
users, pre‑fill the reporter's name and email from their account. Because of that,
you need a Marker.io project and an active subscription to use this module.

Two things keep it well‑behaved on a Drupal site. First, the widget is attached
through a **lazy builder**, so full‑page caching keeps working — the per‑user
widget is rendered in a cache placeholder rather than baking into the cached page.
Second, the widget only loads for users who hold the **Access markerio**
permission; anonymous or unpermitted visitors get nothing at all (no residual
markup). That means you can switch the widget on or off for a role instantly just
by granting or removing the permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your project key, set the
   options, and grant the permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Marker.io**
(`/admin/config/system/markerio`), reachable with the **Administer markerio
configuration** permission.

## How to use it

Enter your Marker.io **project key** on the settings form, then grant the
**Access markerio** permission to the roles that should see the widget (staff, QA,
or even anonymous visitors if you want open feedback). See
[Configuration](configuration/index.md) for the details.
