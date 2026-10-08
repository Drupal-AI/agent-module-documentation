# Configuration

Setting Adnuntius up has two parts: telling Drupal about your Adnuntius account
and ad units, then placing the ad blocks where you want ads to appear.

## Open the settings form

Go to the module's settings (the `adnuntius.settings` form) as a user with the
appropriate permission. This is where you connect Drupal to your Adnuntius
account.

## Configure your account and ad units

Enter your Adnuntius account / ad-unit details in the settings form so the module
knows which ads to request from the platform. These identifiers come from your
Adnuntius account — set up the ad units on the Adnuntius side first, then reference
them here.

## Place the ad blocks

The module exposes its ads as Drupal blocks. Go to **Structure → Block layout**
(`/admin/structure/block`), place the Adnuntius block into the theme region where
you want ads to show, and configure its visibility (which pages, roles, and so on)
using Drupal's standard block settings. Repeat for each ad placement you need.

## Permissions

The module provides its own permissions — review them on **People → Permissions**
(`/admin/people/permissions`) and grant them to the roles that should manage the
Adnuntius configuration.

## Before ads go live — privacy and CSP

Because ads are delivered by Adnuntius's client-side JavaScript, handle these
before publishing:

- **Consent / privacy.** Ad delivery and tracking are subject to privacy law in
  many regions. Disclose the advertising in your privacy policy and gate the ad
  scripts through your consent tooling where consent is required.
- **Content-Security-Policy.** If your site sets a CSP, allow the Adnuntius
  script/host so the ad units can load; otherwise the browser will block them.

Test on a non-production environment and confirm ads render (and that they respect
your consent settings) before going live.
