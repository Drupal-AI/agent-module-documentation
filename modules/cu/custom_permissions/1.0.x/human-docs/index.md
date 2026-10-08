# Custom Permissions — manual setup guide

**Custom Permissions** (`custom_permissions`) gives you a point-and-click way to
**define your own named permissions** without writing a `*.permissions.yml` file
or a custom module. It's aimed at site builders and front-end developers who need
a permission string to gate something — a View, a block, or another module's
access setting — but don't want to drop into backend code to declare it. You
create the permission through a dedicated admin page, and from then on it appears
in Drupal's normal permission system, ready to be assigned to roles.

It's important to understand what this module does and does **not** do. It only
*registers* permission definitions — the named strings themselves. It does **not**
grant those permissions to anyone. Assigning a custom permission to a role still
happens the usual way, on Drupal's core **People → Permissions** page, which is
governed by core's own *administer permissions* control. In other words, Custom
Permissions creates the switches; core decides who they're handed to.

The module supports Drupal 9, 10, and 11 and has no dependencies beyond core.
Managing the custom permissions is itself guarded by a powerful permission, so
it's meant for trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how to define custom permissions and
   understand the access model.

## Where it lives in the admin menu

Once enabled, you manage your custom permissions at **People → Custom Permissions**
(`/admin/people/custom-permissions`). See [Configuration](configuration/index.md)
for how to use it.
