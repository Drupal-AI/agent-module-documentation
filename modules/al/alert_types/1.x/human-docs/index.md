# Alert Types — manual setup guide

**Alert Types** (`alert_types`) lets you define different *types* of alert using
Drupal's bundle system, create prioritized alert entities, and display the
active ones anywhere on your site through an AJAX-loaded block.

Each alert **type** is a fieldable bundle (a config entity), so you can add your
own fields to extend what an alert carries. Each **alert** is a revisionable
content entity with visibility rules — you can restrict it to specific paths,
content bundles, or roles — and optional dismissal, either by the user (remembered
in a cookie) or on a timer. Alerts are ordered by drag-and-drop weight, which
sets their priority.

Display is deliberately done over AJAX. The Alerts block asks a JSON endpoint
(`/alerts/json`) for the rendered markup of all active, published,
access-checked alerts, and the front-end JavaScript injects them. That means
banners honour cache contexts and per-path visibility instead of being baked
into a cached page. Behavior plugins (it ships **Dismissable** and **Dismiss
Timer**) plus a JavaScript plugin API let developers customise how alerts look
and behave.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create an alert type, place the
   block, add alerts, set priority, and grant permissions.

## Where it lives in the admin menu

- **Alert types** (the fieldable bundles) are managed under **Structure**
  (`/admin/structure`).
- **Alerts** (the content) are created and listed under **Content → Alerts**
  (`/admin/content/alerts`).
- The **Alerts block** is placed from **Structure → Block layout**.
- Permissions are on **People → Permissions**.

See [Configuration](configuration/index.md) for the full setup sequence.
