# Configuration

The settings form lives at **Configuration → Search and metadata → Redirect 404 to Home
Page** (`/admin/config/search/redirect404_home`), behind the **Administer site
configuration** permission. It has three fields, all stored in the
`redirect404_home.settings` config object.

## The three settings

- **Redirection (HTTP status code)** — a dropdown offering **301**, **302**, **303**, or
  **307** (default **301**). Use **301** (permanent) when you want search engines to drop
  the missing URLs; use **302/303/307** (temporary) while a site is being restructured.
  307 preserves the request method.
- **Status message** — optional text shown to the visitor after the redirect (for
  example, "The page you requested was moved."). Leave it empty for no message.
- **Status message color** — how that message is styled: **status** (default), **warning**,
  or **error**, using Drupal's standard message styling.

Click **Save configuration** to apply.

## Setting the values with Drush

```bash
drush cset redirect404_home.settings redirection 302 -y
drush cset redirect404_home.settings status_message 'That page has moved.' -y
drush cset redirect404_home.settings status_message_color warning -y
```

## Making sure the module is reached

As noted in [Installation](../installation/index.md), the redirect only fires when core
routing falls through to `system.404`. Keep the site's **Default 404 (not found) page**
empty (`drush cset system.site page.404 '' -y`) and clear caches (`drush cr`).

## Important: the redirect-loop caveat (verified on Drupal 11)

In the 2.0.x release the module's controller redirects to the `system.404` route — which
resolves to the path `/system/404`, the very route this module has overridden. The result
observed on Drupal 11 is:

1. A request for a missing page returns `301 → /system/404`.
2. `/system/404` again returns `301 → /system/404`.

That is an **infinite redirect loop**, not a redirect to the front page that the module's
name and description imply. You can reproduce it with `curl -sI <site>/does-not-exist` and
seeing `Location: /system/404`.

Before relying on this module, confirm the behavior on your exact version. A working
"send all 404s to the front page" outcome would require the controller to target the
site's front page (`<front>`) rather than `system.404`. If you hit the loop, the safest
course is to leave the module disabled until a fixed release, or to test any patched
version on a staging copy first.

## Turning it off

Uninstalling the module restores core's normal `system.404` behavior — the 404 page comes
back. Its config is removed on uninstall.
