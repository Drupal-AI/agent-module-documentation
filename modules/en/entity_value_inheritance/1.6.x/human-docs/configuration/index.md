# Configuration

You configure Entity Value Inheritance by creating one or more **Inheritance**
records, each describing a single source → destination field mapping. Before you
start, make sure the destination bundle already has a **single-value entity
reference field** that points at the source entity — that field is how the module
knows which source a given destination inherits from.

## Create an Inheritance mapping

1. Go to **Structure → Inheritance** (`/admin/structure/inheritance`) and click
   **Add Inheritance**.
2. Fill in the form (all fields below belong to the `inheritance` config entity):

   - **Label** — a human-readable name for this mapping.
   - **Enabled** — leave checked to make the mapping active; uncheck to pause it
     without deleting it.
   - **Description** *(optional)* — a note about what this mapping does.
   - **Field Strategy** — how the value is applied to the destination (see the
     strategies below). Some strategies expose extra configuration once selected.
   - **Source Entity Type → Source Bundle → Source Field** — where the value
     comes *from*.
   - **Destination Entity Type → Destination Bundle → Destination Field** — where
     the value is written *to*.
   - **Destination Reference Field to Source** — the single-value entity
     reference field on the destination bundle that points back at the source.

3. Submit. From now on the mapping runs automatically whenever a relevant entity
   is inserted, updated, saved, loaded, or its edit form is built.

## Field strategies

The **Field Strategy** you pick decides how the source value reaches the
destination:

- **Update** — keep the destination continuously in sync with the source. Change
  the source and the destination follows.
- **Overwrite** — replace the destination value unconditionally with the
  source's value.
- **Override** — apply the inherited value, but let the destination keep a local
  value of its own where set.
- **Override by role visibility** — a role-aware version of override, so whether a
  user may locally override depends on their role.
- **Disable** — show the inherited value on the destination but lock the field on
  the destination's edit form, so editors see it read-only.

## Global settings

Module-wide behaviour lives at **Structure → Inheritance → Settings**
(`/admin/structure/inheritance/settings`). Like every other page here, it
requires the **Administer inheritance** permission.

## Good to know

- Keep **Administer inheritance** limited to trusted administrators.
- Only **single-value** entity reference fields can be used as the link between
  destination and source in this version.
- Developers can add custom strategies by implementing an updater plugin, and can
  hook into the sync through the module's events (pre/post-update, alter-field,
  alter-update-list, save-entity).
