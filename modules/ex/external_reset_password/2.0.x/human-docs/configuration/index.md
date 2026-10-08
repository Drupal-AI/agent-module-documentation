# Configuration

The whole configuration of this module is a single field: the external URL that
password resets should point to.

## Open the settings form

1. Log in as a user with permission to administer the module.
2. Go to **Configuration → People → External Reset Password**
   (`/admin/config/people`).

## Set the external reset URL

Enter the full URL of the external resource that should handle password resets —
your identity provider's reset page, your SSO portal, or a custom reset page.
Then **save** the form.

Two things matter about this URL:

- **Trust it.** Users following your reset flow will be sent here, so it must be a
  destination you control or fully trust. Pointing password recovery at an
  untrusted URL would be an obvious security problem.
- **Use HTTPS.** Password recovery is a sensitive flow; the external page should
  be served over HTTPS so the exchange isn't exposed in transit.

## Clear the cache

After saving, **clear Drupal's cache** for the change to take effect
(`drush cr`, or Configuration → Development → Performance → Clear all caches).
Until you do, the old behavior may persist.

## Confirm the redirect

Trigger a password reset — for example from the login page's "Reset your password"
link — and confirm you are taken to the external URL instead of Drupal's built-in
reset form.
