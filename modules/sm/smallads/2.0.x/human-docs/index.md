# Smallads — manual setup guide

**Smallads** (`smallads`) is a ready-to-run classified-ads marketplace for
Drupal. Enable it and you get a complete "offers and wants" system: a dedicated
`smallad` content entity, a hierarchical category vocabulary, listing views for
browsing, a navigation block, and a search plugin — all wired together so members
can post small ads and everyone can browse them by category.

It was built for LETS and timebank communities that want to match unused
resources with unmet needs, but it works just as well as a generic classifieds
engine. When you turn it on it creates two vocabularies — **categories** (a
hierarchical, yellow-pages-style classifier) and **smallads_types** (add terms
like *offers*, *wants*, *notices*, which appear as tabs on the listing pages) —
and generates three ready-made views: all offers, all wants, and each user's own
ads. Every ad carries a *visibility scope* and an *expiry date*; once an ad
expires it automatically reverts to private scope, visible only to its owner and
to moderators.

Smallads is deliberately "plug in and go" — it is not really meant to be heavily
customised or built upon. It has several hard dependencies: the contrib modules
**SHS** (`shs`), **Chosen** (`chosen`) and **Taxonomy Entity Index**
(`taxonomy_entity_index`), plus a long list of core modules (block, comment,
field, image, link, search, taxonomy, token, views). It also switches on core's
**Contact** module automatically during installation. Three optional submodules
extend it: **Smallads Group** (`smallads_group`, scope ads to Group entities),
**Smallads MCAPI** (`smallads_mcapi`, mutual-credit / community-accounting
pricing), and **Smallads Murmurations** (`smallads_murmurations`, publish ads to
the Murmurations network).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Heads-up on security coverage:** Smallads is not covered by the Drupal
> security advisory policy. Access is entirely permission-driven, so grant the ad
> permissions thoughtfully (see below), but be aware you won't get official
> security releases for it.

## Contents

1. [Installation](installation/index.md) — install the module and its contrib
   dependencies with Composer, enable it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — the settings form, ad types
   (bundles), permissions, and the category/types vocabularies.

## Where it lives in the admin menu

Smallads' own settings form sits at **Administration → Structure → Smallads →
Settings** (`/admin/structure/smallads/settings`). The list of ad types
(bundles) and the forms to add, edit or delete a type live under
**Administration → Structure → Smallads** (`/admin/structure/smallads`). Both
require the **Administer site configuration** permission.

## How to use it

Once enabled, members with the **post smallad** permission can create and manage
their own ads, filing each one under a category and (optionally) a type. Anyone
with **view smallad** can browse. The generated views give you an "all offers"
page, an "all wants" page and a per-user "my ads" listing out of the box, and the
nested-categories navigation block can be placed in any region so visitors can
drill down through the category tree. Ads carry an expiry date and, once expired,
drop to private scope automatically — so old listings clean themselves up. Two
bulk actions, **Delete smallad** and **Unpublish smallad**, help moderators prune
the catalogue.
