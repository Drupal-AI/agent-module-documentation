# Published State Indicator — manual setup guide

**Published State Indicator** (`published_state_indicator`) adds a field
formatter that appends a small state label to a referenced entity's title,
showing its published or moderation state at a glance. It's designed for sites
that use the **Workflows / Content Moderation** system and have lists of content
where editors need to see, at a glance, whether each item is *Draft*, *Published*,
*Archived*, and so on. It also works with core's basic Published/Unpublished
states if you're not using workflows.

The formatter is called **Label & Published state**, and you apply it to an
entity reference (list) field on the entity's *Manage display*. Each referenced
item then shows its title with a colored state label beside it. You get some
control over how those labels look:

- Turn the labels on or off per field.
- Adjust the font size and the label colors for each state from an admin settings
  page.
- Optionally hide the label for entities that are simply *published* (so only the
  "interesting" states stand out).
- Restyle everything further by overriding the module's CSS classes in your
  theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module's colors and font size are set on a small admin page (see below), and
the formatter itself is applied per field on *Manage display* — both are covered
in "How to use it".

## Where it lives in the admin menu

- The **label styling** (font size and per‑state colors) is set at
  **Configuration → User interface → Published State Indicator**.
- The **formatter** is applied per field at **Structure → *(entity type)* →
  *(bundle)* → Manage display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** page for an entity type/bundle that has an entity
   reference (list) field — for example a content type that references other
   nodes. In that field's **Format** column, choose **Label & Published state**.
3. Adjust the formatter's per‑field options — for instance whether to show the
   label, and whether to display a label for already‑published entities.
4. To tune the appearance globally, go to **Configuration → User interface →
   Published State Indicator** and set the **font size** and the **color** for
   each moderation/published state.
5. If you need finer control, override the module's CSS classes (one per label
   state) in your theme.

The result: content lists where each referenced item's title carries a clear,
color‑coded badge of its current workflow state.
