# Configuration — global settings and adding a class

The **Settings** tab controls how the class field behaves on every block across
your site. You can usually leave the defaults in place, but it is worth
understanding each option before you start styling blocks. After the settings
walk-through, this page explains how the class field shows up when you edit an
actual block.

## Open the Settings tab

1. Go to **Configuration → Content authoring → Block Class**
   (`/admin/config/content/block-class/settings`).
2. The **Settings** tab is selected by default. The options are grouped under
   **Global Settings**, which contains a **General** section and a **Class**
   section.

![The Block Class Settings page](../images/settings.png)

## General options

- **Enable autocomplete** — when checked, the CSS class and attribute fields on
  block forms suggest classes and values you have already used elsewhere, so your
  naming stays consistent across the site. On by default.
- **Enable special characters** — when checked, special characters are allowed in
  class names. When unchecked (the default), only letters, numbers, hyphens, and
  underscores are permitted.
- **Default Case** — controls how the case of entered identifiers is handled when
  they are saved. Choose from:
  - **Uppercase and Lowercase (Default)** — both cases are accepted as typed.
  - **Uppercase** — all values are saved in uppercase.
  - **Lowercase** — all values are saved in lowercase.

## Class options

- **Field Type** — whether the block form offers a **Single textfield** (one box
  where you type a space-separated list of classes) or **Multiple textfields**
  (a separate box per class). The default is **Multiple textfields**.
- **Quantity of classes per block** — the maximum number of classes an editor may
  add to a single block. Defaults to `10`.
- **Maxlength** — the maximum length (the `maxlength` value) of the CSS class
  field. Defaults to `255`.

## Save

Click **Save configuration** at the bottom of the page. Your changes apply to the
class field on every block form from that point on.

## Add a class to a block

The class field itself is not on the settings page — it is injected into each
block's own configuration form. To add a class to a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the block you want to style and open its configuration form — either click
   **Configure** on a block that is already placed, or place a new block into a
   region.
3. On the block's configuration form you will now see a **CSS class(es)** field
   (its exact appearance depends on the **Field Type** you chose above — one box,
   or several). Type the class or classes you want, for example `hero` or
   `bg-dark`.
4. Click **Save block**.

Block Class stores the class with the block's configuration and adds it to the
block's wrapper markup when the page is rendered, so your theme's CSS can target
that block by the class you entered — no template override required.
