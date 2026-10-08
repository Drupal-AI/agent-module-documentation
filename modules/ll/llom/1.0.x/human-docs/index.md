# Language Links On Menu — manual setup guide

**Language Links On Menu** (`llom`) is a language switcher you place **as a menu
item** rather than as a block. Most language switchers render a standalone block;
this module instead builds the switcher into one or more of your existing menus
(main menu, footer, and so on), so language switching becomes part of normal site
navigation.

It renders the switcher as a small menu tree: the current language is the parent
item and the other languages are its children. If only two languages are active,
it simplifies to a single item showing the alternative language to switch to, with
no children. Because it uses the ordinary menu system, everything the menu and
theme already offer applies — Menu UI positioning, hooks, CSS classes, and theming
all work, and the module adds its own menu/language classes so you can style the
switcher precisely.

The module depends only on Drupal core's **Language** and **Menu UI** modules. It
is a multilingual navigation feature: it reflects the languages you have already
configured and plays no access-control role. It can also add flag icons next to
(or instead of) the language text — but note the module does **not** validate that
the flag image files exist, are named correctly, or are sized properly; supplying
and maintaining those flag files in the site's `public://` folder is your
responsibility.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form: which menus to
   use, language type, weight, label format, and flags.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → Language
Links On Menu** (`/admin/config/regional/llom`).

## Before you configure it

Two prerequisites must be in place first:

1. **At least two languages** configured at
   `/admin/config/regional/language`.
2. The **URL** language detection method enabled and given priority over other
   methods under *Interface text language detection* and/or *Content language
   detection* at `/admin/config/regional/language/detection`.

After you have configured the module, you can use **Menu UI** to fine‑tune where
the switcher sits in each menu — almost all of the module's UI settings are
preserved. One caution: if you have manually positioned the switcher in a menu
via Menu UI and later want to remove it, do a **menu reset** from Menu UI *before*
un-selecting that menu in the module configuration, otherwise the switcher may
keep appearing. Whenever a language is added or removed, the module rebuilds all
menus.
