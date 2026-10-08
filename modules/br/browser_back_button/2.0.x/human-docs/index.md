# Browser Back Button — manual setup guide

**Browser Back Button** (`browser_back_button`) adds a single, placeable **block**
that shows a clickable "Back" control on the page. When a visitor clicks it, the
module's JavaScript calls `window.history.back()` — exactly what the browser's own
Back button does — so it is an in-page, themeable Back affordance you can drop into
any region. It has no dependencies and works on Drupal 8, 9, 10, and 11.

Use it wherever a visible, styleable Back control helps: multi-step flows and
wizards, deep detail or product pages, kiosk/touch layouts, or long articles. The
label can be plain text (default "Back") or markup such as an `<img>` icon, and you
set it per block placement.

This guide is written for a **human** using the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.

## Where it lives in the admin menu

The module adds no permissions and no top-level admin section of its own. Everything
is configured through **Block layout** (Structure → Block layout): place the
"Browser Back Button Block" in a region and use **Configure block** to set its text
or image.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`) and place the
   **"Browser Back Button Block"** in the region where you want the Back control.
3. In **Configure block**, set **Back Button Text or Image** — plain text (default
   "Back") or markup such as an `<img>` for an icon — and save.
4. Optionally use the block's standard **visibility** settings to show it only on the
   pages that need a Back control.

> Note: the project description mentions a "page reload option", but the shipped
> 2.0.2 release only navigates back (`window.history.back()`) and does not force a
> page reload.
