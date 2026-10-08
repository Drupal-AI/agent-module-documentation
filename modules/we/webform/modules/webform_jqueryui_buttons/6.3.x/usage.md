DEPRECATED. Provides `webform_buttons` and `webform_buttons_other` elements that render a group of jQueryUI buttons for selecting a value.

---

Webform jQueryUI Buttons is a deprecated submodule that renders single-value select inputs as a horizontal group of buttons using the jQueryUI buttonset widget. It defines two `@WebformElement` plugins — `webform_buttons` (a styled radios replacement) and `webform_buttons_other` (the same with an "Other…" free-text option) — backed by render elements and a small behavior script. Because jQueryUI is no longer maintained, the module is marked deprecated (`lifecycle: deprecated`) and depends on the `jquery_ui_button` contrib module. New sites should use standard radios, the core buttons styling, or CSS instead. It exists mainly for backwards compatibility with forms built before jQueryUI was removed from core. No config UI, permissions, or schema.

---

- Render a single-choice question as a row of buttons (legacy sites).
- Maintain existing forms that already use `webform_buttons`.
- Offer an "Other…" text option alongside buttons via `webform_buttons_other`.
- Provide a touch-friendly alternative to radio buttons (legacy).
- Migrate away from: identify forms still using these elements.
- Reference the plugin structure when replacing with a modern element.
- Keep older webforms rendering correctly during an upgrade window.
- Test backwards compatibility after upgrading Webform.
- Understand how jQueryUI buttonset was integrated with Webform.
- Audit a site for deprecated jQueryUI dependencies.
- Provide button-style selection where a theme expects it.
- Support forms exported from an older site build.
- Compare against non-jQueryUI button styling approaches.
- Document the deprecation path for editors and developers.
- Verify the `jquery_ui_button` dependency is present.
- Plan removal by locating each element usage in config.
