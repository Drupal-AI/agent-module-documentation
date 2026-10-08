# A11Y Project Checklist — manual setup guide

**A11Y Project Checklist** (`a11yproject_checklist`) gives your team a
trackable accessibility checklist inside Drupal, built from the well-known
checklist published by [The A11Y Project](https://www.a11yproject.com/). It
turns those accessibility best practices into a list of tasks you can tick off,
so a site launch or audit has a visible, shared record of what has been done and
what still needs attention.

The module supplies the checklist definition and hands the actual tracking to
the contributed **Checklist API** module, which it depends on. Checklist API is
what stores the completion state — who checked which item, and when — and renders
the save form and the percent-complete display. Each item on the list carries a
title, a description, a **WCAG reference**, and a link to the relevant handbook
page, so it doubles as a jumping-off point for remediation guidance.

One thing to be aware of: the checklist items are fetched from a remote source
(The A11Y Project) when the list is built, so the site needs a working outbound
HTTP connection to populate them. If the fetch fails it is logged and the list
renders empty; rebuilding caches re-fetches the latest tasks.

There are no custom routes, permissions, or write endpoints of its own — access
to the checklist is governed by Checklist API's own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in
   Checklist API, and enable the module.
2. [Configuration](configuration/index.md) — where the checklist lives, how to
   use it, permissions, and refreshing the item data.

## Where it lives in the admin menu

The checklist is at **Configuration → Development → A11Y Project Checklist**
(`/admin/config/development/a11y-project-checklist`). Access is controlled by
Checklist API's permission for editing the checklist.
