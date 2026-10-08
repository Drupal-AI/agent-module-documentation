# Affiliated — manual setup guide

**Affiliated** (`affiliated`) provides the common building blocks for running an
affiliate / referral program on a Drupal site. It tracks affiliates and the
referrals they bring in, and — through optional submodules — ties those referrals
to Commerce orders, user registrations, or Webform submissions so you can
attribute activity and calculate commissions. It depends on core **Views** and
**User**, and provides its own permissions.

The base module gives you the affiliate and referral tracking; you then enable
only the submodules that match how referrals convert on your site:

- **Affiliate Commerce** (`affiliate_commerce`) — attribute referrals to Commerce
  orders (for order-based commissions).
- **Affiliate Registrations** (`affiliate_registrations`) — attribute referrals
  to new user registrations.
- **Affiliate Webform** (`affiliate_webform`) — attribute referrals to Webform
  submissions.

**A note on data and security.** Affiliate and referral records tie to real users
and, with the Commerce submodule, to orders and commission amounts — that is
personal and financial data. Grant the affiliate-administration permissions only
to trusted operators. And because referral codes are visible to the people using
them, never treat a referral code as a security token or trust it for access
decisions; use it only for attribution.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on these docs:** the available reference material for this module is
> brief, and it is an alpha release. This page describes what it does and how to
> install it; the specific admin screens are not documented here. After enabling
> it, review its permissions under **People → Permissions** and look for its
> options in the admin menu.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.

## How to use it

1. Install and enable the base **Affiliated** module.
2. Enable the submodule(s) that match how your referrals convert — Commerce
   orders, user registrations, and/or Webform submissions.
3. Under **People → Permissions**, grant the affiliate-administration permissions
   only to the roles that should manage the program.
4. Set up your affiliates and let them share their referral links; the module
   records referrals and, via the submodules, attributes conversions for
   commission or reporting.
