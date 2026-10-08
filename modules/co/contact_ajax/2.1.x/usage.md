Contact Ajax makes Drupal core contact forms submit via AJAX (no full page reload) and lets you choose per contact form what is shown after a successful submission.

---

The module has no settings page of its own. Instead it adds a **"Contact ajax" fieldset** to each
contact form's edit page (`admin/structure/contact`) via `hook_form_FORM_ID_alter()` for
`contact_form_form`, storing the choices as **third-party settings** on the `contact.form.*` config
entity (schema key `contact.form.*.third_party.contact_ajax`). Per contact form you can enable AJAX
(`enabled`), pick an **on-submit confirmation type** (`confirmation_type`), and set advanced overrides
for the wrapper element id (`prefix_id`) and a custom render target selector (`render_selector`). When a
form's message form (`contact_message_form`) renders and AJAX is enabled, the module wraps it in a div
and attaches an `#ajax` submit callback (`contact_ajax_contact_site_form_ajax_callback`). On submit the
callback returns an `AjaxResponse` that replaces the wrapper with one of: the default status message
(`CONTACT_AJAX_LOAD_DEFAULT_MESSAGE`), the status message plus a fresh empty form
(`CONTACT_AJAX_LOAD_CLEAN_FORM`), the rendered full view of a configured node
(`CONTACT_AJAX_LOAD_FROM_URI`), or a custom rich-text message (`CONTACT_AJAX_LOAD_FROM_MESSAGE`). If a
custom `render_selector` is set, the response is injected there and the original form is removed; when
Views is installed it also scrolls to the target. Validation errors are returned inline via AJAX with
the messages and the re-rendered form. Pairs well with Contact Storage.

---

- Submit a site contact form without reloading the page.
- Submit a personal (user) contact form via AJAX.
- Show only the default "Your message has been sent" status message after an AJAX submit.
- Show the status message and immediately present a fresh empty form for another submission.
- Replace the form with the full rendered content of a chosen node after submission (e.g. a thank-you page node).
- Replace the form with a custom formatted (rich-text) confirmation message after submission.
- Keep visitors on the same page after contacting you, improving conversion UX.
- Give each contact form its own post-submit behavior (different confirmation per form).
- Render the AJAX response into a different element on the page via a custom CSS selector.
- Use a custom wrapper element id to integrate with existing page markup/styling.
- Display validation errors inline without a page reload.
- Auto-scroll to the confirmation/response when Views is enabled.
- Build a lightweight "contact us" modal/section that updates in place.
- Combine with Contact Storage to keep submissions while still using AJAX UX.
- Provide a smoother multi-message contact flow (submit, clear, submit again).
- Show a marketing/CTA node after a lead submits the contact form.
- Localize/format the confirmation via a text-format-enabled custom message.
- Reduce perceived load time on contact pages by avoiding full reloads.
- Apply AJAX submission selectively — leave some contact forms as standard POST.
- Embed a contact form in a sidebar/block and update just that region on submit.
