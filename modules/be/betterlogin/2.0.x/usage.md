Better Login restyles Drupal's user login, registration, password-request and password-reset pages into standalone, WordPress-style screens — working immediately on install with no configuration.

---

The module has no settings, routes, permissions or config (`configure: null`); enabling it is all you do. It registers four page templates — `page--user--login`, `page--user--register`, `page--user--password` and `page--user--reset` — each rendered through a preprocess that exposes `site_name`, `logo`, `title` and a conditional `register_url` (only set when the `user.register` route is accessible to the visitor). A `hook_form_alter` on the `user_login_form`, `user_register_form`, `user_pass` and `user_pass_reset` forms autofocuses the username field, strips the default name/password descriptions, and attaches the module's CSS library (`betterlogin/betterlogin_css`). `hook_preprocess_html` sets friendlier `<title>` tags (Login / Forgot your password? / Register / Reset password), and `hook_local_tasks_alter` removes the login/register/password local task tabs so the pages read as clean standalone screens. An event subscriber redirects anonymous requests that carry a `?user=` query parameter to the login form (with `destination=user`). To customise the look you either edit the shipped CSS or copy the templates from the module's `templates/` directory into your theme and override them; there is no admin UI.

---

- Give a Drupal site clean, standalone login/registration/password pages without building a theme for them.
- Get a WordPress-style login screen (logo, centered card, back-to-site link) out of the box.
- Autofocus the username field on the login form to speed up sign-in.
- Remove the noisy default field descriptions from the login and registration forms.
- Show the site name and logo on the auth pages automatically.
- Display a "Register a new account" link on the login page only when public registration is enabled.
- Provide a "Forgot your password?" link and a "Back to <site>" link on the login screen.
- Set clearer browser tab titles (Login, Register, Reset password) for the user pages.
- Hide the login/register/reset tab bar so each auth page looks like a dedicated screen.
- Redirect anonymous visitors hitting a `?user=` URL straight to the login form.
- Override the look by copying `page--user--login.html.twig` (etc.) into your own theme.
- Restyle auth pages by editing only CSS (`betterlogin/betterlogin_css`) if the markup is fine.
- Present a consistent branded sign-in experience across environments with zero config to export.
- Improve first-impression UX of member/community sites at the front door.
- Keep the auth pages usable while a heavy front-end theme is being developed.
- Match the login page's register link to the site's actual registration policy automatically.
- Provide accessible, focus-managed auth forms with minimal effort.
- Ship a login redesign as a simple module enable in a deployment.
- Use the four provided templates as a starting point for a fully custom auth design.
- Reduce support requests by making the password-reset flow visually obvious.
