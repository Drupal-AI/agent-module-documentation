# Configuration

Domain Site Settings gives you one administration form where you set the basic
identity of each domain.

## Open the settings form

1. Log in as a user with the **`domain site settings`** permission.
2. Go to **Configuration → Domain → Domain Site Settings**, or navigate directly to
   `/admin/config/domain/domain_site_settings`.

## Per-domain fields

For each domain you can override the basic site settings that Drupal would
otherwise apply install-wide:

- **Site name** — the name shown for this domain (in the browser title, some
  themes, emails, etc.).
- **Slogan** — the site slogan/tagline for this domain.
- **Email address** — the "site email" this domain sends from and shows as its
  contact address.
- **Front page** — the path used as the home page on this domain.
- **404 (page not found) page** — the path shown for not-found errors on this
  domain.
- **403 (access denied) page** — the path shown for access-denied errors on this
  domain.

Set the values you want for each domain and **save**. Visitors on a given domain
then see that domain's name, slogan, email, and front/error pages instead of the
global defaults.

## Restrict who can edit

The form is gated by the **`domain site settings`** permission. Grant it only to
trusted per-domain editors, since these values change how each domain identifies
itself.

## A reminder about the future

This module is deprecated. When you have the opportunity, migrate this per-domain
configuration to **Domain Config** / **Domain Config UI**, which is the supported
long-term way to override configuration (including these basics) per domain. See
the module's project page for the upgrade-path issue.
