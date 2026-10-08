<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Color Field from image computes an image's dominant color and stores it in a color_field.

---

Color Field from image automatically populates a Color Field with the dominant color extracted from an image field on the same entity — so cards, teasers, or backgrounds can be tinted to match their image without manual color-picking. The computation runs when the entity is saved.

It's a field-automation helper with no content or access role of its own. Depends on core `image` and the `color_field` module; supports Drupal 10.1+, 11, and 12.

---

- Extract an image's dominant color.
- Fill a color_field automatically.
- Use an image field on the entity.
- Tint cards/teasers/backgrounds.
- Avoid manual color-picking.
- Compute on entity save.
- Depend on core `image` and `color_field`.
- Support Drupal 10.1+, 11, and 12.
- Carry no content/access role.
- Act as a field-automation helper.
- Match colors to images.
- Configure the source/target fields.
- Derive colors programmatically.
- Support themed presentation.
- Populate colors consistently.
- Reduce editorial effort.
- Integrate with color_field.
- Store the dominant color.
