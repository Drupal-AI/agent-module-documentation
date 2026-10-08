# Cocoen Before After Image Formatter — manual setup guide

**Cocoen Before After Image Formatter** (`cocoen_beforeafter`) adds a field
formatter that renders **two images as a draggable before/after comparison** —
one image with a slider divider you drag across it, instead of two images sitting
side by side. It uses the **Cocoen** JavaScript library to do the sliding.

This is genuinely the right presentation for a specific set of jobs: a
restoration project, a construction site photographed at two dates, a medical or
cosmetic result, satellite imagery showing change, a design refresh, or a
photograph before and after processing. Two images side by side make the viewer
compare from memory; one image with a draggable divider lets them compare
directly, and the difference in what gets noticed is large.

Because it is a **field formatter** rather than a component an editor has to
assemble, the two images stay ordinary field values that can be replaced
independently, and turning the comparison on is a display setting on the field.
It works on both **image** fields and **media image** fields, and depends only on
core's Image module.

Two things are worth getting right, and neither is something the module can
enforce for you:

- **The two images must share dimensions and alignment.** A divider between a
  wide shot and a close-up shows nothing meaningful about change — matching the
  framing is a content-production requirement that belongs in your editorial
  guidance.
- **A drag interaction needs a keyboard-accessible fallback.** A comparison that
  can only be operated by dragging is unavailable to keyboard and screen-reader
  users. Check whether the slider responds to arrow keys and, if not, make sure
  both images remain individually reachable with alternative text that describes
  *what changed*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Cocoen
   JavaScript library, and enable the module.

There is **no settings page** for this module — you turn the comparison on in a
field's *Manage display*, described in "How to use it" below.

## How to use it

1. Add (or reuse) an **image** or **media image** field that holds **two
   images** — the "before" and the "after". Set the field to allow at least two
   values, and upload the two images in the order you want compared.
2. Go to the entity bundle's **Manage display** (Structure → Content types →
   *(bundle)* → Manage display, or the equivalent for your entity/media type).
3. Set that field's format to the **Cocoen beforeAfter** formatter.
4. View the entity — the two images render as a single draggable before/after
   slider.

> **Reminder:** the effect only works well when both images share the same
> dimensions and alignment. Mismatched framing produces a slider that looks
> broken rather than informative.
