# Menu CSS Names — manual setup guide

**Menu CSS Names** (`menu_css_names`) is a very simple module that takes the link
text of each Drupal menu item and adds it as a CSS class on the menu's `<li>`
element. With those class names in place, you can style each menu item separately
in CSS — a highlighted "Sign up", a differently-coloured section link, or a CSS
sprite technique — without needing a per-item hook that core markup does not
otherwise give you.

The problem it solves is targeting. Core menu markup does not always provide a
stable, per-item class you can hang CSS on, so styling one specific link usually
means fragile `:nth-child` selectors or a theme override. Menu CSS Names gives
each item a class derived from its link text instead.

For ordinary menus (menus rendered in blocks, including primary links, and menus
enabled from a theme) the module **starts working the moment it is enabled** —
there is nothing you must configure, and it clears all caches for you at that
point. On Drupal 10/11 it also adds a small **admin settings** form that controls
whether the same class names are applied to local tasks and actions (tabs and
action links). It is a **theming convenience** with no security surface. One thing
worth knowing: because the classes derive from the link text, confirm they are
stable across content changes if your CSS depends on them — if a link's label
changes, its generated class changes too.

This is a standalone module; it depends on core's **Menu UI** (`menu_ui`) and
supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the optional settings for local
   tasks and actions.

## Where it lives in the admin menu

For regular menus the module needs no admin page — it works as soon as it is
enabled. The optional settings that control local tasks and actions live on the
module's settings form under **Configuration** (see
[Configuration](configuration/index.md)).
