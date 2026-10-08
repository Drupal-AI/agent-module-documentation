# Dashboard — manual setup guide

**Dashboard** (`dashboard`) lets you build custom admin dashboards — landing pages
made of blocks — and show the right one to each user. It is the maintained contrib
successor to the Dashboard module that used to ship with Drupal core (and was
removed), rebuilt for Drupal 11 on top of Layout Builder.

Each dashboard is a configuration entity whose layout you assemble visually with
Layout Builder: add one‑column or two‑column sections and drop blocks into them.
You can use the module's own **Dashboard Text** (a formatted welcome/instructions
block), **Site Status** (a summary of the core status report), **Navigation
Dashboard** and **Placeholder** blocks, as well as any Views block, the core
Shortcuts block, or any other core/contrib block. The result is an at‑a‑glance
home screen for your staff — recent content lists, status information, quick links
and custom text, arranged however you like.

The clever part is how the right dashboard reaches the right person. Access to each
dashboard is controlled by its own permission, so you grant each role the
dashboard(s) it should see; and right after login users are automatically
redirected to their default dashboard when they have access to one. That
effectively makes a per‑role dashboard the landing page for your editors,
administrators or other staff. When a user can see more than one, a weight setting
decides which is the default.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its core dependencies.
2. [Configuration](configuration/index.md) — creating dashboards, building their
   layouts, and setting per‑role access and the login landing behaviour.

## Where it lives in the admin menu

Dashboards are managed at **Structure → Dashboard**
(`/admin/structure/dashboard`). The user‑facing dashboard is at **/admin/dashboard**
(a specific one at `/admin/dashboard/{id}`), and that is where users land after
logging in when they have access to one.

## How to use it

1. Enable the module and grant the *Administer dashboard* permission to whoever
   builds dashboards (see [Installation](installation/index.md)).
2. At **Structure → Dashboard**, add a dashboard, then use **Edit layout** to build
   it from blocks.
3. Grant each role the "Access to … dashboard" permission for the dashboard it
   should see, and set weights to decide the default.
4. Users are redirected to their dashboard on their next login.
