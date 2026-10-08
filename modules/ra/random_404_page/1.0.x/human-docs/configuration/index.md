# Configuration

Random 404 page has no settings page of its own. All configuration happens on
core's **Basic site settings** form, which the module extends once enabled.

## Open the form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Basic site settings**, or navigate directly
   to `/admin/config/system/site-information`.

The module hides core's single **Default 404 page** and **Default 403 page**
fields and replaces them with two text areas.

## 404 pages

Enter one internal path per line — for example:

```
/node/12
/404-friendly
/oops
```

Each path is validated when you save, using Drupal's core path validator. A path
that doesn't exist, or one that *you* cannot access, is rejected with an error, so
you can't accidentally save a broken or restricted target. When a real 404 is
raised, the module picks one line at random and serves it, keeping the 404 HTTP
status.

Leave this area empty to fall back to Drupal's normal (single or default) 404
handling.

## 403 pages

Works exactly the same way, but for **access denied** (403) errors. Enter one
path per line; a random one is served on each 403, with the 403 status preserved.
The two pools are independent, so your "not found" and "access denied" rotations
never mix.

## Save

Click **Save configuration**. Your paths are stored in the
`random_404_page.settings` config object (under `404_pages` and `403_pages`), so
they travel with a normal configuration export/import between environments. The
new behavior takes effect immediately — trigger a missing URL to see a random
page appear.
