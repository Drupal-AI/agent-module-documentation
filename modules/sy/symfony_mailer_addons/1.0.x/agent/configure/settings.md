<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer Addons — configuration

## Email footer links
Form `Drupal\symfony_mailer_addons\Form\EmailFooterLinksForm` at `/admin/config/system/mailer/email-footer-links` (permission `administer mail footer links`, local task under the Mailer policy collection).

1. Add one or more links for each enabled language.
2. In your email templates, output the `footer_links` variable to render them.

## Email adjusters (Symfony Mailer policy)
Two adjuster plugins are provided; add them to a Symfony Mailer policy at the Mailer policy configuration:
- **Email Template Suggestion Adjuster** — registers extra template suggestions so you can theme specific emails.
- **Legacy Body Format Email Adjuster** — normalises legacy body formats so HTML emails render correctly.

Configure each adjuster's settings on the policy after adding it.
