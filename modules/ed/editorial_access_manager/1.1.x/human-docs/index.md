# Editorial access manager — manual setup guide

**Editorial access manager** (`editorial_access_manager`) lets you grant a
**specific user** the right to edit or translate a **specific content item** —
optionally in a **specific language** — instead of the all-or-nothing, per-bundle
permissions Drupal gives you out of the box.

The problem it solves is a common editorial one. Core's permissions are per
bundle: a role can edit *all* articles or *none*. But real editorial life is
per item — this page belongs to the finance team, that one to a named author, this
particular translation is assigned to a particular translator. The usual
work-arounds are heavyweight (the Group module, with its membership model) or
coarse (a separate role for every team). This module takes a lighter approach: on
each supported content item, users you have authorised see a **Manage editorial
access** tab where they assign which users may edit the item, per language.
Assigned editors then get a **Content → Assigned Content** page listing exactly
what has been delegated to them, from which they can edit it and create or edit
translations.

A distinctive detail is that assignments carry a **language code**, so a
translation can be assigned independently of its source — you can hand one
language of a page to a translator without granting them the original. There is
also a **reassignment** form for the handover case: when someone leaves, an
administrator can transfer all of their assignments to another user in one step.
Notably, assigned editors do **not** need any of core's normal create/edit/
translate permissions — the assignment itself is what grants their access. It
depends on core's **Node** and **Content translation** modules.

Because this is an access-control module, verify its effect not only on the entity
edit form but also in **Views, JSON:API, and search**, which is where per-item
access rules most often fail to apply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Node / Content translation dependencies.
2. [Configuration](configuration/index.md) — choose which entity types and bundles
   use the feature, assign the permissions, and use the assignment and
   reassignment tools.

## Where it lives in the admin menu

The main settings form is at **Configuration → Content authoring → Editorial
access manager** (`/admin/config/content/editorial-access-manager`), where you
choose which content entity types support the feature. The reassignment form is at
**Content → Reassign** (`/admin/content/reassign`), and assigned editors find
their work under **Content → Assigned Content**.
