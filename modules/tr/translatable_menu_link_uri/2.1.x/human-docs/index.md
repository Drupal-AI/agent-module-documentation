# Translatable Menu Link Uri — manual setup guide

**Translatable Menu Link Uri** (`translatable_menu_link_uri`) lets a single menu
link point at a different URL in each language. Out of the box, Drupal can translate
a custom menu link's *title* but not its *destination* — every translation shares the
same link URL. This module fixes that for **external, off‑site links**, so, for
example, one "Buy now" or "Contact" menu item can send English visitors to one URL
and French visitors to another.

It works by adding a second link field to custom menu links called **Translatable
External Link Override**. When you edit a menu link in the site's default language,
you set the normal **Link** field as usual. When you edit a *translation* of that
link, the normal Link field is hidden and the override field appears instead — so
each language gets its own destination. At render time, whenever a menu is displayed
in a given language, the module swaps in that language's override URL. If a
translation leaves the override empty, the link simply falls back to the original.

The override is meant for external URLs only — the field itself warns against using
it for internal Drupal links. If you have the [Token](https://www.drupal.org/project/token)
module enabled, override URLs are run through token replacement, which is handy for
adding localized campaign parameters. The module also cooperates with the
[Menu Item Extras](https://www.drupal.org/project/menu_item_extras) module so
overrides apply to nested child links too.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it pulls in core's Menu link content and Content translation).

There is no settings page; the whole workflow of enabling translation and editing
per‑language links is in *How to use it* below.

## Where it lives in the admin menu

This module has **no admin settings form**. You work with it in Drupal's existing
screens:

- **Configuration → Regional and language → Content language and translation**
  (`/admin/config/regional/content-language`) — to turn on translation for menu
  links.
- **Structure → Menus** (`/admin/structure/menu`) — to edit menu links and their
  translations.

## How to use it

**1. Make sure the site is multilingual.** You need core's **Language** module and a
second language added under **Configuration → Regional and language → Languages**,
plus **Content translation** (which this module pulls in as a dependency).

**2. Turn on translation for menu links.** Go to **Configuration → Regional and
language → Content language and translation**, and enable translation for **Custom
menu link** (`menu_link_content`). If the **Translatable External Link Override**
field is listed there, make sure it is marked translatable.

**3. Set the default‑language destination.** Edit a menu link in the site's default
language at **Structure → Menus → (your menu) → Edit link**. Fill in the normal
**Link** field — on the default‑language form, only this field is visible.

**4. Give each translation its own URL.** Use the **Translate** tab on that menu
link to add or edit a translation. On the translation form the core Link field is
hidden and the **Translatable External Link Override** field appears — enter the
language‑specific external URL there and save.

When the menu is rendered in that language, visitors follow the override URL; other
languages keep their own overrides or fall back to the default link. No settings page
or custom code is involved.
