# Group Content Default Menu — manual setup guide

**Group Content Default Menu** (`group_content_default_menu`) lets you define the
**default menu links** that are added to a group's menu when a new group is
created, for any group type. It builds on the
[Group](https://www.drupal.org/project/group) module and the
[Group Content Menu](https://www.drupal.org/project/group_content_menu) module, so
that new groups start with a working, consistent menu structure instead of an
empty one that each group owner has to build by hand.

You configure a set of default links per group type. When someone then creates a
group of that type, its menu is auto‑populated with those links. Changing the
defaults later affects **only newly created groups** — existing groups keep the
menus they already have.

This is a convenience layer on top of Group Content Menu; menu management and
group access continue to follow Group and Group Content Menu. Administration of the
defaults is gated by the module's own **Administer group content default menu**
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group and Group Content Menu.

There is **no standalone settings form** for this module (`configure` is null).
You set the default links per group type through the Group Content Default Menu
plugin on each group type's Content tab, described under "How to use it" below.

## Where it lives in the admin menu

Setup happens per group type, on the group type's **Content** tab under Group's
administration (**Groups → *(group type)* → Set available content**). Grant the
**Administer group content default menu** permission at **People → Permissions**.

## How to use it

1. Open the page for the **group type** whose default menu you want to define and
   go to its **Content** tab (or choose *Set available content* for that group
   type).
2. Install **exactly one** Group Content Menu plugin for the group type, and tick
   the option to **automatically create a menu when a group is created**.
3. Install the **Group Content Default Menu** plugin for the group type.
4. On that plugin's configuration page, set the **default links** to use for this
   group type's menus, then finish installing the plugin.
5. Create a new group of this type — its menu is auto‑populated with the default
   links you configured.

To change the defaults later, **Customize** the plugin on the group type's Content
tab. Remember that changes apply only to groups created afterwards, not to existing
groups.
