<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailgun Email Templates Examples is a small submodule of Mailgun that ships ready-made HTML email Twig templates so common Drupal emails (password reset, user account, the Mailgun test email) render as styled HTML out of the box.

---

The submodule implements `hook_theme()` to register three theme hooks — `mailgun__test_form_email`, `mailgun__password_reset`, and `mailgun__user` — each declared with `base hook => 'mailgun'`, meaning they are template suggestions of the parent Mailgun module's `mailgun` theme hook. The matching Twig files live in the submodule's `templates/` directory (`mailgun--test-form-email.html.twig`, `mailgun--password-reset.html.twig`, `mailgun--user.html.twig`). When Mailgun renders an email whose mail key/context matches one of these suggestions, Drupal's theme system picks up the example template and produces a nicely formatted HTML message instead of plain text. The submodule has no configuration, no routes, no permissions, and no services — enabling it is the entire setup; you then customize the emails by overriding these templates in your own theme. It depends on the parent Mailgun module (whose `mailgun` base theme hook and mail rendering it extends).

---

- Get styled HTML password-reset emails without writing a template from scratch.
- Provide a branded HTML template for user-account notification emails.
- Render the Mailgun admin "Test email" as formatted HTML to preview styling.
- Use the shipped templates as a starting point and override them in a custom theme.
- Give a site professional-looking transactional emails out of the box.
- Learn the correct Twig structure for a Mailgun HTML email template.
- Add a `mailgun--<suggestion>.html.twig` override in your theme based on these examples.
- Enable HTML email theming quickly for a demo or prototype site.
- Serve as a reference for the `base hook => mailgun` template-suggestion pattern.
- Standardize the look of Drupal's core account emails when sent through Mailgun.
- Replace Drupal's plain-text default mails with HTML equivalents for key flows.
- Copy a template into a theme and adjust colors/logo for brand consistency.
- Demonstrate how Mailgun's `use_theme` / HTML rendering combines with templates.
- Provide example markup that works across common email clients.
- Bootstrap an email design system for a new Drupal project.
- Show editors/stakeholders sample HTML emails during a build.
- Keep example templates isolated in a submodule you can disable in production.
- Pair with the parent Mailgun module's `format_filter` to control body rendering.
