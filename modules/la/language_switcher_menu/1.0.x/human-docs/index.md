# Language Switcher Menu — manual setup guide

**Language Switcher Menu** (`language_switcher_menu`) puts the language‑switch
links that Drupal core already generates directly into a menu of your choice.
Instead of placing the separate core *Language switcher* block somewhere on the
page, your visitors switch languages from an ordinary menu item — in the main
navigation, the footer, a header language selector, or any custom menu you build.

Once you point the module at a menu and pick a parent, it adds one menu link per
enabled language, sitting alongside your normal navigation. The links are smart:
they resolve the correct "switch to this language" URL for whatever page the
visitor is on, and the current language gets the standard active‑trail
highlighting. Because they are just menu items, they theme like the rest of your
menu — and if you want, you can style the language links differently by matching
their plugin id in a Twig template override.

The module reads a tiny configuration object (a language *type*, a *parent*, and a
starting *weight*) from a settings form under Regional and language. It also adds
two permissions: one that controls who may configure the feature, and one that
controls which roles actually *see* the generated links. That second permission is
important — because of a long‑standing Drupal core issue the links would otherwise
always be hidden, so the module ships a workaround that grants access based on the
**view language_switcher_menu links** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the two
   permissions, and how to theme the links.

## Where it lives in the admin menu

Its settings form is at **Configuration → Regional and language → Language
Switcher Menu** (`/admin/config/regional/language_switcher_menu`). The links it
generates appear wherever you place the target menu (for example via a menu block).

## How to use it

1. Make sure your site is multilingual (core's **Language** module enabled with two
   or more languages) — the module only produces links on a multilingual site.
2. Open the settings form and choose the **language type**, the **parent menu item**
   (or the root of a menu), and a starting **weight**.
3. Grant the **view language_switcher_menu links** permission to the roles that
   should see the links.
4. Place the target menu as a block if it isn't already shown, and the language
   links appear inside it.

The field‑by‑field walkthrough is in [Configuration](configuration/index.md).
