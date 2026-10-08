# Group Media — manual setup guide

**Group Media** (`groupmedia`) connects Drupal's core **Media** entities to the
contrib **Group** module. With it enabled, a media item — an image, a document,
a video — can belong to a group as "group content" and be governed by that
group's access rules. This lets each group (a team, a department, a client, a
community) have its own scoped library of media that only its members can see and
manage, without duplicating the underlying media entities.

The module adds a per‑media‑type "Group media" relation plugin that you install
on a group type the same way you install Group Node or other group content. Once
installed, that media type becomes addable and creatable inside groups, and each
group gains a **Media** tab listing everything it owns, with *Relate media* and
*Create media* action links. Who can view, add, update, or delete that media is
controlled by the standard per‑group‑type permissions.

Group Media can also **track media automatically**. Each installed relation has an
"Enable media tracking" flag; when it is on, media that is referenced or embedded
by a piece of group content (an article's image field, a media embed in the body,
media inside Paragraphs) is attached to the group automatically when the content
is saved. It finds media through a pluggable "media finder" system, and it ships
bulk actions to assign or remove media from groups.

There is **no global settings form** — everything is configured per group type,
which is why this guide's configuration page focuses on the per‑group‑type
workflow rather than a single admin screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — enabling media as group content on a
   group type, turning on tracking, and setting permissions.

## Where it lives in the admin menu

Group Media adds no settings page of its own. You configure it from the Group
module's screens: **Administration → Groups → Group types**
(`/admin/group/types`), where you use each group type's **Set available content**
and **Permissions** operations. Each group then shows a **Media** tab where its
media is listed and managed.

## How to use it

Enable a media type as group content on a group type (see Configuration), grant
your group roles the relevant media permissions, and the **Media** tab appears on
every group of that type. Group members use *Relate media* to attach an existing
media item and *Create media* to make a new one inside the group. If you turn on
tracking, media referenced by the group's content is attached automatically on
save.
