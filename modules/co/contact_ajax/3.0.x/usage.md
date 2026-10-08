Contact Ajax makes Drupal core Contact forms submit over AJAX, replacing the full page reload with a configurable in-place response.

---

Contact Ajax (3.x, Drupal 11/12) attaches to every core contact form through `hook_form_FORM_ID_alter()` and stores its options as third-party settings on the contact form config entity — it adds no routes, services, permissions, or plugins. On the contact form edit screen (`admin/structure/contact`) a "Contact ajax" fieldset lets an administrator enable AJAX per form and pick what happens after a successful submit: show the default status message, show the default message with a freshly emptied form, render a chosen node's content in place of the form, or render a custom formatted message. Advanced settings let you set a custom wrapper id (`prefix_id`) and render the AJAX response into a different HTML element than the form wrapper (`render_selector`). At submit time an `#ajax` callback on the submit button builds an `AjaxResponse`; on validation errors it re-renders the form with status messages, and on success it emits the configured confirmation content. Submission still flows through the standard core contact workflow, so the core form's access checks and flood limits are unchanged — only the reload is replaced. When the Views module is present the form also attaches `views/views.ajax` and scrolls the response into view.

---

- AJAX-submit a site-wide contact form so visitors stay on the same page after sending a message.
- AJAX-submit personal contact forms (user contact) without a page reload.
- Enable AJAX selectively — turn it on for some contact forms and leave others as standard full-page submits.
- Show Drupal's default "Your message has been sent." status message inline after an AJAX submit.
- Clear the form after a successful submit so a visitor can immediately send another message (default-message-plus-empty-form option).
- Replace the form with the rendered content of a specific node after submit (e.g. a "thank you" landing node).
- Display a custom, rich-text confirmation message after submit instead of the standard status message.
- Keep validation inline: on missing/invalid fields the form re-renders in place with the field errors and status messages.
- Give the AJAX wrapper a predictable, custom HTML id via the advanced "Prefix id" setting for theming or JS hooks.
- Render the AJAX response into a separate container on the page (a different `.class`/`#id`) than where the form sits, using "Render selector".
- Hide the form in its original position and move the confirmation output elsewhere on the page after submit.
- Build multi-step-feeling contact flows where the confirmation content appears in a sidebar or modal-like target element.
- Improve perceived performance on long pages by avoiding a full reload on contact submission.
- Pair with contact_storage so AJAX-submitted messages are still saved as entities.
- Pair with honeypot for spam protection while keeping the AJAX submit experience.
- Scroll the visitor to the response region automatically after submit (when Views is enabled) so the outcome is visible.
- Localize/customize the post-submit message per contact form through the text-format "Message to load" option.
- Reuse an existing node (promo, FAQ, offer) as the post-submit confirmation without duplicating content.
- Provide a consistent AJAX experience across many contact forms by configuring each form's third-party settings.
- Migrate an older 1.x/2.x install to Drupal 11/12 by moving to the 3.x major (same third-party settings model).
