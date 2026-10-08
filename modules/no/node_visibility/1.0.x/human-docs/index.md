# Node Visibility — manual setup guide

**Node Visibility** (`node_visibility`) brings Drupal's **condition plugins** — the
same kind of rules you use to show or hide a block, or in Page Manager — to **nodes**.
It lets you attach node‑based visibility conditions so you can restrict when and to
whom a node is shown, using conditions such as the core **User Role** condition (to
filter access to a node by role) or your own custom condition plugins.

The functionality is delivered as a **field** that you add to the content types where
you want it. Once the field is on a content type, you can set default condition options
for the type, and editors can configure the conditions per node. This makes it a
site‑builder tool for finer control over where and to whom content appears, driven by
the flexible condition‑plugin system. It depends only on core's **Node** module.

> This release is an early (`1.0.0-alpha1`) version. Test the behavior on your own site
> and confirm it enforces access the way you expect before relying on it as a security
> boundary for sensitive content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** — you enable the feature by adding its field to a
content type and then configuring the conditions, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types** (`/admin/structure/types`), choose a content
   type, and open **Manage fields**. Add the **Node Visibility** field to that type,
   and set any default condition options you want for the type.
3. When creating or editing a node of that type, configure the visibility conditions
   for that node (for example, restrict it to specific roles using the User Role
   condition).
4. Confirm the node is shown or hidden as intended for the relevant users.
