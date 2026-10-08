# Adminimal Admin Toolbar — manual setup guide

**Adminimal Admin Toolbar** (`adminimal_admin_toolbar`) gives Drupal's admin
toolbar a dark, minimalist "Adminimal" look. It's a pure styling layer: it adds no
new toolbar features and no new menu items — it simply attaches its own
stylesheets to the toolbar you already have, so the whole admin toolbar picks up a
flatter, higher-contrast appearance.

Because it's a module rather than an admin theme, the restyle applies no matter
which admin theme is active, and it doesn't conflict with the toolbar the way
theme-level CSS can. The styling only loads for authenticated users who can see
the toolbar (it's gated behind core's *Access toolbar* permission), so anonymous
visitors never download it. Under the hood it ships a main restyle, an override
stylesheet that tones down core's toolbar borders and shadows, and the Open Sans
webfont, and it moves the user account tab to the right.

It builds on the contributed **Admin Toolbar** module (which in turn provides the
drop-down admin menus on top of core's Toolbar), so that is a required
dependency. Setup is essentially "enable it and you're done" — the only option is
a single checkbox to skip loading the Open Sans font, useful for languages Open
Sans supports poorly.

> **Note:** version 2.0.x is a development (`dev`) release — there is no tagged
> stable version in its info file. Bear that in mind before relying on it in
> production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it also enables Admin Toolbar and core Toolbar).
2. [Configuration](configuration/index.md) — the single "avoid Open Sans font"
   option.

## Where it lives in the admin menu

The restyle is applied automatically the moment the module is enabled — there's
nothing to switch on. Its one settings page sits at **Configuration → User
interface → Adminimal Admin Toolbar**
(`/admin/config/user-interface/adminimal_admin_toolbar`), reachable by users with
core's *Administer site configuration* permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)). The
   dark Adminimal toolbar styling takes effect right away for anyone who can see
   the admin toolbar.
2. If your site's language doesn't render well in Open Sans, open the settings
   page and tick **Avoid loading Open Sans font** — see
   [Configuration](configuration/index.md).

To customize the look further, you can load your own CSS after the module's
stylesheets from a custom theme or module; all of the module's selectors are
scoped under an `.adminimal-admin-toolbar` body class.
