# Symbol Slider — manual setup guide

**Symbol Slider** (`symbol_slider`) lets you build sliders made of symbols or
icons — think a scrolling row of partner logos, feature icons, or any small
repeating set of images — and manage each one as its own content entity. You
create a slider, choose its slider type, add the symbols and images, and then
place the slider on your site as a block wherever you want it to appear.

Because each slider is a proper entity, Symbol Slider ships its own set of CRUD
permissions (*add*, *view*, *edit*, and *delete slider entity*), so you can
decide which roles are allowed to create and manage sliders. The module depends
on two core modules, **Options** (`options`) and **User** (`user`), which Drupal
enables automatically, and it works on Drupal 9, 10, and 11.

There is no central settings form to fill in — you configure Symbol Slider by
creating slider entities and placing their blocks, which is covered under *How
to use it* below.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once the module is enabled, building and showing a slider is a short sequence in
the admin UI:

1. From the administration menu, open **Symbol Slider** and click **Add new
   symbol** (the "add slider" action).
2. Fill in the fields — a **name**, the **slider type**, and the **image(s)** —
   then click **Save**.
3. Clear the Drupal cache so the new slider's block becomes available (from the
   toolbar, or `drush cr`).
4. Go to **Structure → Block layout** (`/admin/structure/block`).
5. Find your slider's block in the list, and place it in the region where you
   want the slider to appear.

Repeat for as many sliders as you need. Which users can create, edit, or delete
these sliders is governed by the module's slider-entity permissions on the
**People → Permissions** page (`/admin/people/permissions`), so grant them only
to the roles that should manage slider content.
