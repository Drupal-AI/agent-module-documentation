# Configuration

Dynamic Path Rewrites does nothing until you create at least one **path rewrite**.
Each rewrite is a small piece of configuration that maps an entity type's real
route to a custom base path. Rewrites are stored as configuration entities, so they
export cleanly with `drush config:export` and move between environments like any
other config.

## Open the rewrites list

1. Log in as a user with the **Administer dynamic path rewrites** permission (grant
   this only to trusted administrators — see below).
2. Go to **Configuration → Search and metadata → URL aliases → Rewrite**, or
   navigate directly to `/admin/config/search/path/rewrite`.

You'll land on the **Path rewrites** listing, showing any rewrites you've already
created with edit and delete links, plus an **Add path rewrite** button.

## Add a path rewrite

Click **Add path rewrite** and fill in the form:

- **Target route / system path** — the entity route you want to rewrite. The form
  provides an **autocomplete** field: start typing (for example `node`) and it
  looks up matching router paths for you, so you don't have to know the exact
  internal route name. This is the "real" path the rewrite points back to.
- **Custom base path** — the friendly path you want visitors to see, such as
  `/article` or `/blog-post`. The entity's own identifier is appended
  automatically, giving URLs like `/article/123`.
- **Bundle (where offered)** — because rewrites can vary per bundle, you can point
  different content types at different base paths — articles to `/article` and blog
  posts to `/blog-post`, for example — by creating one rewrite per bundle.

Save the form. The rewrite takes effect immediately: incoming requests to the
custom path are resolved back to the real route, and links Drupal generates for
those entities come out in the custom form. Results are cached, so the rewrite adds
no meaningful per-request cost after the first hit.

## A worked example

To serve articles at `/article/{id}` and blog posts at `/blog-post/{id}`:

1. Add a path rewrite whose target is the node canonical route and whose custom
   base path is `/article`, scoped to the *Article* bundle.
2. Add a second rewrite for the same route with base path `/blog-post`, scoped to
   the *Blog post* bundle.

Both content types keep their normal editing experience; only their public URLs
change.

## Remember: no tokens

There is intentionally no token support here — a rewrite is always a fixed base
path plus the entity identifier. If you need URLs built from field values or
patterns (like the title or a date), use
[Pathauto](https://www.drupal.org/project/pathauto) instead. This module trades
that flexibility for the ability to change paths across thousands of entities
without storing an alias for each one.

## A note on access

Both the rewrites admin screen and its autocomplete helper require the
**Administer dynamic path rewrites** permission and are marked as
access‑restricted. Keep this permission limited to administrators — changing a
rewrite changes public URLs site‑wide.
