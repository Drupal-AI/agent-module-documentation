# Configuration

There is no global settings page. You configure this module by **placing its
block in place of the core menu block** and, optionally, choosing which link types
get language-filtered.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`) and pick the
   region where the menu should appear.
2. Click **Place block** and choose the entry for the menu you want, under the
   category **"Menu block current language"** (there's one per menu — main menu,
   footer, account, or any custom menu).
3. Configure the settings below, place it in the region, and **Save**.
4. **Remove the core menu block for the same menu** if one is placed in that
   region — you don't want both the core block and this one rendering the same
   menu.

## Block settings

The block inherits all the normal core menu-block settings — **Initial menu
level**, **Number of levels to display** (depth), and **Expand all menu links** —
and adds one setting specific to this module:

- **Translation providers** — a set of checkboxes choosing which *kinds* of menu
  link are subject to language filtering. A provider you **uncheck is skipped**,
  meaning its links are never hidden regardless of translation status. The options:
  - **Custom menu links** (`menu_link_content`) — links created as menu-link
    content entities. **On by default.**
  - **Views** — menu links provided by Views. **On by default.**
  - **Default** (string translation) — string-translated titles of default menu
    links. **Experimental, off by default.**

For most multilingual sites the defaults (custom + Views) are what you want: your
hand-made menu links and Views links get filtered, while core/default links stay
put.

## What to expect at render time

When the block builds its menu tree, it runs the normal core access and sorting,
then filters out links that have **no translation for the current content
language** — but only for the providers you enabled. Detection is per link type:

- **Custom menu links** are hidden if the underlying entity has no translation in
  the current language (non-translatable entities always stay visible).
- **Views menu links** are hidden if the view has no language configuration for the
  current language.
- **String-translated default links** (when the experimental *Default* provider is
  on) are looked up in the locale string storage; the source language always
  passes.
- Anything the module doesn't recognise stays visible.

The result is a menu that tracks the resolved content language: switch language and
each menu shows only that language's translated items. Because it reuses the
`block__system_menu_block` template suggestion, your existing menu-block Twig
templates keep working.

## Extending the decision (developers)

If you need to force a particular link visible or hidden — for example links pulled
from an external source — you can subscribe to the module's
`HasTranslationEvent`, or implement `MenuLinkTranslatableInterface` on a custom
menu-link plugin. See the sibling [`agent/`](../../agent/start.md) docs for code
examples.
