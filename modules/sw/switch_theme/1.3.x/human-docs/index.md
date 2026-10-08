# Switch Theme — manual setup guide

**Switch Theme** (`switch_theme`) is a theme negotiator: it decides which
front-end theme a visitor sees based on their **user role** and, optionally, the
**URL** they are on. Instead of every visitor getting the site's single default
theme, you can hand a particular role a different look — and you can even limit
that to specific paths using a regular-expression pattern.

A common use is giving authenticated users a distinct theme on certain pages.
For example, an authenticated user visiting `/account` could be shown a
dedicated theme, configured as a rule of *Role → URI pattern → Theme* (such as
role *Authenticated*, pattern `#^/account$#`, and the theme you want active
there). You build up one or more of these rules and Switch Theme applies the
first one that matches the current user and page.

It is important to understand what this module is and is not. It controls
**presentation only** — which theme renders — and it is **not an access-control
boundary**. Changing a visitor's theme does not restrict what content or
capabilities they have, so never rely on a theme to hide sensitive data; use
Drupal's normal permissions and access controls for that. Switch Theme depends
only on Drupal core (no other modules) and works on Drupal 9, 10, and 11.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build the role-and-URL rules that
   decide which theme each visitor sees.

## Where it lives in the admin menu

Switch Theme adds a settings form where you define the role-to-theme mapping.
These docs don't record its exact menu path, so once the module is enabled look
for **Switch Theme** under the **Configuration** section of the admin menu, or
use the module's **Configure** link on the **Extend** page (`/admin/modules`).
Until you add at least one rule, the module does nothing and every visitor keeps
the site's default theme.
