Opens Drupal account links (login, register, password reset, and more) in an AJAX modal dialog instead of navigating to a full page.

---

Account Modal is a small UI module that makes account-related links open in a modal (jQuery UI dialog) window rather than loading a separate page. It hooks into Drupal core with `hook_link_alter` to tag links to the configured account routes with the `use-ajax` / `data-dialog-type="modal"` attributes, and with `hook_form_alter` to attach an `#ajax` submit callback to the underlying core forms so they submit inside the dialog. Which pages participate (user page, login, register, password reset, account cancellation, and — when the Profile module is installed — profile add/edit) is chosen on an admin settings form, which also controls dialog width/height, whether status messages appear above or below the form, whether field descriptions are stripped in the modal, and header/footer block injection. On a successful login or registration the dialog closes and the page either redirects to the form's normal destination or reloads in place; on validation error the core form re-renders inside the dialog with its messages. Because the forms are still served by their own core routes, their normal access checks, flood control, and CSRF tokens are unchanged — the module only changes presentation. It requires no external libraries and has no hard module dependencies; the Profile integration is optional.

---

- Show the core login form in a modal so visitors can sign in without leaving the page they are on.
- Let users register in a dialog triggered from a "Create account" link anywhere on the site.
- Open the password-reset (forgot password) form in a modal from a login dialog or menu link.
- Keep a landing page or campaign page visible behind a login/register overlay to preserve context.
- Present account cancellation confirmation in a modal for enabled sites.
- Pop up a profile-create dialog immediately after registration (with the contrib Profile module) to capture customer details in one flow.
- Reload the current page after login so authenticated content/blocks appear without a manual refresh (Reload on success).
- Redirect to the form's normal destination after login/registration when a page reload is not desired.
- Show validation errors (wrong password, taken username) inside the dialog without a full page reload.
- Configure the dialog width and height (pixels or `auto`) to fit your theme's login form.
- Move status messages above or below the form inside the dialog to match your design.
- Hide verbose core field descriptions inside the modal for a cleaner, compact login/register box.
- Inject one or more configured blocks (by block ID) into the modal header — e.g. a logo, welcome text, or social-login buttons.
- Inject configured blocks into the modal footer — e.g. links to terms, help, or a "need an account?" prompt.
- Provide a streamlined login experience for decoupled-ish or single-page-feeling themes while still using core auth.
- Trigger the login modal from any menu link, block link, or content link that points at `user.login`.
- Offer register-in-a-modal on an e-commerce site (with Profile/Commerce) so checkout isn't interrupted by a page change.
- Standardize account UX across a multi-site or distribution by enabling the same modal pages everywhere.
- Let a "My account" link open the user page in a dialog for quick access.
- Extend the set of modal-enabled pages programmatically by subscribing to the `account_modal.pages` event to add custom routes/forms.
- Theme the dialog per page using the generated `account-modal account-modal--<page>` dialog CSS classes.
- Combine with header/footer blocks to embed marketing copy or CAPTCHA-adjacent notices directly in the login dialog.
- Reduce perceived friction on gated content by surfacing login/register in place rather than sending users to `/user/login`.
