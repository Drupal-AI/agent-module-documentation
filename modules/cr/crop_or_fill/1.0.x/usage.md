<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crop or Fill is a Drupal image-style effect that adapts to image orientation: when the
image and the crop's target aspect ratio share an orientation it performs a normal crop, and
when they differ it places the image on a solid-color canvas (pillarbox/letterbox) matching the
target ratio instead of cropping away content.

---

It extends the Crop module's `CropEffect` (`@ImageEffect` id `crop_or_fill`) and adds a
**Background color** setting (default `#ffffff`). In `applyEffect()` it resolves the target
dimensions from the crop type's ratio: no ratio / free-form crop → delegate to the standard
crop; same orientation → standard crop; opposite orientation → `applyPillarbox()`, which
composes the image onto a background-colored canvas. Toolkit operations are provided for both
GD and ImageMagick (`Pillarbox` operations + a shared `PillarboxTrait`).

Add the "Crop or fill" effect to an image style (*Configuration → Media → Image styles*),
choose a crop type and a background color. Use it when you need consistent output dimensions
but must not lose parts of portrait images shown in landscape slots (or vice versa) — e.g.
mixed-orientation galleries, teasers, or thumbnails.

---

- Add a "Crop or fill" effect to an image style.
- Crop images when orientation matches the target ratio.
- Pillarbox images when orientation differs, instead of cropping.
- Set the fill/background color for mismatched orientations.
- Keep consistent output dimensions across mixed-orientation images.
- Avoid cropping content out of portrait images in landscape slots.
- Support both GD and ImageMagick toolkits.
- Reuse the Crop module's crop types.
- Delegate free-form (no-ratio) crops to a standard crop.
- Produce letterbox/pillarbox thumbnails.
- Normalize gallery image dimensions.
- Fill with white by default, or any chosen color.
- Normalize thumbnails for a mixed-orientation grid.
- Show full portrait photos inside landscape cards.
- Pick a brand color as the pillarbox fill.
- Apply consistent teaser image dimensions.
- Fall back to a plain crop for free-form crop types.
