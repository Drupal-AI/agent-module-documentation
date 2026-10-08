# Node menus multilingual — manual setup guide

**Node menus multilingual** (`node_menu_multiple`) removes two core limitations at
once: a node's built‑in menu widget only lets you add the node to **one** menu, and
that single link is not naturally language‑aware. This module lets an editor add a
node to **several menus at the same time** — for example the main menu *and* the
footer menu — and, on a multilingual site, to control which menus are offered
**per language** so translated nodes get language‑appropriate navigation links.

On the node form it adds a repeatable "Menu Form Nodes" section beneath the
standard menu settings, with AJAX **add** and **delete** buttons so an editor can
build up as many menu links for the node as needed (each with its own parent and
weight). On the content‑type form it adds a per‑type toggle to enable the feature
and a per‑language picker for which menus are available. Behind the scenes it
creates and updates the corresponding menu link entities on save, honoring the
node's current translation language.

Because it works entirely through form changes and standard entity saves — with no
custom routes or permissions of its own — access follows Drupal's normal
node‑editing and menu‑administration permissions. It depends on core's **Content
Translation**, **Menu UI**, **Node**, and **Language** modules, so it is intended
for multilingual sites that already use translation and multiple menus.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its core dependencies).

The feature is enabled and scoped per content type rather than on a central
settings page — see "How to use it" below.

## How to use it

1. Make sure your site has **multiple languages** added and **Content Translation**
   configured.
2. Create the **menus** you want to use (one per language, or shared — the menu's
   own language does not matter).
3. Edit the content type (**Structure → Content types → *(your type)* → Edit**),
   turn on the module's per‑type option, and choose which menus are **available for
   each language**. Enable translation for the content type if you have not already.
4. Now, when editing a node, use the **"Menu Form Nodes"** section to add multiple
   menu links — click **add** for another link row, set each link's menu, parent and
   weight, and **delete** any you do not need. The links are created in the node's
   current translation language.
