# Menu Normalizer — manual setup guide

**Menu Normalizer** (`menu_normalizer`) is a small developer-facing module that
fills a gap in Drupal core: it provides the Serializer **normalizers** that core
lacks for menu objects. With it installed, menu-link objects
(`MenuLinkInterface`) and whole menu trees (`MenuLinkTreeElement`) can be turned
into JSON or XML through the standard core `serializer` service, which core can't
do on its own.

It is pure plumbing. There is **no UI, no configuration, no permissions, and no
routes** — the module simply registers two services so that other code can
serialize menus. `MenuLinkNormalizer` flattens a single link into an array of its
data (id, title, weight, menu name, parent, route name and parameters, the
resolved URL, enabled/expanded/deletable flags, and more). `MenuLinkTreeNormalizer`
emits a link along with its `has_children`, `depth`, `in_active_trail`, `count`,
and a recursively normalized `subtree`, so an entire nested menu serializes in a
single call.

You install this module because something needs it — typically to expose a menu
over a custom REST/JSON endpoint, to feed a decoupled or headless front end its
navigation structure, or because another contrib module depends on it. As the
project itself notes: it does nothing on its own; only install it when your code
or another module actually needs to serialize menus.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent (including the exact array shape
each normalizer emits), read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — the module adds no admin pages, settings, or menu links. Once enabled,
it works silently in the background whenever code calls the core serializer on a
menu object.

## How to use it

There is nothing to click. After enabling, developers use the normalizers by
calling the core serializer, for example:

```php
$data = \Drupal::service('serializer')->normalize($menuLink, 'json');
```

or, for a whole tree loaded via `MenuLinkTreeInterface::load()`, normalize the
returned tree to get the full nested structure — links, depth, active-trail
flags, and children — in one pass. The normalizers require core's
**Serialization** system to be present to have any effect (see
[Installation](installation/index.md)).
