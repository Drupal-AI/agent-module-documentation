# Configuration

File Rename has very little to configure: one permission, one global settings
flag, and an optional per-field toggle. This page covers all three.

## Step 1 — Grant the "Rename files" permission

Renaming is controlled by a single permission, **Rename files**
(`rename files`), and no role is granted it by default — so nobody sees the
*Rename* links until you assign it.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Rename files** (listed under File Rename).
3. Tick it for the roles that should be allowed to rename files, and **Save
   permissions**.

Grant it only to trusted roles — it's marked as a restricted permission because
renaming moves files on disk. There are two rules that must *both* hold for a file
to be renamable: the user has this permission, **and** the file is *permanent*
(already saved, not a temporary just-uploaded file). Temporary files can't be
renamed, which prevents renaming something before it's committed.

From the command line:

```bash
drush role:perm:add editor 'rename files'
```

## Step 2 — The settings form (the global widget-link flag)

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → Media → File Rename settings**, or navigate directly to
   `/admin/config/file_rename/settings`.

The form has a single option:

- **Always show the rename link on file widgets** (`always_show_widget_link`,
  **on by default**) — when ticked, a small *Rename* link is rendered under every
  already-uploaded file on **every** file/image field widget across the site (any
  widget based on core's file widget). Untick it if you'd rather not show the link
  everywhere and instead opt in field by field (Step 3).

Click **Save configuration** to store the change. From the command line:

```bash
# read the current value
drush config:get file_rename.settings always_show_widget_link
# turn it on for all file widgets
drush config:set file_rename.settings always_show_widget_link 1 -y
# turn it off (fall back to per-field opt-in)
drush config:set file_rename.settings always_show_widget_link 0 -y
```

> Note: even with this flag off, the *Rename* operation link still appears on the
> admin file listing at **Content → Files** for anyone with the permission. This
> flag only governs the inline link on upload *widgets*.

## Step 3 — Per-field opt-in (when the global flag is off)

If you turn the global flag off, you can still enable the *Rename* link on
individual fields:

1. Go to the bundle's **Manage form display** (for example
   `/admin/structure/types/manage/article/form-display`).
2. Click the **gear/cog icon** on a file or image field's row to open its widget
   settings.
3. Tick **Show rename link**, then **Update** and **Save**.

The checkbox only appears on file/image widgets. Its behaviour interacts with the
global flag:

- If the global flag is **on**, this checkbox shows as ticked-and-disabled (with a
  note pointing to the settings form), because the global setting already covers
  every field.
- If the global flag is **off**, ticking it here turns the link on for just this
  field.

In other words, the *Rename* link shows on a widget when **either** the global flag
is on **or** that widget's *Show rename link* option is ticked.

## Using the rename form

Once the links are in place and the permission is granted, click any **Rename**
link to open the rename form. You edit only the **base filename** — the file
extension is fixed and shown as a read-only suffix, so the file type can't be
changed by accident. On save, the module moves the file on disk, updates the file
entity's stored name and URI, refuses the rename if a file with that name already
exists in the same directory, and (for images) flushes the image-style derivatives
so the resized copies regenerate under the new name.
