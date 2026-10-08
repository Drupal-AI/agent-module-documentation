# Configuration

Only One has two admin pages: one to choose which content types are restricted,
and one for two behavior options. Both require the *Administer onlyone*
permission.

## Choose which content types are restricted

1. Log in as a user with the **Administer onlyone** permission.
2. Go to **Configuration → Content authoring → Only One**, or navigate directly
   to `/admin/config/content/onlyone`.
3. Tick the content types that should allow only one node per language, and click
   save.

Your selection is stored in the `onlyone.settings` config (as a list of content
type machine names), so it can be exported and deployed with configuration
management. Out of the box, nothing is restricted. If a content type is later
deleted, the module cleans it out of this list automatically.

## The two behavior options

Go to `/admin/config/content/onlyone/settings` for these:

- **Separate "Add content (Only One)" menu entry** — when enabled, your
  restricted content types are moved out of the standard *Add content* list into
  a dedicated **Add content (Only One)** action link (at `/onlyone/add`), leaving
  the normal *Add content* list showing only the non-restricted types. Toggling
  this rebuilds the site's routes. Off by default.
- **Redirect to the edit form** — controls what happens when an editor tries to
  add a restricted type that already has a node. When on (the default), they are
  taken to the existing node's **edit form**; when off, they are taken to the
  existing node's **published (canonical) page** instead.

## What editors see

Once a content type is restricted and a node of it exists:

- Clicking *Add content* for that type redirects to the existing node (edit form
  or page, per the option above).
- If code or an import attempts to save a genuine second node of that type in the
  same language, Drupal shows a validation error and blocks the save.
- On a multilingual site, each language may still hold its own single node of the
  restricted type, so translations are unaffected.
