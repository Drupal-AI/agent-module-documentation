# Configuration

Timeout Notification has one small settings form, plus one related setting that
lives in Drupal's services configuration rather than in the module.

## Open the settings form

1. Log in as a user who has the `configure_timeout_notification_settings`
   permission (grant it to your admin role under **People → Permissions** if you
   have not already).
2. Navigate to `/admin/config/timeout_notification`.

## The warning lead time

The form's main setting is **how many seconds in advance** users are notified of an
upcoming session expiry. By default this is **60 seconds** — meaning the warning
appears one minute before the session would end, giving the user time to click
through and refresh it. Increase it if your users need more warning; decrease it if
you want the prompt closer to the actual expiry. Save the form to apply.

## Aligning the session lifetime (services.yml)

The module warns *ahead of* the session's real lifetime, but it does not set that
lifetime — that is governed by PHP's session garbage-collection setting,
`gc_maxlifetime`, in your site's `sites/default/services.yml`. If that file does not
exist, create it from `default.services.yml`. Find the `gc_maxlifetime` value (the
default is 200000 seconds) and set it to the session length you actually want. When
a session is collected, authenticated users are logged out and the contents of their
`$_SESSION` are discarded — which is exactly the moment Timeout Notification is
warning them about, so it makes sense to set a deliberate lifetime here and then tune
the module's lead time to match.

## Save

Click **Save configuration** on the module's form. Changes to `services.yml` require
a cache rebuild (`drush cr`) to take effect.
