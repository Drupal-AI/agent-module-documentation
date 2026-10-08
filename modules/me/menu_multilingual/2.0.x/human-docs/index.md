# Menu Multilingual — manual setup guide

**Menu Multilingual** (`menu_multilingual`) helps multilingual sites show cleaner,
language-appropriate navigation. It adds two options to menu blocks that let you
**hide menu links** which either have no translated label, or point to content
that hasn't been translated into the language the visitor is currently viewing.

On a partially translated site, menus often show links that lead nowhere useful —
an item whose label is still in the source language, or a link to a node the
visitor can't read in their language. Rather than maintaining a separate menu per
language or writing custom preprocess code, you place a menu block as usual and
tick one or both of these options. The module then quietly removes the links that
don't qualify for the current language (and any children under a removed item).

The two options are **Hide menu items without translated label** and **Hide menu
items without translated content**. They apply per menu block, so you can filter
one block and leave others untouched, and if you enable both, a link must satisfy
both to appear. The options work on core's system menu blocks and on the contrib
**Menu block** module's blocks. Menu Multilingual **requires the core Menu Link
Content and Content Translation modules**, has **no admin settings page, no
permissions, and no Drush commands**, and stores its choices as third-party
settings on each block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including where the settings
are stored and the exact filtering rules — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its required dependencies.

## Where it lives in the admin menu

There is no page of its own. Menu Multilingual adds a small **Multilingual
options** section to the configuration form of each menu block, which you reach
from **Structure → Block layout** (`/admin/structure/block`) — either when placing
a menu block or by editing a block that's already placed.

## How to use it

1. Make sure your site is multilingual: multiple languages are enabled and content
   translation is set up for the entities your menus link to.
2. Go to **Structure → Block layout** and place (or edit) a menu block — for
   example your Main navigation or a footer menu.
3. In the block's configuration form, open the **Multilingual options** section
   and tick the options you want:
   - **Hide menu items without translated label** — drops any link whose menu link
     hasn't been translated into the current language. (This checkbox is only
     available when menu-link translation is enabled.)
   - **Hide menu items without translated content** — drops any link that points
     to an entity which isn't available or translated in the current language.
     (Only available when content translation is enabled for the target.)
4. Save the block.

A few rules worth knowing: enabling both options means a link needs both a
translated label and translated content to show; links to content marked "Not
applicable" (or to non-translatable entities) are always kept; links to content
marked "Not specified" are always treated as untranslated and hidden; and when an
item is hidden, its child items go with it.

**Clear caches after changes.** Menus and blocks are cached, so after adjusting a
block's options or after translating (or un-translating) menu items or content,
run `drush cr` to see the current result.
