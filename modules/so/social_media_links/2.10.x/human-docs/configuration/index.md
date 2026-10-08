# Configuration

Social Media Links Block has no central settings page. Instead, you configure
everything on the block itself, in its block configuration form. This page walks
through placing the block and filling in each section of that form.

## Place the block

1. Log in as a user with the **Administer blocks** permission (an administrator
   by default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Find the region you want (a footer or header is typical) and click **Place
   block** next to it.
4. In the list, find **Social media links** and click **Place block**.

The block's configuration form opens. Below are its sections.

## Platforms

This is the heart of the form: **one row per social network**.

- Pick the **platform** (Facebook, X, Instagram, LinkedIn, YouTube, and around
  fifty others) from the row's selector.
- Enter **only the value** — the username, ID, or path — *not* the full URL. Each
  platform supplies its own URL prefix and suffix, so entering `acme` under
  Twitter (prefix `https://x.com/`) produces `https://x.com/acme`. This also
  covers mailto/email and RSS entries.
- **Drag the rows** to set the order the icons appear in. Each row can also
  override its description and weight.

Add a row for every network you want to show and leave the rest blank.

## Appearance

- **Icon set** — which set of icons renders your links. Bundled choices include
  **Font Awesome** (`fontawesome`), **Elegant Themes** (`elegantthemes`),
  **Nouveller** (`nouveller`), and **IcoMoon** (`icomoon`). Switching the icon
  set restyles the whole block at once.
- **Icon size / style** — the style options the chosen icon set exposes. For Font
  Awesome, for example, these include sizes like `2x` and `3x` and modifiers like
  `lg` and `fw`.
- **Orientation** — display the icons **horizontally** (typical for a footer or
  header bar) or **vertically** (typical for a sidebar).

## Link attributes

These apply to every link the block renders:

- **Target** — for example `_blank` to open social links in a new browser tab.
- **Rel** — for example `nofollow noopener` on outbound links, which is good
  practice for links you don't want to pass link equity to.
- **Extra classes** — any additional CSS classes to add to every link, for
  theming.

## Standard block settings

Because this is a normal Drupal block, the form also has the usual **Visibility**
tabs (restrict by pages, content types, roles, and so on) and a **Region**
selector. Use these to control exactly where and to whom the block appears — for
instance, showing one block on the front‑end theme and a different one on the
admin theme.

## Save

Click **Save block**. The social bar appears immediately in the region you chose.
Reload the front end to see it. To adjust it later, return to **Structure → Block
layout** and click **Configure** next to the block.

## A note on icons and theming

Font Awesome uses the module's bundled library by default, or the site‑wide
Font Awesome module if you have it enabled. Other icon sets are located
automatically in your site's libraries directory once you download them. If you
need to change the markup, the block renders through Twig templates you can
override in your theme (`templates/*.html.twig`).
