# Drutopia Group — manual setup guide

**Drutopia Group** (`drutopia_group`) gives a [Drutopia](https://www.drupal.org/project/drutopia)
site a ready-made **Group type**, built on the contributed
[Group](https://www.drupal.org/project/group) module, so grassroots
organisations can each have their own mini-site inside a single install. Enable
it and you get a `group` group type with fields for a postal address,
description, summary, email, phone, website and image, classified by a
`group_type` taxonomy vocabulary. Each group becomes a small hub where its
campaigns, actions and articles can be gathered together.

Because it builds on the Group module rather than a plain node type, the feature
also installs group roles (member, outsider, anonymous), a group-membership
relationship type, and Views that list groups and their memberships. It ships a
`config_perms` custom-permission entity (`administer_groups`) so you can delegate
group administration, and it augments the Drutopia `manager` role with group
permissions.

This module is a **configuration bundle** — apart from a small install hook it
contains no custom code. That install hook rebuilds Drupal's node access grants
(`node_access_rebuild()`) so that node visibility reflects group membership.
Everything else — who can do what — is enforced by the Group module's own
membership and permission system plus the `administer_groups` permission entity.
It depends on the Group, Address, Config Perms, CTools, Paragraphs, Pathauto and
Display Suite projects, and on
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md), the base
feature the whole distribution sits on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Group and
   Address dependencies with Composer, then enable it.

## Where it lives in the admin menu

Drutopia Group has no settings form of its own. Once enabled, you work with it
through Drupal's standard Group interfaces:

- **Groups** live at **Groups** (`/admin/group`) — create and manage group
  content there.
- The **group type** and its fields are at **Structure → Group types**
  (`/admin/group/types`).
- The **group-type vocabulary** used to classify groups is under **Structure →
  Taxonomy** (`/admin/structure/taxonomy`).
- The delegated **administer_groups** custom permission is managed through the
  Config Perms module.

## How to use it

After enabling, create a group (`/group/add`), fill in its address, contact
details and image, and pick a group type from the `group_type` vocabulary. Add
members through the group's membership tab, and start associating the
organisation's campaigns, actions and articles with the group so they appear on
its page. Adjust the group type's fields and displays like any other Group type
if you need to extend the model.
