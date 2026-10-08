# Node Singles — manual setup guide

**Node Singles** (`node_singles`) introduces the idea of a **"single"** content
type — a content type that is meant to have exactly *one* node. It is designed for
the one‑off pages every site has: the homepage, an About Us page, a Contact page, a
Privacy Policy, and so on. These pages usually need their own unique fields and
layout, but they are not part of a repeating set of content, so modelling each as
an ordinary content type risks editors accidentally creating a second "About" page.
The concept is borrowed from Craft CMS.

When you mark a content type as a single, the module automatically creates its one
node and then prevents anyone from creating additional nodes of that type. The
single node can be edited directly, and only users with the **administer node
singles** permission can delete it — so your one‑off pages stay stable. An
overview of all singles is available at `/admin/content/singles` to any user with
the **access node singles overview** permission, giving editors a quick jump‑list
to every unique page.

It is a site‑structure feature: the single nodes are still normal, fieldable
content governed by Drupal's node access system plus the module's own permissions.
It depends only on core's **Node** module (and PHP 7.1+). Because the word
"single" can confuse non‑technical editors, the module lets you rename that
terminology throughout the UI on a small settings form (see below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Setup happens on the content‑type form (marking a type as a single) plus an
optional terminology settings form — both are covered in "How to use it" below.

## How to use it

1. **Create a single content type.** Go to **Structure → Content types → Add
   content type** (or edit an existing one). Under the **Singles** tab, tick **This
   is a content type with a single entity.** Save the type — the module immediately
   creates the one node for it, and you will not be able to add more.
2. **Edit the single's content** as you would any node; it is a normal fieldable
   node, so add whatever fields the page needs.
3. **Find all singles** at **Content → Singles** (`/admin/content/singles`) — a
   convenient overview for editors, available to anyone with the **access node
   singles overview** permission.
4. **Grant permissions** at **People → Permissions**: **administer node singles**
   controls who may delete a single, and **access node singles overview** controls
   who can see the overview page.
5. **(Optional) Rename the terminology.** If "single" is unclear for your editors,
   visit the settings form at **Configuration → Content authoring → Node Singles**
   (`/admin/config/content/node-singles`) to change the wording used throughout the
   interface.
