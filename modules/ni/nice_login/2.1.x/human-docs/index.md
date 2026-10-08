# Nice Login — manual setup guide

**Nice Login** (`nice_login`) gives Drupal's three core account pages —
`/user/login`, `/user/password`, and `/user/register` — a cleaner, single-purpose
look. It removes the row of Login / Reset password / Create account tabs from
those pages and, in their place, adds friendly cross-links directly on each form:
"Forgot your password?" and "Create an account?" on the login form, and a "Log in"
link back on the password-reset and registration forms.

It is a pure presentation module. It does not change any authentication logic — it
only alters the markup, sets dedicated theme hooks, and attaches a small
stylesheet. Each form is wrapped in a predictable `.wrapper-nice-login` container
so you can lay it out (centre it, put it in a column, etc.) with your theme's own
CSS. The shipped stylesheet is intentionally minimal; the real styling is expected
to come from your active theme.

The "Create an account?" link respects Drupal's registration setting — it is
hidden automatically when self-registration is set to administrators only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no settings form and no permission to grant — the module has no
configuration UI. Once enabled, it takes effect on the three account pages
immediately. Customising it is a theming job:

- **Style the layout.** Add CSS rules for `.wrapper-nice-login` (and the
  per-page state classes `login-form`, `reset-password-form`,
  `create-account-form`) in your active theme — for example flexbox or column
  rules to centre the login form.
- **Override the markup.** The module provides three Twig templates,
  `nice-login--login.html.twig`, `nice-login--pass.html.twig`, and
  `nice-login--register.html.twig`. Copy any of them into your theme to fully
  control that form's markup (standard Drupal template override rules apply).
- **Tabs on custom themes.** Nice Login blanks the local-tasks block on these
  routes to hide the tabs. If your theme renders local tasks by some other
  mechanism, you may need to hide them there too.
