# Meta Position — manual setup guide

**Meta Position** (`meta_position`) is a small content-editing UX tweak. On a
standard node add/edit form, the "advanced" metadata panel — URL alias, authoring
information, menu settings, promotion options, and so on — sits in a compact strip
down the right-hand sidebar. Meta Position moves that panel **below the main form**
and renders it as full-width horizontal vertical-tabs, with the collected fields
grouped under an "Information" section.

Why bother? On content-heavy forms — especially when you use
[Paragraphs](https://www.drupal.org/project/paragraphs) or
[Field Group](https://www.drupal.org/project/field_group) to lay out fields — you
usually want the **full browser width** for the main form rather than losing a
chunk of it to the sidebar. Moving the metadata panel underneath frees up that
space. You can turn the change on site-wide or limit it to specific content types.

It is a **CSS-only** adjustment (no JavaScript) and works best with admin themes
that extend Claro (Drupal 10/11) or Seven (older). It also complements the
[Gin](https://www.drupal.org/project/gin) theme workflow.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Meta Position**
(`/admin/config/content/meta`).

> **Heads-up on access:** the settings form is gated by a permission called
> `administer site`, which Drupal core does **not** define. In practice that means
> only **user 1** (the superuser) can open the form unless a custom module or role
> explicitly grants `administer site`. If an administrator other than user 1 gets an
> "access denied" on the settings page, this is why — you would need to define and
> grant that permission, or make the change as user 1.

## How to use it

1. Go to **Configuration → Content authoring → Meta Position**
   (`/admin/config/content/meta`) as a user who can access it (see the note above).
2. Tick **Enabled** to turn the repositioned layout on.
3. Once enabled, a **content types** checklist appears. Tick the content types you
   want the change applied to — for example only *Article*. **Leave every box
   unchecked to apply it to all content types.**
4. Save the form.

Now open a node edit form for one of the selected types: the advanced metadata panel
appears as full-width vertical tabs below the main form instead of in the sidebar.

The two saved settings are simply `enabled` (the master on/off switch, off by
default) and `node_types` (the list of content types, empty meaning "all"), stored
in the `meta_position.settings` config object so you can export it across
environments.
