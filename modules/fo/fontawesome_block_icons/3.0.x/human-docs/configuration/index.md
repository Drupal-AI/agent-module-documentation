# Configuration

Font Awesome Block Icons has **no central settings page** — you configure it on
each block individually. When you configure a block, the module adds a
**Fontawesome Block Icon** section to that block's form.

## Open a block's configuration

1. Log in as a user who can administer blocks (an administrator by default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Configure** on the block you want to give an icon.
4. Scroll to the **Fontawesome Block Icon** section of the block's configuration
   form.

## The per-block options

Within the Fontawesome Block Icon section you can set:

- **Icon** — choose which Font Awesome icon to show next to the block's title.
- **Size** — control how large the icon is rendered, so it sits well against the
  heading text.
- **Custom CSS class** — an optional class added to the icon for this block, so
  you can target it with your theme's CSS for finer control (colour, spacing, and
  so on) without editing templates.

## Save

Click **Save block**. The icon appears with the block's title immediately. Repeat
for each block you want to decorate — the settings are per block, so different
blocks can have different icons, sizes, and classes.

> **Reminder:** the icons only display if Font Awesome is loaded on your pages
> (via your theme or the Font Awesome module). If an icon does not appear after
> saving, check that the icon library is present — see
> [Installation](../installation/index.md).
