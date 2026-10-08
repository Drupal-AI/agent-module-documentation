# CKEditor5 Line Height — manual setup guide

**CKEditor5 Line Height** (`ckeditor5_line_height`) adds a **Line Height** dropdown
button to the CKEditor 5 toolbar. With it, content authors can loosen or tighten the
line spacing (the CSS `line-height`) of selected text or blocks straight from the
editor — no custom CSS and no leaving the content form. The list of spacing values
on offer is configurable, and you can set a different list for each text format.

The module ships a single CKEditor 5 plugin and nothing else — no settings page of
its own, no permissions, and no Drush commands. You configure it entirely through
Drupal's normal text-format and editor UI: drag the **Line Height** button into a
CKEditor 5 toolbar, and a small settings box appears where you type the allowed
values as a space-separated list. The default list runs from `0` up to `6.5` in
half steps.

Because line-height values are applied as inline styles, make sure the text format
you add the button to doesn't strip the `style` attribute — otherwise the spacing
won't survive filtering. The chosen options are saved as part of the editor
configuration for that format, so they export and deploy with the rest of your
site's configuration.

This guide is written for a **human** setting the button up in the editor UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is **no module settings page**. Everything happens on the text-format editor
screen: **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), where you edit a format that uses CKEditor 5.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format whose text editor is
   **CKEditor 5** (for example *Full HTML*).
2. In the **Toolbar configuration**, drag the **Line Height** button from *Available
   buttons* up into the *Active toolbar*.
3. A vertical tab called **Line Height Options** appears under the CKEditor 5 plugin
   settings. Enter the values you want to offer as a space-separated list, for
   example `1 1.5 2`. Leaving the box empty restores the module's default list
   (`0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5`).
4. Make sure the format's filters allow the inline `style` attribute the button
   writes — if you use *Limit allowed HTML tags*, ensure `style` is permitted where
   you need it.
5. **Save** the format.

A few things worth knowing:

- On save, any value of **10 or more is dropped**, and duplicate values are removed
  automatically.
- The values are unitless multipliers (e.g. `1.5` means 1.5× the font size), so they
  scale nicely with text size.
- To **remove** the button from a format, just drag it out of the active toolbar and
  save.
- You can give each text format its **own** list of values — for example a tight set
  on a body-copy format and a fuller set on a landing-page format.

Once the button is on the toolbar, authors select text (or a block) and pick a value
from the **Line Height** dropdown to apply the spacing.
