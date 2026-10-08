# Block Title Class — manual setup guide

**Block Title Class** (`block_title_class`) adds a small **Title Class** selector
to every block's configuration form, letting you tag a block's title with an
`h1`–`h6` class. It's a quick way to change the visual heading level or styling of
a block title without editing theme templates for each block.

Choose a heading class (or *None*) on the block's form, and the module stores your
choice in the block's third-party settings and applies it to the title's
attributes. Themes that print `{{ title_attributes }}` on the block title element
— for example `<h2{{ title_attributes }}>{{ label }}</h2>` — will then render the
title with your chosen class. Because the value is saved as configuration, it
deploys across environments with the rest of your block config and can be reused
with the heading CSS you already have.

The module is intentionally simple: it adds no routes, permissions, or services of
its own. The selector rides on the core block configuration form, so anyone with
block-administration rights can set it, and the choices are limited to the fixed
`h1`–`h6` list (no arbitrary values). It depends only on core's Block module and
supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. The **Title Class** option appears on each
block's configuration form under **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and place or configure a block.
3. Open the **Title Class** section and choose a heading class (`h1`–`h6`), or
   *None* to clear it. Save the block.
4. For the class to appear in the markup, make sure your theme's block template
   prints `{{ title_attributes }}` on the title element. Then style the title with
   your existing heading CSS.
