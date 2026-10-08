# Prevent Extend — manual setup guide

**Prevent Extend** (`prevent_extend`) is a small security‑hardening module that
takes Drupal's module‑management UI off the table entirely. It hides the **Extend**
item from the admin toolbar and returns a **403 Access denied** for every
module install, uninstall, update, and list path — for *all* users, regardless of
role, whether they click a menu link or type the URL directly.

The reasoning is blunt: installing a module is effectively arbitrary‑code
execution. If an administrator account is ever compromised, the Extend page is one
of the fastest ways for an attacker to turn that access into running code — just
enable a malicious module through the UI. By removing the page, you shrink that
blast radius. Module changes then have to happen the way they arguably should on a
production site anyway: through code and configuration deployment.

There is nothing to configure and no per‑content permission — enabling the module
*is* the setting. It is defense‑in‑depth, not an absolute lock: anyone with file
system or deployment access can still change which modules are installed. What it
removes is the easy, in‑browser path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings. Enabling it is all
there is to it (see "How to use it" below).

## How to use it

Enable the module on the environment you want to lock down — typically
**production**. From that point:

- The **Extend** link disappears from the admin toolbar.
- Visiting any module install / uninstall / update / list path returns **403 Access
  denied**, even for administrators.

To change modules on a locked‑down site, do it through your normal deployment
workflow: adjust `composer.json`, enable or uninstall via `drush` in a controlled
environment, and deploy. If you ever need the UI back, simply uninstall Prevent
Extend.

> **Keep it as defense‑in‑depth.** This is one layer among several. It does not
> replace least‑privilege admin accounts, strong authentication, or restricting
> file/deployment access — it complements them by closing the browser‑based route
> to enabling code.
