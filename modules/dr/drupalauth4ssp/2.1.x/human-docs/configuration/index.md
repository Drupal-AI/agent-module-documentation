# Configuration

DrupalAuth for SimpleSAMLphp keeps its Drupal‑side configuration small: a single
settings form and one security‑sensitive permission. The heavy lifting of
federation — the IdP metadata, the service‑provider trust relationships, attribute
mapping — happens in **SimpleSAMLphp**, outside Drupal. This page covers the
Drupal side and how the two connect.

## Lock down the permission first

The module provides a single permission, **`administer drupalauth4ssp
configuration`**, and it is flagged **restrict access: TRUE**. That is not a
formality: this permission controls federation trust, so granting it is
equivalent to granting site administration. Grant it only to a very small,
trusted set of administrators at **People → Permissions**
(`/admin/people/permissions`).

## Open the settings form

1. Log in as a user with the `administer drupalauth4ssp configuration`
   permission.
2. Go to **Configuration → People → DrupalAuth for SimpleSAMLphp**
   (`/admin/config/people/drupalauth4ssp`).

The form governs how Drupal hands off to SimpleSAMLphp after a successful login —
that is, how the module ties Drupal's authenticated session to the SimpleSAMLphp
IdP so it can return the user to the service provider that requested
authentication. Set the values to match your SimpleSAMLphp installation (its
location and the details the companion `drupalauth` SimpleSAMLphp module expects),
then save.

## How the pieces fit together

- A service provider sends an unauthenticated user to your SimpleSAMLphp IdP.
- SimpleSAMLphp, via the `drupalauth` companion module, defers to **Drupal's
  login form**.
- The user authenticates in Drupal; the companion module reads that session back.
- The module's `/drupalauth4ssp/redirect` route (available to logged‑in users)
  returns the user to the originating service provider, now authenticated.

## Harden the identity provider

Because a single Drupal login now unlocks every service that trusts the IdP,
treat this site as high‑value:

- Keep the configuration permission restricted to a handful of administrators.
- Add **two‑factor authentication** (the project suggests `drupal/tfa`).
- Audit which service providers rely on this IdP, and review account and role
  hygiene regularly.

## Save

Save the settings form, then run an end‑to‑end login test from a trusting service
provider (see [Installation → Verify it worked](../installation/index.md#verify-it-worked)).
