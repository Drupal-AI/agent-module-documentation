# consentmanager core — manual setup guide

**consentmanager core** (`consent_manager`) is the base module for wiring the
commercial [consentmanager.net](https://www.consentmanager.net/) Consent
Management Provider (CMP) into your Drupal site. consentmanager.net is a hosted
service that shows visitors a cookie/consent banner and records their choices so
your site can stay GDPR- and CCPA-compliant. This module is the glue that lets
you embed the vendor's products without hand-editing your theme templates.

On its own, the core module renders **nothing** on the front end and has no
settings of its own — it simply provides the shared plumbing (a plugin type, a
generic block, and a reusable settings form) that the individual integrations
build on. The actual features ship as submodules: the cookie banner
(`consent_manager_cmp`), analytics loading (`consent_manager_analytics`), a data
subject rights form (`consent_manager_dsr`), a privacy policy page
(`consent_manager_pcp`), and whistleblowing (`consent_manager_wb`). You enable
only the products your site needs.

Each product is keyed by a **Code-ID** from your consentmanager.net account. The
settings form for a product includes an **Install now** button that opens the
consentmanager.net onboarding popup; when you finish, it automatically fills the
Code-ID and delivery hosts back into the form. You will need a consentmanager.net
account to obtain those IDs — this module does not include the service itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the product submodules you need.
2. [Configuration](configuration/index.md) — the shared admin area, the single
   admin permission, and how each product's settings form (and the "Install now"
   onboarding flow) works.

## Where it lives in the admin menu

All consentmanager pages are grouped under **Configuration → consentmanager**
(`/admin/config/consent-manager`). The base module only creates that container —
the individual settings forms appear there once you enable the matching product
submodules. Every one of those forms is gated by the single **Administer consent
manager settings** permission, which is a restricted/trusted-admin permission.

## How to use it

1. Install and enable `consent_manager` plus at least one product submodule (for a
   cookie banner, that is `consent_manager_cmp`).
2. Go to that product's settings form under **Configuration → consentmanager**.
3. Either paste your consentmanager.net Code-ID directly, or click **Install now**
   and complete the onboarding popup to have the Code-ID filled in for you.
4. Save. The product's snippet is now emitted on your site's front-end pages
   (banner and analytics products inject themselves automatically; block-based
   products such as the DSR form or privacy policy are placed through Drupal's
   normal **Block layout** as a *consent_manager* block).

Because these products inject vendor `<script>` markup into every front-end page,
treat the **Administer consent manager settings** permission as highly sensitive
and grant it only to administrators you trust.
