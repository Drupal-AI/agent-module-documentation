# Layout Builder Lock — manual setup guide

**Layout Builder Lock** (`layout_builder_lock`) lets administrators **lock
sections of a default Layout Builder layout** so that editors cannot undo the
structural decisions you have made when they override the layout for an individual
entity. With core Layout Builder, once you allow per‑entity overrides an editor can
rearrange or delete anything; this module lets you pin down the parts that should
stay put while still letting editors work on the rest.

Locking is per section and granular. For any section you can independently lock:
updating default blocks, moving default blocks, deleting default blocks,
configuring the section, adding a section before or after it, and moving blocks from
other sections into it. Editors can still add **new** blocks (which appear below the
locked default blocks and remain fully editable). As soon as any lock option is
enabled on a section, editors also cannot delete that section.

An important honesty note: these locks are **editorial guardrails, not a hard
security boundary**. They constrain the Layout Builder UI for editors who already
have layout/override access. Anyone with the "bypass" permission — or broader
layout access — is unaffected, so grant the bypass permission only to trusted
roles. It pairs well with
[Layout Builder Limit](https://www.drupal.org/project/layout_builder_limit) and
[Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)
for fuller control over what editors can build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the permissions and the per‑section
   lock options.

## Where it lives in the admin menu

- The module's permissions are set at **People → Permissions**
  (`/admin/people/permissions`).
- Lock options are set inside the Layout Builder interface, on a section's
  **Configure section** form on the *default* layout (for example **Structure →
  Content types → *(type)* → Manage display → Layout**).

## How to use it

1. At **People → Permissions**, grant the **Manage lock settings on sections**
   permission to the roles that should be allowed to lock sections.
2. On the entity's *default* layout, click **Configure section** on any section and
   toggle the operations you want to lock for editors.
3. Save. When an editor overrides that layout for an individual entity, the locked
   operations are unavailable to them.

See [Configuration](configuration/index.md) for the full list of lock options and
permissions.
