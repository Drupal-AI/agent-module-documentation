# Base Field Display Configurability Override — manual setup guide

**Base Field Display Configurability Override** (`base_field_display_override`)
makes an entity type's **base fields** configurable in the **Field UI** — both
their display and their form widgets — even when the entity type never declared
them as display-configurable in the first place. Base fields like the title,
author and dates are often locked out of the UI by the entity type's own
definition; this module overrides that so site builders can reach them.

With it enabled, you can reorder, hide or restyle those base fields, and adjust
their form widgets, through the normal Field UI screens instead of writing custom
code. It works across entity types and is aimed at site builders and developers
who want UI control over fields core would otherwise keep out of reach.

It is a site-builder/developer tool that changes what appears in the Field UI. It
has no content-access role of its own, and it runs on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives / how to use it

There is no settings page of its own — the effect shows up inside the standard
Field UI:

- **Structure → … → Manage display** now lists base fields (title, author, dates,
  and so on) so you can order, format, or hide them per view mode.
- **Structure → … → Manage form display** lets you configure the base fields'
  form widgets the same way.

Arrange and format them like any other field row and save. This gives you
UI-level control over base fields that core would normally keep out of the
Field UI, with no custom display code required.

> **Related module.** `base_field_display` covers the display side for nodes'
> base fields; this module goes further — overriding the entity type's
> declaration for both display and form, across entity types.
