# Block ARIA Landmark Roles — manual setup guide

**Block ARIA Landmark Roles** (`block_aria_landmark_roles`) lets you add WAI-ARIA
landmark roles and labels to your site's blocks straight from each block's
configuration form — no template editing required. Landmark roles (like `banner`,
`navigation`, `contentinfo`, and `search`) are the signposts that screen readers
use to let people jump between the major regions of a page. Adding them is a common
accessibility (a11y) improvement and helps satisfy WCAG landmark/"bypass blocks"
techniques.

The module adds a small **Block ARIA Landmark Roles settings** section to every
block's configuration form. There you can pick a **Landmark role** and type an ARIA
**Label**, and the module renders those as `role` and `aria-label` attributes on
the block's wrapper when the page is displayed. Because the settings live on each
block placement, the same block can carry different roles in different regions or
themes, and it works on any block — core, Views, custom content, or contrib.

There is nothing to configure globally: enabling the module simply adds the extra
fields to the block forms, and you set a role on each block as needed. It depends
only on core's **Block** module, requires PHP 8.1+, and runs on Drupal 10, 11, or
12. It has no settings page, no permission of its own (editing blocks already
requires *Administer blocks*), and no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the allowed role values, the
third-party settings storage, and how the attributes are rendered — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated admin page. You set roles on individual blocks from
**Structure → Block layout** (`/admin/structure/block`) — click **Configure** on
any block and look for the **Block ARIA Landmark Roles settings** section.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click
   **Configure** on the block you want to mark up.
2. Open the **Block ARIA Landmark Roles settings** section (it is expanded by
   default).
3. Choose a **Landmark role**. The options are the eight WAI-ARIA landmark roles —
   `application`, `banner`, `complementary`, `contentinfo`, `form`, `main`,
   `navigation`, `search` — plus **- None -** (which adds no role attribute).
4. Optionally type a **Label**. When set, it becomes the block's `aria-label`,
   regardless of the role. This is handy for telling two similar landmarks apart —
   for example labeling one navigation block "Main menu" and another "Footer menu".
5. Click **Save block**.

Some common choices: mark the site branding/header block as `banner`, the main
menu as `navigation` (labeled "Main menu"), the footer as `contentinfo`, a sidebar
"Related content" block as `complementary`, and the search block as `search`. The
role and label are the two settings, and they are independent — you can set just a
label without a role. To remove a role later, pick **- None -** and save.

Because the settings are stored with the block's own configuration, they export and
deploy with your site config like any other block setting.
