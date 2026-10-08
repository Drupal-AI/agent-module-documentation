# Ridiculously Responsive Social Share Buttons — manual setup guide

**Ridiculously Responsive Social Share Buttons** (`rrssb`) adds responsive
social **share** and **follow** buttons to your Drupal site — Facebook, X/Twitter,
LinkedIn, Pinterest, email, and more. The buttons are "ridiculously responsive":
they collapse gracefully to icons on narrow screens without breaking your
layout, and the icons stay crisp because they come from a self-hosted SVG
library rather than a third-party script.

The module is built around reusable **button sets**. A button set decides which
networks appear, whether they are share buttons (share the current page) or
follow buttons (link to your own profiles), the order and labels of each button,
an optional text prefix like *Share:*, and appearance options such as size and
alignment. One set called **Default** is created for you when you install the
module, and you can add as many more as you like — for example a minimal
email‑plus‑Facebook set for one region and a full set for another.

Once you've built a set, there are three ways to show it: place it as a **block**,
add it as a **field in a View**, or attach it to a **content type** so every node
of that type gets the buttons automatically. Share URLs can use `[rrssb:*]`
tokens (url, title, image, username) so each page shares its own metadata, and
developers can add or alter buttons from a custom module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its bundled
   asset library with Composer, then enable it.

## Where it lives in the admin menu

Button sets are managed at **Configuration → Content authoring → Ridiculously
Responsive Social Sharing Buttons** (`/admin/config/content/rrssb`). Access is
gated by the module's own **Administer rrssb** permission, so you can let
specific roles manage button sets without granting them full site
configuration.

## How to use it

1. **Enable the module** (see [Installation](installation/index.md)). A
   **Default** button set is created automatically.
2. **Edit or create a button set** at `/admin/config/content/rrssb`. For each
   set you choose:
   - **Share vs. follow** — share buttons post the current page; follow buttons
     link to your own accounts (fill in the per‑button usernames).
   - **Which buttons** — enable or disable each network (email, Facebook,
     Twitter, LinkedIn, Pinterest, and others) and set their order by weight.
   - **Prefix** — optional text shown before the row, such as *Share:*.
   - **Appearance** — size, number of rows, and whether the row is right‑aligned.
3. **Show the set** in whichever way suits the page:
   - **As a block** — place the RRSSB block through **Structure → Block layout**
     and pick the button set. Use the block's visibility conditions to show it
     only on, say, full node pages.
   - **As a Views field** — add the "RRSSB buttons" field to a View to give a
     listing a share column.
   - **Per content type** — on a content type's edit form there is a **Button
     set** selector; choose a set and every node of that type renders those
     buttons automatically, with no block to place.
4. **Tokens** — button URLs support `[rrssb:url]`, `[rrssb:title]`,
   `[rrssb:image]`, and `[rrssb:username]`, filled from the current page or node,
   so Pinterest can share the node's main image and Facebook the page's title.

Button sets are configuration, so you can export them (`rrssb.button_set.*`) and
deploy them between environments. Developers can add a brand‑new network with
`hook_rrssb_buttons()`, tweak existing ones with `hook_rrssb_buttons_alter()`,
and regenerate the library's per‑button CSS with `drush rrssb:gen-css` after
changing buttons.
