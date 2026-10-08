# Smileys Field — manual setup guide

**Smileys Field** (`smileys_field`) adds a dedicated field for picking a smiley
or emoji. It is a modern, Drupal 10/11 rework of the old Drupal 6 Smileys module:
instead of a text filter that swaps ASCII emoticons for images, this gives you a
proper field type and widget where an editor selects a graphical smiley (or
emoji) and that value is stored on the entity. It's handy for lightweight
mood, rating, or reaction data attached to content.

Because it's a field, there is nothing to configure globally — the module has no
site‑wide settings page. You add the field to a content type (or any other
fieldable entity), position it wherever you like (it behaves as a pseudo field,
so you can place it before the body field, for example), and editors get a
smiley picker on the edit form. The stored value is just a smiley; the module
plays no role in access control. It ships with a set of example smileys, and you
can add an unlimited number of custom ones. It depends only on core's **Field**
module and has no submodules.

This guide is written for a **human** adding and using the field through the
admin UI. If you want terse, token‑cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once the module is enabled, go to **Structure → Content types →** *(your type)*
**→ Manage fields**, add a new field, and choose the **Smileys** field type. Set
how many values it should hold, then arrange it on the form and display like any
other field. When editing content, the field presents a smiley/emoji picker; the
chosen smiley is saved with the entity and shown on the rendered page. There is
no separate settings form — everything happens through Drupal's normal field
management screens.
