# Configuration

There are two layers to configure: a **global setting** for which entity types can
participate, and one **inheritance** for each field you want to inherit.

## Permission

Access to everything below is gated by the **Administer field inheritance**
(`administer field inheritance`) permission, which is marked as restricted. Grant
it only to trusted roles on **People → Permissions**.

## Global settings — which entity types can participate

1. Go to `/admin/structure/field_inheritance/settings`.
2. The **Included entities** setting lists the entity types that may act as a
   source or destination. By default this is **block content**, **file**, **node**,
   and **taxonomy term**. Add or remove entity types here to widen or narrow the
   choices.

Because changing this list adds or removes a supporting base field on those entity
types, the form routes through a **confirmation step** before it applies. Save and
confirm, then rebuild caches if prompted.

## Create an inheritance

1. Go to **Structure → Field inheritance** (`/admin/structure/field_inheritance`)
   and click **Add** (`/admin/structure/field_inheritance/add`).
2. Fill in the form. It uses AJAX, so choosing an entity type reveals its bundles,
   and choosing a bundle reveals its fields:

- **Label** — a human-readable name. This also becomes the label of the computed
  field on the destination.
- **Type (strategy)** — how the value is produced:
  - **Inherit** — show the source value as-is.
  - **Prepend** — source value before the destination's own value.
  - **Append** — source value after the destination's own value.
  - **Fallback** — destination's own value if present, otherwise the source value.
- **Source entity type / bundle / field** — where the data is read from.
- **Destination entity type / bundle** — which bundle gets the new computed field.
- **Destination field** — only shown (and needed) for the **prepend**, **append**,
  and **fallback** strategies; it is the destination's own local field that is
  combined with the source. The **inherit** strategy does not use it.
- **Plugin** — the mechanism used to read the value:
  - **Default inheritance** — for ordinary fields.
  - **Entity reference inheritance** — for entity-reference-style fields such as
    images, files, paragraphs, and other reference fields.

3. Save.

## What you get

For each inheritance, the module adds a **computed, read-only field** to the
destination bundle. It takes on the source field's type and settings, and its
value is calculated every time it is read, so it stays in sync with the source
automatically. Because it is read-only, editors cannot type into it directly.

Arrange this field on the destination bundle's **Manage display** screen like any
other field to control where and how it appears. The inherited value is also
available to Views (through the module's Views field plugin) and to tokens.

## Deployment

Each inheritance is a configuration entity, so you can export it with the rest of
your site configuration and deploy it across environments like any other config.
