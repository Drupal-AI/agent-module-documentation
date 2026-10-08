Simple Login restyles Drupal's anonymous user pages — login, register, and password-reset (`/user`, `/user/login`, `/user/register`, `/user/password`) — with a full-page background image or color, a centered form card, and placeholder-style inputs, all configured from one admin form.

---

For anonymous visitors on the supported user paths, the module swaps in a dedicated page template (`page--simplelogin.html.twig`), adds a `simplelogin` body class, and injects inline CSS that sets either a background image (a managed file) or a solid background color, optional opacity, and optional button/link coloring. It converts form field labels to placeholders (and can visually hide the labels) on the login, register, and password forms, relabels the login button to "Login to Account", and can strip the active theme's CSS (or specific stylesheets) from these pages for a clean look. All behavior is driven by the `simplelogin.settings` config object (admin form at `/admin/config/simplelogin`, route `simplelogin.admin_settings_form`, permission `administer site configuration`): `background_active` toggles image-vs-color, `background_image` holds the managed file id(s), `background_color` is the color, `background_opacity` and `button_background` are booleans, `wrapper_width` sets the form card width (default 360), `unset_active_css`/`unset_css` remove stylesheets, and `visually_hidden_labels` hides labels. The set of themed paths can be extended with `hook_simplelogin_paths_alter()`, and a theme can override the page template by placing its own `templates/page--simplelogin.html.twig`. The module has no dependencies, no plugins, and no Drush.

---

- Put a full-page background image behind the Drupal login form.
- Use a solid brand background color on the login/register/password pages instead of an image.
- Center the login form in a card and control its width via `wrapper_width`.
- Show field placeholders instead of labels on the login and registration forms.
- Visually hide form labels (kept for screen readers) with `visually_hidden_labels`.
- Rename the login submit button to "Login to Account" automatically.
- Apply a semi-transparent overlay to the background image with `background_opacity`.
- Tint the submit buttons and links with the configured color via `button_background`.
- Remove the active theme's CSS from the login pages for a minimal look (`unset_active_css`).
- Strip specific stylesheets from the login pages by path (`unset_css`).
- Give the register and password-reset pages the same branded background as login.
- Style the anonymous `/user` page consistently with login.
- Add a custom user path (e.g. `/user/sso`) to the themed set via `hook_simplelogin_paths_alter()`.
- Override the login page markup by adding `page--simplelogin.html.twig` to your theme.
- Present the site logo, name, and slogan on the styled login card.
- Provide a polished login experience without building a custom theme.
- Configure everything from a single form at `/admin/config/simplelogin`.
- Export the `simplelogin.settings` config to deploy the login styling across environments.
- Keep the login card readable over a busy background image using opacity.
- Match the login page background color to a campaign or seasonal theme.
- Offer a distraction-free registration page by hiding theme chrome.
- Set a wider login card (e.g. 500px) for forms with more fields.
