View Password adds a "show/hide password" eye toggle button next to password fields on the forms you choose, so users can reveal what they typed before submitting.

---

View Password enhances password inputs with a client-side reveal toggle. You list the form IDs that should get the feature at **Admin → Configuration → System → View Password Settings** (`/admin/config/system/view-password-settings`); the default is `user_login_form`. A `hook_form_alter()` matches each configured form ID, tags the form with the `pwd-see` CSS class, and attaches the `view_password/pwd_lb` library (jQuery + `core/once` + drupalSettings). The `password.js` behavior inserts a `<button class="shwpd eye-close">` after every password field inside a `.pwd-see` form; clicking it toggles the field's `type` between `password` and `text`, swaps the eye-open/eye-close icon, and updates the button's `aria-label` between the "Show password" and "Hide password" labels for accessibility. Site builders can style the button by supplying extra `span_classes`, and can replace the default open/closed eye SVGs by entering root-relative paths (starting with `/`) to their own `icon_exposed` and `icon_hidden` images. Settings are stored in the `view_password.settings` config object (config schema provided) and gated by the `administer view password` permission. It requires no modules outside Drupal core.

---

- Add a show/hide eye toggle to the default user login form's password field.
- Let users reveal the password they typed on the user registration form before submitting.
- Enable the reveal toggle on a custom form by adding its form ID to the settings.
- Apply the toggle to several forms at once with a comma-separated list of form IDs.
- Reduce failed logins caused by mistyped passwords on the login screen.
- Improve password-entry UX on mobile where typing is error-prone.
- Give the toggle button custom CSS hooks via the `span_classes` setting.
- Replace the default open-eye icon with a brand-specific SVG (`icon_exposed`).
- Replace the default closed-eye icon with a custom SVG (`icon_hidden`).
- Provide accessible reveal controls with `aria-label` that flips between Show/Hide password.
- Restrict who can configure the feature with the `administer view password` permission.
- Deploy the list of enabled forms as configuration across environments.
- Add the toggle to a password-reset or change-password form by its form ID.
- Toggle password visibility without any server round-trip (pure client-side JS).
- Style the toggle button consistently in the admin theme via the backend library.
- Confirm a strong generated password is entered correctly before saving.
- Validate that entered form IDs contain no spaces (enforced by the settings form).
- Enforce that custom icon paths start with a leading slash (settings validation).
- Scope the JS to only the chosen forms via the `pwd-see` class so other forms are untouched.
- Cache-tag altered forms on `config:view_password.settings` so changes invalidate correctly.
- Help users on multi-field forms (e.g. password + confirm) verify both entries match.
