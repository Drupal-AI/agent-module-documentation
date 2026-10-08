# Configuration

Folder Tree has two things to get right: **where the tree is rooted** and **who
is allowed to browse it**. Both are security-relevant, because the tool exposes
your server's filesystem names to anyone with the permission.

## Set the root path

The module confines all browsing to a single **root path** — every AJAX request
is resolved with `realpath()` and rejected unless it resolves to a strict child of
that root, so users cannot traverse above it (and symlinks pointing outside are
blocked).

1. Log in as a user with the **Administer site configuration** permission.
2. Open Folder Tree's settings form from its admin page.
3. Set the **root path** to the narrowest directory you actually need to inspect.

The default is the Drupal root. **Do not set it to `/`** — that would expose the
entire server filesystem to permitted users. Point it at the specific directory
you want people to be able to inspect (for example a files or logs directory)
instead.

## Grant the permission

Folder Tree provides its own permissions, which gate both the browser page and its
AJAX endpoint (unpermitted requests get a 403 before any filesystem access
happens):

- **`access folder tree`** — lets a user open and browse the tree.
- **`administer folder tree`** — lets a user change the module's settings,
  including the root path.

Grant these at **People → Permissions** (`/admin/people/permissions`).

**Grant `access folder tree` only to trusted administrators.** Even though the
tool is read-only and traversal-protected, it still reveals the names and
structure of files under the root — which is information you may not want ordinary
editors to see. Treat it like shell-level visibility into that directory.

## Save

Save the settings form. The new root path takes effect immediately; browse the
tree to confirm it is rooted where you expect.
