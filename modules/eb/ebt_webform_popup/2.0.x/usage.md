EBT Webform Popup ships a reusable block content type that shows a chosen Webform inside a modal or dialog popup, opened by a customizable button.

---

The module installs a `block_content` bundle named `ebt_webform_popup` with two fields: a required Webform entity reference (`field_ebt_webform_popup_form`) selecting which form to show, and the shared EBT settings field (`field_ebt_settings`) that carries button text, popup dimensions/title/type and the standard EBT button and design options. Editors create instances under the custom block library and place them in a region or drop them into a Layout Builder section. A dedicated field widget, `EbtSettingsWebformPopupWidget` (plugin id `ebt_settings_webform_popup`, extending EBT Basic Button's widget), adds the popup controls: button text, popup width, form height, popup title, and popup type (Modal or Dialog). At render time `ebt_webform_popup_preprocess_block()` (via `EbtWebformPopupHooks`) attaches Drupal core's `webform/webform.ajax` library, resolves the referenced form's URL, builds a JSON `data-dialog-options` string, and turns the button/design settings into inline `<style>` blocks (button styling from EBT Basic Button's `generate_custom_css` service). Two Twig templates (`block--block-content--ebt-webform-popup` and `block--inline-block--ebt-webform-popup`) render a `use-ajax` link that opens the Webform in a jQuery UI modal/dialog. The module requires `ebt_basic_button`, `ebt_core`, `paragraphs`, and `webform`. Version 2.0.x, core `^10.1 || ^11 || ^12`.

---

- Add a "Contact Us" button that opens a contact Webform in a modal without leaving the page.
- Place a newsletter-signup Webform in a popup triggered from any region.
- Drop a Webform-popup block into a Layout Builder section on a landing page.
- Show a feedback/support form in a dialog opened from a sidebar button.
- Reuse a single request-a-quote form across many pages via a placed block.
- Open a booking or appointment Webform in a modal from a call-to-action button.
- Trigger an event-registration form in a popup from a hero section.
- Add a "Report an issue" button that pops a bug-report Webform.
- Set the popup width (e.g. 400px) and an optional fixed form height per block.
- Give the popup a custom title, or leave it blank to reuse the Webform's name.
- Choose Modal (blocks the page) or Dialog (non-blocking) popup behaviour.
- Customize the trigger button label (defaults to "Contact Us").
- Style the trigger button colors, shape, size and alignment via EBT Basic Button settings.
- Apply the EBT design box (margins, paddings, borders, background) to the block wrapper.
- Add a custom CSS class to the trigger button for theme-specific styling.
- Place different Webform popups (contact, feedback, survey) on different sections.
- Provide editors a consistent, pre-built form-popup component instead of hand-built modal markup.
- Use AJAX submission so the form posts and confirms inside the dialog.
- Add a "Join the waitlist" popup form to a product page.
- Embed a short lead-capture Webform behind a button in a footer region.
