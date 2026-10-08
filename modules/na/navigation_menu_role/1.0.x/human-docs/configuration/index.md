<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

This module has no central settings page. You configure it by placing one of its menu
blocks in the Navigation sidebar and choosing options — including the roles that may
see it — on that block. Each block is configured independently, so you place as many as
you need for your different roles and menus.

## Place a block

The role-aware menu blocks are hidden from the classic Block layout page on purpose;
you place them through the **Navigation** editing interface (the left sidebar's menu
management). There you will find one block per menu on your site, under the **Menus per
role (Navigation)** category — for example a block for the *Main* menu, one for
*Admin*, *Account*, *Footer*, *Tools*, and any custom menus.

Pick the menu you want to expose, and the block's settings form appears with the
following options.

## Roles

This is the setting the module adds — a set of checkboxes listing every user role on
your site.

- **Leave all roles unticked** — the block is visible to **everyone** (this is the
  default). Use this when you simply want a menu in the Navigation with no role
  restriction.
- **Tick one or more roles** — only users who have **at least one** of the ticked
  roles will see the block. For example, tick *Content editor* to show that block's
  menu only to editors.

To grant a menu to several roles at once, tick each of them on the same block. To give
different roles different menus, place a separate block for each and tick the
appropriate role(s).

## Menu levels to display (Level)

The starting level of the menu tree (default **1**). Level 1 is the top of the menu.
Set it higher to begin the block partway down the tree — for example, start at level 2
to show only the child items beneath the top-level links.

## Number of levels to display (Depth)

How many levels of the menu to show from the starting level, from **1 to 3** (default
shows the levels up to the Navigation cap). Drupal 11's Navigation limits menu depth to
**3 levels**, so this control is capped accordingly. Use a smaller depth to keep a
block's menu shallow, or the maximum to show its full nested structure within that cap.

## Title and other standard options

The block also has the usual block **title** and **display title** options. (The
"expand all items" control that core menu blocks normally offer is intentionally removed
here, since it does not apply to the Navigation layout.)

## Save

Save the block. Its menu now appears in the Navigation sidebar for the users allowed by
its **Roles** setting. Because the configuration is stored as a standard block
(`block.block.*`) config entity, you can export it and deploy your per-role navigation
setup to other environments like any other configuration.

## Tips

- Combine several role-scoped blocks — one per role or menu — so each user sees exactly
  the navigation you intend.
- Give administrators a block with their role ticked (or an unrestricted block) so they
  always keep full Navigation access while other roles are restricted.
- Because access is decided purely by the block's role list, you do not need to touch
  global block visibility conditions or set up any permissions.
