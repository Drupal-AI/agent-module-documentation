# LocalGov Editoria11y — manual setup guide

**LocalGov Editoria11y** (`localgov_editoria11y`) is a small configuration module
that sets up the [Editoria11y](https://www.drupal.org/project/editoria11y)
accessibility checker for the needs of the **LocalGov Drupal** distribution (the
shared Drupal platform used by UK councils). Editoria11y is an in‑page checker that
flags accessibility issues to editors as they work; this module simply
pre‑configures it so it behaves appropriately on a LocalGov site out of the box.

Currently that configuration amounts to adjusting **who can see the checker**: it
removes Editoria11y's permissions from all roles and grants them to only the
**LocalGov Editor** role, so the checker appears for the people expected to act on
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Editoria11y comes with it).

This module has **no settings form of its own** — it only applies configuration to
Editoria11y. Any further tuning is done on Editoria11y's own settings, and roles
are managed under **People → Permissions**.

## Where it lives in the admin menu

LocalGov Editoria11y adds no admin page. The accessibility checker itself, and its
detailed settings, belong to the Editoria11y module; this module only sets which
role (LocalGov Editor) has the Editoria11y permissions. You can review or adjust
those permissions under **People → Permissions**.

## How to use it

Enable the module and the LocalGov‑appropriate permission setup is applied
automatically: the Editoria11y checker becomes available to the **LocalGov
Editor** role and is removed from the others. Editors with that role will then see
the in‑page accessibility feedback as they create and edit content. If your site
uses different roles, adjust the Editoria11y permissions under **People →
Permissions** to match.
