# Render Menu Token — manual setup guide

**Render Menu Token** (`render_menu_token`) lets you drop a **rendered menu tree
directly into content** by placing a simple token. Instead of building a block and
placing it in a region, an editor can embed navigation — a footer menu, a social
menu, an account menu — right inside a node body, a custom block, or anywhere
tokens are processed. Under the hood it registers a `menu` token whose `render`
variant outputs the menu you name.

The syntax is a token that ends in the menu's machine name, for example:

```
[menu:render:account]
[menu:render:menu-mm---social-menu]
```

To use these tokens inside CKEditor content (a node body, for instance), you also
need the **[Token Filter](https://www.drupal.org/project/token_filter)** module,
which turns tokens written in filtered text into their rendered output. Render Menu
Token itself depends on core's **Filter** and the contributed **Token** module, and
runs on Drupal 10 and 11.

A short security note: because these tokens are rendered through a text filter, the
menu-token filter should only be enabled on **trusted text formats** — formats that
editors, not anonymous users, can use. Token-rendering filters are a general
elevated-trust feature, so keep them off public/anonymous formats as a rule. The
good news is that the rendered menu still respects each link's **normal access**,
so it won't expose links a viewer isn't allowed to see. The module has no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (plus Token Filter for CKEditor use).

There is **no configuration page** — you use the token in content, as described
below.

## How to use it

1. **Find the menu's machine name.** At **Structure → Menus**
   (`/admin/structure/menu`), each menu has a machine name (for example `account`,
   `main`, or a custom one like `menu-mm---social-menu`).
2. **Place the token** where you want the menu rendered:

   ```
   [menu:render:MACHINE_NAME]
   ```

   For example `[menu:render:account]`.
3. **For CKEditor / body text**, make sure the **Token Filter** module is enabled
   and that the **Replace tokens** filter is turned on for the text format you're
   using — and that this is a trusted, editor-only format. (See
   [Installation](installation/index.md).)
4. Save the content; the token is replaced with the rendered menu tree, respecting
   each link's normal access rules.
