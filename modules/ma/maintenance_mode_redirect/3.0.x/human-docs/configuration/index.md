# Configuration

The module adds its options to Drupal core's maintenance settings — there's no
separate page.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Maintenance mode**
   (`/admin/config/development/maintenance`).

## Enable URL redirect

A checkbox turns the feature on. When ticked, visitors who cannot access the site
during maintenance are redirected instead of seeing Drupal's default maintenance
page. Leave it unchecked to fall back to the normal maintenance page.

## Redirect URL

Enter the destination visitors should be sent to during maintenance — a valid
URL such as a status page or a holding page hosted elsewhere. This value is set
by you, the administrator, so it is always a trusted destination.

## Allowed paths

You can list paths (and path-prefix exceptions) that should **not** be
redirected. This is important: keep your **admin and login paths allowed** so
that you can still log in and reach the maintenance settings to switch
maintenance mode back off. Without that exception you could redirect yourself
away from the very page you need to disable the redirect.

## Save

Click **Save configuration**. The redirect takes effect while maintenance mode
is enabled. Before relying on it, test the flow — including that you can still
reach the login/admin pages — from an anonymous browser session.
