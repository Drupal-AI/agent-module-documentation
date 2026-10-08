# Administer Users by Role — manual setup guide

**Administer Users by Role** (`administerusersbyrole`) lets you hand out limited
user‑management powers to "sub‑admin" users, scoped by the *roles* of the accounts
they may touch. Core Drupal only offers an all‑or‑nothing **Administer users**
permission — grant it and someone can edit every account, including other admins.
This module replaces that with fine‑grained, per‑operation, per‑role permissions, so
you can let (say) a membership secretary edit and view ordinary members while never
being able to touch administrators or content editors.

The idea is simple. First you **classify each role** on a settings page as
**Allowed**, **Forbidden**, or **Custom**. Then you grant sub‑admins permissions for
the four operations — **edit**, **cancel**, **view**, and **assign roles** — which
apply to every account whose roles are all "Allowed". A sub‑admin can act on a target
user only if they have access to *every* role that user holds, so an account that
carries even one forbidden role is off‑limits. Roles marked **Custom** generate their
own extra per‑role permissions for finer control.

On top of the four operations there are a few standalone permissions: **create
users**, **access the users overview** (which shows the People list filtered to just
the accounts the sub‑admin can manage), and **allow empty user mail**. Role
assignment is wired into both the user edit form and the core "Add/Remove role" bulk
actions, with the role options restricted to what the sub‑admin is allowed to assign.
The super‑admin (user 1) and anonymous (user 0) are always protected, and holding
core's **Administer users** or **Administer permissions** bypasses this module
entirely — so don't give sub‑admins those.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — classify your roles, then grant the
   per‑operation and per‑role permissions to your sub‑admin roles.

## Where it lives in the admin menu

- The role‑classification settings form is at **People → Administer Users by Role**
  (`/admin/config/people/administerusersbyrole`).
- The permissions themselves are granted on the usual **People → Permissions** page.
