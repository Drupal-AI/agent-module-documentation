CSS Toggle Switch Webform adds "Toggle Switch" and "Entity Toggle Switch" Webform elements backed by the base module's CSS-only toggle switch form element.

---

This submodule of CSS Toggle Switch bridges the `toggle_switch` Form API element into Webform. It registers two Webform element plugins: `toggle_switch` ("Toggle Switch", in the *Options elements* category) which extends Webform's `Radios` element, and `toggle_switch_entity` ("Entity Toggle Switch", in the *Entity reference elements* category) which extends the toggle switch element and mixes in Webform's entity-reference/options traits to let a single referenced entity be chosen with the switch UI. Both add configuration for the toggle type (`switch-light` / `switch-toggle`), extra CSS classes, and the "on" indicator attributes, exposing them on the Webform element edit form. It requires the Webform module (`webform:webform`) and the base `css_toggle_switch` module.

---

- Add a CSS-only toggle switch as a Webform element without writing a custom render array.
- Offer a clear two-state (on/off, yes/no) choice on a webform using the switch styling.
- Present a small set of radio options as a styled switch inside a webform.
- Pick a single referenced entity in a webform using the "Entity Toggle Switch" element.
- Let form builders choose the switch type (Light or Toggle) per webform element.
- Apply custom library skin classes (e.g. `switch-candy`, `switch-ios`) to a webform switch element.
- Set a custom class on the switch's "on" indicator from the element settings.
- Keep webform switches accessible since they are built on standard radio inputs.
- Reuse consistent toggle-switch styling across both site forms and webforms.
- Build feature-flag / preference style webforms with switch controls instead of plain radios.
- Configure the switch entirely from the Webform UI (no code) via the element edit form.
- Combine entity-reference selection with a compact switch UI for boolean-like reference choices.
