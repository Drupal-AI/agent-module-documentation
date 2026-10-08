# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Prevent page deletion**, or navigate directly
   to `/admin/config/system/prevent-homepage-deletion`.

## Which pages are always protected

Three pages are protected automatically, without you listing them anywhere,
because the module reads them from your site's basic settings:

- The **front page** node (from *Configuration → System → Basic site settings*).
- The **404 "Page not found"** node, if you've set a custom one.
- The **403 "Access denied"** node, if you've set a custom one.

If you later change which node is your front page, protection follows the new node
automatically.

## Protecting extra pages

The form has a single field, **"Protect these URL's"** — a textarea where you add
any additional pages you want protected, one per line. For example:

```
/node/12
/node/34
/about-us
```

Rules for the list:

- **Start each line with a `/`.** A line without a leading slash is ignored (it
  protects nothing).
- **One path per line.**
- **No wildcards.** `/blog/*` is not supported — list the specific paths.
- Both raw node paths (`/node/12`) and path aliases (`/about-us`) work, as long as
  they resolve to a real node.

Click **Save configuration** when done. (On a brand-new install the list is empty
until you save the form once — only the front/404/403 pages are protected in the
meantime.)

## What protection does

For any protected node, and for any user without the **Delete homepage node**
permission:

- The **Delete** tab and the delete link in the content overview disappear, and
  visiting `/node/N/delete` returns "access denied".
- The **Published** checkbox is removed from the node's edit form, so the page
  can't be unpublished. (An already-unpublished node can still be re-published — the
  block only applies while the node is published.)
- Bulk **Delete content** actions on the content overview skip protected nodes and
  show a message explaining why.

## Good to know

- The protected list is stored as configuration, so it exports and imports with
  your normal config workflow — handy for keeping the same protections across
  environments. You can audit what's protected by reading that one config value.
- Core's **Bypass content access control** permission (and user 1) override this
  module completely — such users can always delete protected nodes.
- After changing the settings, you may need a cache clear (`drush cr`) before the
  Delete tab/links reflect the new state.
