Terms of Use adds a required "I agree" checkbox — and optionally the full terms text or a link to it — to Drupal's user registration form, sourced from a node you designate.

---

The module has no entity types or plugins; it is a single settings form plus one `hook_form_user_register_form_alter()`. On the settings page (`/admin/config/people/terms-of-use`, permission `administer account settings`) you pick a node (entity autocomplete) whose content is your Terms of Use, and set three labels/toggles: the fieldset title, the checkbox label, and whether the details element starts open or collapsed. At registration the module injects a `details` element containing either the node's body (rendered raw inside a `<div class="terms-of-use">`) or, if the checkbox label contains the `@link` token, a link to the node instead of the full text (with an optional `target="_blank"`). A `#required` checkbox `terms_of_use_checkbox` forces the user to agree before the account is created. Users with `administer users` (i.e. admins creating accounts at `/admin/people/create`) are skipped entirely, so the terms never block admin-created accounts. The node is translation-aware: if the terms node has a translation for the current interface language it is used. Config keys live in `terms_of_use.settings` and the two labels are translatable. There are no permissions of its own, no Drush commands, and no submodules.

---

- Require new registrants to accept your site's terms and conditions before an account is created.
- Show the full Terms of Use text inline on the registration form from a chosen node.
- Show only a link to the Terms of Use node instead of the full text, using the `@link` token in the checkbox label.
- Open the linked terms in a new browser tab/window.
- Add an age-verification gate ("I certify that I am over 18") as the required checkbox label.
- Present the terms inside a collapsible details element, expanded or collapsed by default.
- Localize the displayed terms by pointing at a translated node.
- Capture explicit consent for GDPR / privacy-policy acceptance at signup.
- Reuse an existing "Terms" content page (do not promote it) as the source of the agreement text.
- Customize the fieldset title wrapping the terms and checkbox.
- Customize the checkbox agreement wording per site.
- Skip the terms requirement for administrator-created accounts (built-in behavior).
- Enforce a legal acceptance step without writing any custom form-alter code.
- Update the terms text site-wide by editing a single node, no config redeploy needed.
- Combine with the core "Visitors" registration setting to gate public signups behind terms.
- Provide a consistent consent UX across a multilingual site.
- Point the terms at a book page, article, or basic page — any node type works.
- Remove the fieldset wrapper entirely by leaving the fieldset label empty.
- Translate the checkbox and fieldset labels via config translation.
- Use as a lightweight alternative to full legal/consent modules when only a signup checkbox is needed.
