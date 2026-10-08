<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer Addons extends the Symfony Mailer module with configurable email footer links and two email "adjuster" plugins.
---
Its Email Footer Links feature (form at `/admin/config/system/mailer/email-footer-links`, permission `administer mail footer links`) lets admins define per-language footer links that are exposed to email templates as a `footer_links` variable. It also provides two Symfony Mailer adjuster plugins you add to a mailer policy: an Email Template Suggestion Adjuster (adds custom template suggestions for emails) and a Legacy Body Format Email Adjuster (fixes legacy body formats so HTML emails render correctly).

Setup: enable the module (requires Symfony Mailer), configure footer links per enabled language, and reference `footer_links` in your email templates. To use the adjusters, edit a Symfony Mailer policy and add the desired adjuster, then configure its settings. All configuration is admin-permission-gated; the module adds no anonymous or public endpoints.
---
- Add multilingual footer links to all Symfony Mailer emails.
- Configure footer links at `/admin/config/system/mailer/email-footer-links`.
- Define different footer links per site language.
- Reference `footer_links` in an email Twig template.
- Add custom template suggestions to emails via an adjuster.
- Fix legacy email body formats so HTML renders correctly.
- Attach the Template Suggestion Adjuster to a mailer policy.
- Attach the Legacy Body Format Adjuster to a mailer policy.
- Standardise footer content across transactional emails.
- Localize legal/unsubscribe links in email footers.
- Restrict footer-link management to trusted roles.
- Override email templates per suggestion added by the adjuster.
- Ensure consistent HTML rendering for migrated email policies.
- Keep footer links translatable alongside interface language.
- Provide policy-level control over email adjustments.
- Extend Symfony Mailer without custom code.
- Add per-language marketing links to the mail footer.
- Configure adjuster settings from the policy UI.
- Support Drupal 10 and 11 mail workflows.
- Centralise email footer maintenance in one form.
