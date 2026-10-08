# Configuration

Configuring Agreement means creating one or more agreements, deciding who and what
they apply to, and assigning the three permissions carefully.

## Open the agreement list

1. Log in as a user with the **Administer agreements** permission.
2. Go to **Configuration → People → Agreement**
   (`/admin/config/people/agreement`).

This page lists all your agreements and lets you **add**, **edit**, and **delete**
them. Each agreement is a configuration entity, so your agreements travel with
`drush cex` / `drush cim` between environments.

## Create or edit an agreement

When you add or edit an agreement, you configure:

- **The agreement text** — the actual document (terms, policy, NDA, code of
  conduct). It is entered through a text format, so you can use formatted markup as
  your chosen format allows.
- **Target roles** — which roles must accept this agreement. Users in a targeted
  role are redirected to the agreement page until they accept. Users not in a
  targeted role are unaffected.
- **Paths** — where the agreement applies, so you can scope it (for example, only a
  members' area) rather than the whole site.
- **Re-acceptance rules** — whether and when users must accept again, for example
  after you update the terms.

Save the agreement when you are done. From that point, matching users are asked to
accept before they can continue, and their acceptance is recorded.

## Assign the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and set the three
permissions this module provides:

- **Administer agreements** — lets a role create and manage agreements. It is
  marked *restrict access*, so grant it only to trusted administrators.
- **Bypass agreement** — exempts a role/account from being interrupted by any
  agreement. **Assign this before you activate an agreement**, to your deployment,
  monitoring, and support accounts — otherwise they will be redirected to the
  agreement page on every request and appear broken.
- **Revoke own agreement** — lets a user withdraw a previously given acceptance.
  Enabling this supports the principle (and, under GDPR, the requirement) that
  consent should be as easy to withdraw as it is to give.

## Things to keep in mind

- The redirect intercepts requests site-wide for targeted users until they accept,
  so it can interfere with other redirecting modules and with automated tests. Use
  the path scoping and **Bypass agreement** to manage this.
- The module records *that* acceptance happened. Deciding the wording, how you
  version the document over time, and what happens when someone refuses are policy
  choices you make outside the module.
- Developers can extend acceptance handling via `agreement.api.php` and
  `AgreementHandlerInterface`.
