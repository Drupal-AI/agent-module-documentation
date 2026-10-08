# Content Access Simple — manual setup guide

**Content Access Simple** (`content_access_simple`) gives content editors a **compact
list of roles for setting per‑node view access, right on the node edit form**. It's a
thin, friendlier front‑end over the
[Content Access](https://www.drupal.org/project/content_access) module, which it
requires and which does the actual enforcement.

The problem it solves is usability. Content Access's own per‑node form is a full
screen of grant/view/update/delete checkboxes — powerful, but overwhelming for a
content editor who only needs to answer one question: *which roles can view this
page?* Content Access Simple exposes only the **"view"** operation, as an "Access and
Permissions" section on the node form, showing a short checklist of roles. When the
editor saves, the module re‑uses Content Access's own APIs to write real node access
grants and clears the caches — so it never bypasses access control, it's purely a
simpler UI over Content Access's enforcement.

It appears only when two conditions are met: the content type has **"Per content node
access control settings"** turned on in Content Access, and the current user holds
the **`access content access simple`** permission. The role list can be trimmed and
locked down through configuration — by default anonymous, authenticated, and
administrator are hidden from the editable list. If a node's per‑node settings have
diverged from the content‑type defaults in a way this simple form can't safely
represent, the module marks the node **"complex"** and sends the editor to the full
Content Access form instead. This project is *not* covered by Drupal's security
advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Content Access.
2. [Configuration](configuration/index.md) — enable the widget on a content type,
   grant the permission, place the form section, and tune the role list.

## Where it lives in the admin menu

There's no central settings page. You switch the widget on **per content type** at
**Structure → Content types → *(type)* → Manage access**
(`/admin/structure/types/manage/{type}/access`), position it via **Manage form
display**, and grant its permission at **People → Permissions**. The widget itself
appears on the **node edit form** as an "Access and Permissions" section.
