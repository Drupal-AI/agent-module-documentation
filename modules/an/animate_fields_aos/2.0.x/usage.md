Adds scroll-triggered AOS (Animate On Scroll) animations to individual field displays through per-formatter third-party settings, no code required.

---

Animate Fields AOS extends Drupal's field formatter settings (via `hook_field_formatter_third_party_settings_form`) so that any field, on any entity view display (Content, Media, or Block types), can be tagged to animate as it scrolls into view. When "Display Animations" is enabled on a field's formatter, the module stamps `data-aos-*` attributes onto the field's rendered wrapper in `hook_preprocess_field` and attaches a library that loads the third-party AOS JS/CSS from a CDN and calls `AOS.init()`. Animation type, easing, anchor placement, offset, delay, duration, and mirror are all chosen from selects/number fields whose option lists come from `animate_fields_aos.options.yml` (aggregated across modules/themes by a YAML-discovery service). Editing these formatter settings requires the `edit animate fields formatter settings` permission. There is no global settings page and no config entity — configuration lives inside each display's third-party settings.

---

- Fade a node title in as the visitor scrolls down to it (Manage Display → gear icon → AOS Animations → Display Animations → Fade).
- Slide the body field up into view on an article page.
- Zoom-in an image field on a media type's display.
- Apply a flip animation to a block type's custom field.
- Give a call-to-action field a delayed fade-up so it appears after surrounding content.
- Set a longer duration (e.g. 800ms) on a hero field for a slower, more dramatic reveal.
- Use anchor placement (e.g. "center-bottom") to fine-tune when a field starts animating relative to the viewport.
- Enable "mirror" so a field also animates out while scrolling past it.
- Choose an easing curve (e.g. ease-in-out-cubic) to change the animation's acceleration feel.
- Add a scroll offset (default 120px) so animations trigger slightly before the field reaches the trigger point.
- Animate different fields on the same node with different effects (fade one, slide another).
- Apply the same animation preset consistently by configuring it once per field per view mode.
- Restrict who can configure animations by granting the module's permission only to designers/site builders.
- Animate teaser-view fields differently from full-view fields by configuring each view mode separately.
- Extend the available animation/easing/anchor option lists by shipping your own `<name>.options.yml` in a custom module or theme.
- Decorate landing-page paragraph fields with staggered reveal effects using per-field delay values.
- Add subtle motion to taxonomy term or user profile fields on their display.
- Turn animations off for a field simply by unchecking Display Animations (attributes are then not emitted).
- Reproduce AOS demo effects (fade, flip, slide, zoom variants) directly from Drupal's UI without hand-editing templates.
- Keep animation configuration exportable with the rest of the entity view display config (third-party settings + schema).
