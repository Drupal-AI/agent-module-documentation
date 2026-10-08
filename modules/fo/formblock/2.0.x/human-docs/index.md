# Form block — manual setup guide

**Form block** (`formblock`) turns four everyday Drupal forms into placeable
blocks, so you can drop them into any region, Layout Builder section or Panels
pane instead of sending visitors off to a dedicated form page. The four forms are
the **node/content add form**, the **site‑wide contact form**, the **user
registration form** and the **request‑new‑password form**.

This is especially handy for page building. Want a "Submit an event" form right on
the front page instead of a link to `/node/add/event`? A lead‑capture form at the
bottom of a marketing landing page? A registration form inside a Layout Builder
layout? Form block makes each of those a block you place with the normal block UI —
no custom render‑array code required.

The module is intentionally small: it ships four block plugins and one small hook,
with **no module‑wide settings page, no permissions of its own and no Drush
commands**. All configuration happens per block instance, right in the block
placement form. Access is handled automatically and sensibly — the content form
block hides itself from users who cannot create that content type, the
registration block respects your *Who can register accounts* setting, and the
contact block honours core's contact flood limits, showing the "you cannot send
more than N messages" message instead of the form when a visitor is over the
limit.

Form block supports Drupal 10 and 11 and has no other module dependencies (though
the contact form block naturally needs core's **Contact** module, and the
password block needs core's **User** module — both are standard).

This guide is written for a **human** placing blocks through the admin UI. If you
want the terse, token‑cheap reference for an AI coding agent — including the exact
stored config keys and the block‑plugin internals — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Form block has **no settings page of its own**. You use it entirely from
**Structure → Block layout** (`/admin/structure/block`), or from the *Add block*
dialog inside Layout Builder / Panels. Its four plugins appear under the **Forms**
category in the block picker.

## How to use it

Place one of the four blocks and configure it in the block placement form:

| Block (in the *Forms* category) | What it renders | Settings you'll see |
|---|---|---|
| **Content form** | The add form for a chosen content type, ready to submit a new node | *Node type* (required), *Form mode*, and a checkbox to show the content type's submission guidelines above the form |
| **User registration form** | The account registration form | *Form mode* |
| **Site‑wide contact form** | The chosen contact form (department, sales, support…) | *Contact form* to target |
| **Request new password form** | The core "reset your password" form | none |

To place one:

1. Go to **Structure → Block layout**, choose a region and click **Place block**
   (or in Layout Builder, **Add block**).
2. Pick one of the four form blocks from the **Forms** category.
3. Fill in the block's settings. For the **Content form** block the *Node type* is
   required; the *Form mode* select lets you show a trimmed‑down public form if you
   have created a node form mode under *Structure → Display modes → Form modes*
   (a fresh site only has the `default` mode).
4. Optionally add block **visibility conditions** (pages, roles) the same way you
   would for any block, then save.

The blocks are smart about access: the **Content form** block only appears for
users who can create that content type; the **registration** block hides itself
when registration is administrators‑only (for non‑admins); and the **contact**
block requires the *Access site‑wide contact form* permission and respects contact
flood limits. None of this needs configuring — it is built into the plugins. The
exact stored configuration keys and access rules are documented in the
[`agent/`](../agent/start.md) reference.
