<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailgun Email Templates Examples — agent index

Submodule of **Mailgun**. Ships example HTML email Twig templates so common Drupal emails render
as styled HTML. No config, routes, permissions, services, or Drush — enabling it is the setup.

- **The theme hooks it registers, the template files, and how to override them** →
  [theming/templates.md](theming/templates.md)

Key facts:
- `hook_theme()` registers `mailgun__test_form_email`, `mailgun__password_reset`, `mailgun__user`,
  each with `base hook => 'mailgun'` (template suggestions of the parent Mailgun `mailgun` hook).
- Templates: `templates/mailgun--test-form-email.html.twig`,
  `mailgun--password-reset.html.twig`, `mailgun--user.html.twig`.
- Depends on the parent `mailgun` module. Parent docs: `modules/mailgun/2.1.x/`.
