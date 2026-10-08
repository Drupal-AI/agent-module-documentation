# Group FolderShare — manual setup guide

**Group FolderShare** (`group_foldershare`) connects the
[FolderShare](https://www.drupal.org/project/foldershare) file-management module
to the [Group](https://www.drupal.org/project/group) module. When you turn it on
for a group type, every new group of that type automatically gets its own
FolderShare folder created in the root directory — a ready-made file storage area
that belongs to the group.

The idea is to give each group (a team, a department, a project) a place to keep
files without an administrator having to create a folder by hand each time. Group
FolderShare listens for the "group created" event and does that setup for you,
tying file storage to the group's lifecycle.

Group FolderShare does not replace FolderShare's or Group's access rules — it
simply creates the folder. Who can see, upload, or manage files inside it is still
governed by the FolderShare and Group access models. Administering the module
itself is gated behind the **Administer group foldershare** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and its FolderShare/Group dependencies.

There is **no central settings form** for this module. You switch it on per group
type, as described under "How to use it" below.

## Where it lives in the admin menu

Group FolderShare adds no settings page of its own. You enable its behavior on a
**group type**, under **Groups → Group types → *(your group type)* → Content**
(the group type's *Content* / *Set available content* tab), where you install the
**Group Foldershare** content plugin.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Content** tab of the group type you want file storage for
   (**Groups → Group types → *(your group type)* → Content**).
3. **Install** the *Group Foldershare* plugin listed there.

From then on, whenever a new group of that type is created, a FolderShare folder
is automatically created in the root directory for that group. Access to the files
inside continues to follow your FolderShare and Group permission configuration.
