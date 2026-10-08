<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailgun example email templates

## Theme hooks (`mailgun_email_templates_examples.module`)

`hook_theme()` registers three hooks, each a **suggestion of the parent Mailgun `mailgun` theme
hook** (`base hook => 'mailgun'`):

| Theme hook | Template file | Used for |
|---|---|---|
| `mailgun__test_form_email` | `templates/mailgun--test-form-email.html.twig` | The Mailgun admin "Test email" message. |
| `mailgun__password_reset` | `templates/mailgun--password-reset.html.twig` | The user password-reset email. |
| `mailgun__user` | `templates/mailgun--user.html.twig` | User-account emails. |

Because each declares `base hook => 'mailgun'`, they hook into the parent module's `mailgun`
render/mail pipeline as template suggestions; Drupal picks the matching one when Mailgun renders
that email.

## Verify they're registered

```php
$registry = \Drupal::service('theme.registry')->get();
isset($registry['mailgun__password_reset']);   // TRUE when the submodule is enabled
```

## Override in your theme

Copy the shipped template into your active theme and edit it — the theme copy wins:

```
themes/custom/mytheme/templates/mailgun--password-reset.html.twig
```

Then `drush cr`. Adjust markup/inline CSS/logo for your brand. There is nothing else to
configure: the submodule is purely presentation (no config, routes, permissions, or services).
It relies on the parent Mailgun module doing the actual sending.
