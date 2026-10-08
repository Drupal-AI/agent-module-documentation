# Admin Toolbar Mediteran — manual setup guide

**Admin Toolbar Mediteran** (`admin_toolbar_mediteran`) is a visual reskin of
the admin toolbar. It does not change how the toolbar behaves — it is a layer of
CSS that restyles the existing [Admin Toolbar](https://www.drupal.org/project/admin_toolbar)
in the "Mediteran" look, giving your administration menu a distinct colour scheme
and icon set. Because it is purely stylesheets, it adds no menu items, no
settings page, no permissions, and no configuration of its own.

The styling reaches a little wider than the toolbar itself. The module ships
separate stylesheet folders for the toolbar, the shortcut bar, the user menu, and
the [Coffee](https://www.drupal.org/project/coffee) quick-search dialog — so if
you have those features installed, they pick up matching styling too. Its one
hard dependency is the base Admin Toolbar module, which must be enabled for this
skin to have anything to style.

One caveat worth knowing: the module declares a very wide core compatibility
range (`^8 || ^9 || ^10 || ^11`), which is plausible for pure CSS, but wide
compatibility is not the same as visual correctness. Drupal's admin markup
changed substantially between 8 and 11, and on a Drupal 11 site using the newer
**Navigation** module instead of the classic toolbar, this skin may be styling
markup that is no longer rendered. Check the result visually rather than assuming
it looks right.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Admin Toolbar.

## Where it lives in the admin menu

Nowhere — the module has no settings page and adds no admin menu items. It has no
UI of its own at all.

## How to use it

There is nothing to configure. Once Admin Toolbar and Admin Toolbar Mediteran are
both enabled, the new styling applies automatically to the admin toolbar for
every user who can see it. To confirm it worked, log in as an administrator and
look at the toolbar — it should show the Mediteran colours and icons rather than
the stock Admin Toolbar appearance. If you also use the shortcut bar or the Coffee
dialog, those surfaces should match. To remove the look, simply uninstall this
module; the underlying Admin Toolbar keeps working unchanged.
