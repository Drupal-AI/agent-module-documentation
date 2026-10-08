# Entity UI Builder — manual setup guide

**Entity UI Builder** (`entity_ui`) lets you build administrative UIs — specifically
**tabs on content entities of any type** — without writing custom code. It's the
spiritual successor to Drupal 7's *Entity Operations*. Each tab you create is a
config entity that defines the tab's path component, its page title, and which
plugin supplies the tab's content. Tab content plugins can show a **view mode**, a
**form mode**, an **action form**, or in fact any kind of content, so you can
assemble bespoke management screens on top of your entities.

Access is handled per tab. Every tab has its own access permission, and those
permissions can be made granular to the bundles on the target entity and, for
entity types that support owners, to entity owners. That makes it a powerful surface
— you are exposing entity management (viewing, editing, and acting on content) — so
be deliberate about who can build these UIs and who can use each tab.

The module depends on core's **Field UI** module and provides its own permissions.
It works on Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Field UI.

Tabs are created as config entities rather than through a single global settings
form, so setup happens per tab (see *How to use it* below) and access is assigned
per tab on the permissions page.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); core Field UI is
   required and comes along as a dependency.
2. Create an **Entity UI** tab as a config entity, defining its path component,
   page title, the target entity type, and the content plugin it uses — a view
   mode, a form mode, an action form, or another content type. This is what adds
   the new tab to the target entity.
3. Assign the tab's dedicated permission on **People → Permissions**
   (`/admin/people/permissions`). Because permissions can be scoped to bundles and,
   where supported, to entity owners, grant each tab only to the roles that should
   reach it.
4. Visit an entity of the target type and confirm the new tab appears and shows the
   configured content.

Treat these UIs as a powerful administrative surface: gate both who can build them
and who can use each tab.
