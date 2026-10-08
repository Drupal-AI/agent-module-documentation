# Configuration

Pager's settings do two jobs: they **define the sequence** (which content is chained
together, in what order) and they **control the block's appearance**. Configure them at
the Pager settings page (route `pager.admin`, behind the **Administer pager** permission),
then place the **Pager** block from **Structure → Block layout**.

## Text on the links

- **Previous Text** — the label shown at the bottom of every *previous* link.
- **Next Text** — the label shown at the bottom of every *next* link.

## Optional image on the links

- **Image Field** — the image field used to illustrate the previous/next targets. If you
  want pagination to work *across* content types, it's convenient for those types to share
  the same image field.
- **Image Style** — the image style applied to that image. For a consistent look, an image
  style that scales and crops to a fixed aspect ratio works best; matching the style's
  size to the display size (or close to it) helps performance.

## What defines the sequence

- **Content Types** — the content types included in this block's pagination. Chaining
  across several types is simplest when they share taxonomy and an image field.
- **Taxonomy Terms** — the terms whose content is included in the sequence.
- **Maintain Term** — when set, the previous/next links stay within the *same* taxonomy as
  the current item (Dogs → Dogs, Cats → Cats). When not set, the sequence spans all the
  selected terms (Dogs → Dogs → Cats → Honey Badgers, and so on).
- **Direction** — the order of travel. **Forward** is chronological, first to last (first
  = oldest, last = newest).

## End behaviour

**End Behavior** controls what happens at the very first and very last item in the
sequence:

- **Loop** — the last item links back to the first (and the first links to the last), so
  the sequence is a circle with no dead ends.
- **Current** — on the first or last item, one link points to itself.
- **Single** — only one link is shown at the ends (just *next* on the first item, just
  *previous* on the last).

## Appearance

- **Theme** — how the block is presented. There are two options: a **centred block**, or
  **slide‑out side tabs** that sit at the edges of the viewport.

## Save and place the block

Save the settings, then go to **Structure → Block layout**, place the **Pager** block in
a region, and view a piece of content in the sequence to confirm the previous/next links
behave as you configured.

> **Keep it correct:** because these links are per‑item and cacheable, make sure the block
> reflects changes when content is added, unpublished or reordered — otherwise a "next"
> link can point at content that has since moved or disappeared.
