# Configuration

Files and Folders has a settings form for how and where it stores uploads and how
the manager looks, plus a per‑folder access model you set as you create folders.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/config/files-and-folders/settings`** (the
   `files_and_folders.settings` route).

## The settings

- **Storage scheme** — choose whether uploaded files are stored in the **public**
  or **private** file system. Use **private** for anything sensitive or
  access‑restricted, so files are served through Drupal's access checks rather than
  being directly reachable on the web.
- **Custom directory** — the directory (within the chosen scheme) where the module
  keeps its files.
- **Layout** — how the manager displays items, for example a list or a grid.
- **Icon size** — the size of the file‑type icons and thumbnails shown in the
  interface.

Click **Save** to store these to the module's configuration.

## Folder access (set per folder)

Access is controlled at the folder level rather than on this settings form. When you
create or edit a folder, you set its **authorized roles** — the module restricts a
folder's visibility to the roles you choose. Plan your folder structure with that in
mind: put role‑restricted content in folders limited to the appropriate roles.

## A note on safe configuration

Because this module is not covered by the security advisory policy and is still under
development, lean toward the cautious choices here:

- Prefer the **private** storage scheme for anything that shouldn't be publicly
  downloadable, and make sure your site has a working private file path configured.
- Keep the module's upload and management **permissions** limited to trusted roles
  (see [Installation](../installation/index.md#grant-permissions-carefully)).
- Review folder authorized‑roles settings when you create folders, so visibility
  matches your intent.
