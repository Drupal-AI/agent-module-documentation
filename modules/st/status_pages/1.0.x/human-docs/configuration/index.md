# Configuration

Setup has two parts: writing the text for the status pages, and telling Drupal to
use the module's paths as its error pages.

## Edit the page texts

1. Log in as an administrator.
2. Go to **Configuration → System → Status pages settings**
   (`/admin/config/system/status-pages-settings`).
3. Enter the text you want to show on the **403 (access denied)** and **404 (not
   found)** pages, then save.

The module renders these texts through its own templates, so both pages keep a
consistent style with each other (and you can override the templates in your theme
if you want a different look).

## Point core's error pages at the provided paths

The module provides the pages at fixed paths, but you still need to tell Drupal to
use them:

1. Go to **Configuration → System → Basic site settings**
   (`/admin/config/system/site-information`).
2. In the **Error pages** section, set:
   - **Default 403 (access denied) page** to `/page-403`.
   - **Default 404 (not found) page** to `/page-404`.
3. Save.

Because these paths are provided by the module rather than by content you create,
they exist on every environment automatically — so the same configuration works on
dev, staging, and production with nothing to keep in sync.

## Verify it worked

Visit a URL that does not exist (for example `/this-page-does-not-exist`) — you
should see your configured 404 page. Visit a page you do not have permission to see
to confirm the 403 page.
