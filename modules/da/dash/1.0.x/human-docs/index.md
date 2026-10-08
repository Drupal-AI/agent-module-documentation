# Dash — manual setup guide

**Dash** (`dash`) — "Modern Drupal Dashboard" — provides a clean, **React‑powered
administrative dashboard** for Drupal. It replaces the traditional admin landing
experience with a fast, widget‑based interface that surfaces key site metrics,
system health, and operational insights all in one place.

Each widget is clickable and opens a dedicated detail view. Out of the box it
shows: a **content overview** (total content, published vs unpublished, and a
per‑content‑type breakdown); a **users overview** (user counts per role, with a
pie chart — a user with multiple roles is counted in each); an **entity overview**
listing every content and configuration entity type with counts and direct
"Manage" links; a **modules overview** (installed modules, enabled/disabled and
core/contrib split); a **system & status** panel (Drupal core version, PHP version,
database details); and **health checks** grouping Drupal's requirement checks by
pass / warning / error.

It's an administration/UI feature that depends only on core's **System** module and
provides its own permission. Because a dashboard surfaces operational and site
data, gate that permission to trusted administrators. It supports Drupal 10.3+ and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — the dashboard works as soon as
it's enabled. Just grant the dashboard permission to the right roles.

## Where it lives in the admin menu

Once enabled, Dash provides an administrative dashboard as the admin landing
experience, gated by its own permission. Grant that permission (under **People →
Permissions**) only to trusted administrators, since the dashboard surfaces
operational and site‑wide data. Click any widget to drill into its dedicated
detail view.
