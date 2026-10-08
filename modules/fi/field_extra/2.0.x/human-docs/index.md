# Field extra — manual setup guide

**Field extra** (`field_extra`) adds **private field** functionality to Drupal.
On entity types that have an owner — nodes, media, comments, paragraphs, Group
entities, Commerce products, and so on — a content author can tick a per‑value
**Private** checkbox on selected fields. Once a value is marked private, it is
hidden from everyone except the owner and a small set of privileged users.

What makes this trustworthy is that the hiding is **enforced server‑side**, not
just in the UI. Field extra implements `hook_entity_field_access` and forbids the
*view* operation on a private value when the viewer is neither the entity's owner
nor holds a bypass permission. That means a private value disappears from
rendered pages *and* from field‑access‑aware API responses — it is genuinely
withheld, not merely styled out of the form.

Setting this up has three layers. An administrator first chooses which
owner‑bearing entity types participate, on a small site‑wide settings form. Then,
on each field's configuration form, a builder marks the field as eligible to be
made private (and can set it private by default). Finally, on the actual content
edit form, the author sees a **Private** checkbox for each eligible field and
decides per item.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which entity types
   participate, mark fields as private‑capable, and understand the permissions.

## Where it lives in the admin menu

Field extra's settings form is at **Configuration → Content authoring → Private
settings** (`/admin/config/content/private-settings`). A companion listing page at
`/admin/config/content/private-settings/fields` enumerates every field you have
configured as private‑capable. Both pages are permission‑gated. Permissions
themselves live at **People → Permissions** (filtered to this module at
`/admin/people/permissions/module/field_extra`).
