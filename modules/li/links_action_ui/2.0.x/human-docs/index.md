# Links Action UI — manual setup guide

**Links Action UI** (`links_action_ui`) lets a site builder create Drupal **local
action links** — the "+ Add" style buttons that sit at the top of admin and
listing pages — through the admin interface, instead of hand-writing them in a
module's `*.links.action.yml` file. If you have ever wanted an "Add item" or
"Import data" button on a particular back-end page but didn't want to write and
deploy code for it, this is the module for that.

You configure each action through a simple form: the button's **text**, its
**target URL**, one or more **pages it should appear on** (so a single action can
show up on several admin routes), and a **weight** to control ordering when
buttons appear together. It validates that the routes you enter are real Drupal
routes.

Everything is stored using Drupal's **configuration entity** system, which means
your action links are exportable, version-controllable, and deployable across
environments like any other config. The module also handles the cache clearing
itself, so new or changed actions show up immediately without a manual rebuild.
It provides its own permission so you can control who is allowed to manage these
action links.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable.
2. [Configuration](configuration/index.md) — create and manage action links from
   the admin UI.

## Where it lives in the admin menu

You manage action links at **Configuration → System → Local actions**
(`/admin/config/system/local-actions`). See
[Configuration](configuration/index.md) for how to create one.
