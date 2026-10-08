Nice Login restyles the three core user account pages (`/user/login`, `/user/password`, `/user/register`) by removing the default local-task tabs on those pages and injecting cross-links between the forms, plus a CSS wrapper you theme yourself.

---

Nice Login is a pure presentation module for the core user authentication pages. It implements `hook_form_FORM_ID_alter()` for `user_login_form`, `user_pass` and `user_register_form` to set a dedicated `#theme` (`nice_login__login` / `__pass` / `__register`), wrap each form in a `<div class="wrapper-nice-login …">`, and attach the `nice_login/form` library (`css/nice_login.css`). Each altered form gains contextual links: the login form gets "Forgot your password?" and (when registration is open) "Create an account?"; the password and register forms get a "Log in" link back. A `hook_preprocess_block()` empties the `local_tasks_block` on those three routes so the Login / Reset / Create tabs disappear, giving a single-purpose page. The "Create an account?" link respects `user.settings:register` — it is hidden when registration is admin-only. There is no configuration UI (`configure` is null), no permissions, no schema, and no server-side auth logic is changed — Nice Login only alters markup, theme hooks and attached CSS. The shipped CSS is minimal; the module expects you to style `.wrapper-nice-login` in your active theme.

---

- Give `/user/login`, `/user/register` and `/user/password` a consistent, branded look.
- Remove the Login / Reset password / Create account tabs (local tasks) from the account pages.
- Add a "Forgot your password?" link directly on the login form.
- Add a "Create an account?" link on the login form (auto-hidden when self-registration is disabled).
- Add a "Log in" link back on the password-reset form.
- Add an "already have an account? Log in" link on the registration form.
- Provide dedicated Twig templates (`nice-login--login/pass/register.html.twig`) to fully customise each form's markup.
- Wrap each auth form in a predictable `.wrapper-nice-login` container for CSS layout (e.g. centering).
- Center or grid the login form using your theme's own CSS (Bootstrap column mixins, flexbox, etc.).
- Ship a minimal starting stylesheet you override per theme.
- Keep auth-page theming out of your custom theme's `.theme` file by reusing this module's form alters.
- Present a cleaner single-purpose login page without building custom routes or controllers.
- Route users between login, register and reset without them hunting for the tabs.
- Match the account pages to a marketing/landing design.
- Localise the injected links (they use `t()` and core routes).
- Use as a lightweight base to layer a custom login experience on top of core.
