# Configuration

All of GTM's configuration lives on one small settings form. You enter your
container ID, turn injection on, and decide where the snippet should fire.

## Open the settings form

1. Log in as a user with the **Administer GTM** permission (an administrator by
   default).
2. Go to **Configuration → System → Google Tag Manager**, or navigate directly to
   `/admin/config/system/gtm`.

## The settings, field by field

- **GTM-ID** — your Google Tag Manager container ID, in the form `GTM-XXXX` (copy it
  from your GTM account). Nothing is injected while this is empty. The module
  cleans the value to letters, numbers, and hyphens before writing it into the
  page.
- **Enable Google Tag Manager** *(off by default)* — the master switch. Until this
  is ticked, no snippet is added anywhere, regardless of the other settings. This
  is also your quick "kill switch": untick it to instantly remove all GTM tags
  site-wide (handy in an incident).
- **Display Google Tag Manager on admin pages** *(off by default)* — by default the
  container only loads on front-end (non-`/admin`) pages, so back-office activity
  is not tracked. Tick this if you deliberately want to track editorial workflows
  on admin pages too.
- **Disable for admin** *(off by default)* — when ticked, GTM is suppressed for the
  superuser (user 1), so your own visits during development and QA are not
  tracked. Note this exclusion applies to user 1 specifically.

## Save

Click **Save configuration**, then clear caches (`drush cr`) if the change does not
appear immediately. With **Enable** on and a container ID set, the two-part GTM
snippet is added to matching pages: an inline script in the `<head>` that boots the
`dataLayer` and loads `gtm.js`, plus a hidden `<noscript>` iframe near the top of
the `<body>` as a fallback for visitors without JavaScript.

## When does the snippet actually appear?

The container is injected on a page only when **all** of these are true:

1. **Enable** is on, and
2. a **container ID** is set, and
3. either **Display on admin pages** is on, or the page is not an admin page, and
4. it is not the case that the visitor is user 1 while **Disable for admin** is on.

## A note on what this module does and does not do

This module only injects the container bootstrap. It does not configure any tags,
triggers, or variables — those all live in the Google Tag Manager web UI. That is
the whole point of Tag Manager: once the container is on your site, you add and
change tracking in Google's interface without touching Drupal again. Other modules
or your own JavaScript can push custom values onto `window.dataLayer` for your GTM
triggers to use.

## Staging vs production

Because everything is stored in the `gtm.settings` config object, you can manage
it with Drupal's configuration system and CI/CD. A common pattern is to stage a
container ID in config but leave **Enable** off until go-live, or to override the
container ID per environment so staging and production use different containers.
