# Symfony Mailer Addons — manual setup guide

**Symfony Mailer Addons** (`symfony_mailer_addons`) adds extra functionality on
top of the **Symfony Mailer** module. It bundles three related features:

- **Email Footer Links** — a form where administrators define footer links, one
  set per enabled language, which are then exposed to your email templates as a
  `footer_links` variable. Use it to keep footer content (legal links,
  unsubscribe links, marketing links) consistent and translated across all the
  transactional email your site sends.
- **Email Template Suggestion Adjuster** — a Symfony Mailer *adjuster* plugin
  that registers extra Twig template suggestions, so you can theme specific
  emails.
- **Legacy Body Format Email Adjuster** — another adjuster plugin that
  normalises legacy email body formats so HTML emails render correctly.

The module depends on **Symfony Mailer** (`symfony_mailer`) and works on Drupal
10 and 11. The footer-links feature is ready to configure as soon as you enable
the module; the two adjusters do nothing until you add them to a Symfony Mailer
policy. All of its configuration is gated behind admin permissions — there are
no anonymous or public endpoints.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up the footer links and attach
   the adjuster plugins to a mailer policy.

## Where it lives in the admin menu

The Email Footer Links form sits at **Configuration → System → Mailer → Email
footer links** (`/admin/config/system/mailer/email-footer-links`), a local task
alongside Symfony Mailer's policy configuration. Managing it requires the
**administer mail footer links** permission. The two adjuster plugins are not a
page of their own — you add them from within a Symfony Mailer policy, at the
Mailer policy configuration.
