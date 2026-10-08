# Contact Block — manual setup guide

**Contact Block** (`contact_block`) lets you place any of Drupal core's contact
forms into a block region, so a contact form can appear in a sidebar, footer, or
anywhere else — not only on its own `/contact` page.

Core's Contact module renders each contact form only at its dedicated URL. Contact
Block adds a configurable **"Contact block"** block plugin that embeds a chosen
contact form directly into the page through the Block layout system. When you place
the block you pick which contact form to show and which **form display** (form mode)
to render, so you can present different field arrangements of the same form in
different places.

It handles both site-wide contact forms and the **personal** contact form. The
personal form is only shown on user-context pages (such as `/user/{user}`), where
it works out the recipient from the user in the URL and reuses core's
personal-contact access check. Block access mirrors the underlying form's
permissions, and the block declares a configuration dependency on the form you
choose, so it exports cleanly. The rendered block even carries contextual links to
edit the form or manage its fields. It is a tiny module — one block plugin and a
little glue — but it makes core contact forms far more flexible for site builders.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You work with Contact Block through the **Block
layout** UI at **Structure → Block layout** (`/admin/structure/block`), where the
**Contact block** becomes available to place, and where each placed block carries
its own settings.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). You need at least
   one contact form set up under **Structure → Contact forms**.
2. Go to **Structure → Block layout**, choose a region, and click **Place block**,
   then add the **Contact block**.
3. In the block's settings, choose **which contact form** to show and **which form
   display (form mode)** to render — pick an alternate form mode for a compact
   variant if you have one.
4. Set the usual block visibility conditions (paths, content types, roles,
   languages) to decide where the form appears, then save.
5. To show the **personal** contact form, place a Contact block and select it — it
   will only render on user pages, resolving the recipient from the URL.

You can place several Contact blocks on one page for different purposes (sales,
support), and reuse a single contact form across multiple regions or themes.
