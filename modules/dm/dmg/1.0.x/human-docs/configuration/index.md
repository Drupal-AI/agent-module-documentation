# Configuration

Display Mode Guidelines does not have one central settings page. Instead you write
guidelines in the places they are relevant: on individual display modes, and on
the "add a new display mode" flow for an entity type. Only users who can
administer display modes or site configuration can edit them, and everything you
type is rich text that is sanitised (admin-filtered HTML) when shown.

## Per-display-mode guidelines

Use these to document what a specific view or form mode is for.

1. Go to **Structure → Display modes → View modes** (or **Form modes**).
2. Add a new mode, or edit an existing one.
3. Fill in the **Configuration Guidelines** field (a required rich-text field the
   module adds to the add/edit form) with a note about how the mode should be
   used.
4. Save.

The guideline is stored on that mode and now appears as a **warning message at
the top of the mode's *Manage display* form** — so every time someone configures
that mode's fields, your note is right there. On the display-modes listing, the
**Guidelines** column shows the mode's text (or "- No guidelines configured yet -"
when it is empty).

## Creation guidelines (per entity type)

Use these to guide people *before* they create a brand-new display mode for an
entity type — the best place to discourage one-off modes.

1. On the **View modes** or **Form modes** listing, use the **Set creation
   guidelines** action link (the link text becomes **Update creation guidelines**
   once one exists).
2. This opens a small form with two fields:
   - **Entity Type** — a select of the content entity types (Node, Media, and so
     on). Choose which entity type this guideline applies to.
   - **Creation Guidelines** — a required rich-text field for the guidance
     itself.
3. Save.

From then on, when someone opens the "add display mode" form for that entity type,
your creation guideline appears as a **warning at the top of the form**. You can
set different guidelines for different entity types — for example stricter rules
for `node` than for `media`.

Because these creation guidelines are stored in the `dmg.settings` configuration
object, they are included in configuration exports and ship with your site's
config between environments.
