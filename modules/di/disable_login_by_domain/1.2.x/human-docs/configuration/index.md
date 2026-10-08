# Configuration

Configuring Disable login by domain is a two-part job: list the domains where login
should be blocked, and make sure the domain the module sees is trustworthy.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Disable login by domain**, or navigate directly
   to `/admin/config/people/disable-login-by-domain`.

## List the domains to block

Enter the domains (hostnames) on which login should be disabled. On each listed
domain the module disables the login page, the user-login block, and the login form,
and it prevents a session from being established if a user reaches authentication by
another route. Everything you *don't* list continues to allow login as normal, so
the typical pattern is to block your public, legacy, marketing, or CDN-fronted
hostnames and leave login working only on the one host that should have it (for
example an editor hostname behind a VPN).

Save the form to apply your list.

## Make the restriction trustworthy

This is the part that's easy to overlook, and the module's authors call it out
directly.

- **Set Drupal's Trusted Host Settings.** The module determines the current domain
  from the `Host` / `X-Forwarded-Host` request header. A malicious visitor can try
  to send a header value that is *not* one of your blocked domains, slipping past the
  restriction. Configuring Drupal's trusted-host list in `settings.php` does not make
  bypass impossible, but it makes it substantially harder — set it if you have not
  already.
- **Remember what "login" covers.** Disabling the login form is not the same as
  disabling authentication. Verify the other entry points that can create a session
  on a blocked domain — password reset, any single sign-on callback, HTTP basic auth
  if it is enabled, and REST or JSON:API session requests. A restriction with gaps is
  worse than none, because people will trust it.

The maintainers describe this module as a convenience rather than a hardened security
control; treat it as one layer, alongside trusted-host settings and whatever
authentication controls your other entry points need.
