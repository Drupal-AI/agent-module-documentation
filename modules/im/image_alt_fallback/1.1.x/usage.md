<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Alt Fallback fills empty alt attributes on configured image fields using the entity label as a fallback, improving accessibility.

---

Image Alt Fallback improves accessibility by filling empty `alt` attributes on configured image fields
— when an image has no alt text, it uses the entity's label as a fallback, so images aren't left without
alternative text for screen readers. It depends on core System, Views, Image and Media and is configured
at `image_alt_fallback.settings`.

Use it to reduce missing-alt-text accessibility issues where editors leave alt empty. It is an
accessibility/display feature that supplies fallback alt text at render time; it does not change stored
data or access. Note a fallback (the entity label) is better than empty but not a substitute for
meaningful, image-specific alt text — encourage editors to still write proper alt where it matters.
Configure which image fields get the fallback.

---

- Fill empty image alt attributes.
- Use the entity label as alt fallback.
- Improve image accessibility.
- Reduce missing-alt issues.
- Depend on System, Views, Image, Media.
- Configure at image_alt_fallback.settings.
- Supply fallback alt at render time.
- Not change stored data or access.
- Help screen-reader users.
- Provide alt where editors leave it empty.
- Encourage meaningful alt still.
- Configure image fields.
- Avoid empty alt attributes.
- Fall back to the label.
- Improve a11y compliance.
- Handle missing alt text.
- Add fallback alt.
- Support accessible images.
- Reduce accessibility gaps.
- Fill alt automatically.
