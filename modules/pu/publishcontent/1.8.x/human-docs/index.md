# Publish Content — manual setup guide

**Publish Content** (`publishcontent`) is a lightweight editorial helper that
lets you grant publishing rights on Drupal nodes *without* handing out the broad,
dangerous "Administer nodes" permission. It adds fine‑grained, per‑content‑type,
per‑role permissions for publishing and unpublishing, plus a one‑click
**Publish / Unpublish** tab beside a node's View and Edit tabs, an optional
checkbox on the node edit form, and a toggle‑link field for Views.

Instead of all‑or‑nothing, you get precise control: five global permissions
(publish/unpublish any content, publish/unpublish content the user can already
edit, and access to the settings form) and — generated automatically for every
content type — six more per role (publish/unpublish for *any*, *own*, or
*editable* nodes of that bundle). So you can let a reviewer publish anything, let
authors retract only their own articles, or separate "can edit" from "can
publish" for an approval workflow. New content types get their permissions
automatically.

A settings form lets you turn the tab and/or the edit‑form checkbox on or off,
decide whether toggling creates a new revision or writes a log entry, and
customise the button and status labels (say, "Go live" / "Retract"). Toggling
also fires events other code can react to. The module applies to **nodes only**
and requires just core's **Node** module — no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the access
service, toggle routes, events, and hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form (tab, checkbox,
   revisioning, logging, labels) and how to grant the publishing permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Workflow → Publish content**
(`/admin/config/workflow/publishcontent`). The permissions are managed at
**People → Permissions**
(`/admin/people/permissions/module/publishcontent`). The one‑click tab appears on
individual node pages.

## How to use it

Enable the module, grant the relevant publish/unpublish permissions to your
editorial roles, and (optionally) adjust the settings form to control the tab,
checkbox, revisioning, logging, and labels — see
[Configuration](configuration/index.md).
