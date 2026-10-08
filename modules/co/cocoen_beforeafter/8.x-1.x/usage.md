<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cocoen Before After Image Formatter adds two field formatters that render the first two images of a field as a single draggable before/after comparison, using the third-party Cocoen JavaScript library.

---

The pattern has a narrow set of uses and is genuinely the right presentation for all of them: a restoration project, a construction site at two dates, a cosmetic or medical result, a satellite image showing change, a design refresh, a photograph before and after processing. Two images side by side make the viewer compare by memory; one image with a draggable divider lets them compare directly. This module supplies it as a **field formatter**, so it is a display setting on an existing field rather than a component an editor has to assemble — the two images stay ordinary field values that can be replaced independently. It ships **two formatters**: `cocoen_before_after_image` for multi-value **image** fields, and `cocoen_before_after_media` for **entity_reference** fields that target **media** (it reads each media item's source image field). Both take the **first two** values of the field and ignore the rest, so the field's cardinality must allow at least two. A single **image style** setting is offered per formatter (default is original size). The formatter emits a `<div class="cocoen-beforeafter-container cocoen">` with the two `<img>` tags and attaches the module's library; a small `Drupal.behaviors` script calls `.cocoen()` on the container via jQuery. Three practical requirements. **The Cocoen library is not bundled** — you must download koenoe/cocoen 2.x and extract it to the web root so that `libraries/cocoen/dist/js/cocoen.min.js` exists; without it the two images render stacked but the slider never initialises (this DDEV site currently has no such library installed). **The two images must share dimensions and alignment** or the comparison is misleading rather than informative, and the module cannot enforce this — it belongs in editorial guidance. And **a drag interaction needs a keyboard equivalent**: verify the slider is operable by keyboard or that both images stay individually reachable with alternative text describing what changed. Version **8.x-1.3** on core `^10 || ^11`, depending on core `image`; Cocoen 3.x is not supported by this branch.

---

- Show a building restoration before and after.
- Compare a construction site photographed at two dates.
- Present a cosmetic or medical treatment result.
- Show satellite or aerial imagery change over time.
- Compare a photograph before and after retouching.
- Present a room renovation result.
- Show a colour-grading or post-processing example.
- Compare a garden or landscape across seasons.
- Present a website or product redesign comparison.
- Show a cleaning, repair, or conservation outcome.
- Compare two versions of a map or floor plan.
- Present a paint or resurfacing job's result.
- Show a damage-and-repair (insurance) comparison.
- Compare a dental or orthodontic result.
- Present a weight-loss or fitness transformation.
- Build the comparison from a media reference field (reusable media library images) rather than raw uploads.
- Apply an image style so both sides are downscaled consistently.
- Show a product with and without an accessory or finish.
- Compare a page layout before and after a design change.
- Present an archaeological or heritage reconstruction.
