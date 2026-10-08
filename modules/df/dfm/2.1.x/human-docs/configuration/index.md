# Configuration

Drupella File Manager is configured in two connected places: **profiles** (what a
set of users can do and where) and the **settings form** (which roles get which
profile for which storage scheme, plus a few global options). Until you map a
profile to a role, only user 1 can open the file manager, so this page is where
you actually grant access.

## Open the settings form

1. Log in as a user with the **administer dfm** permission (user 1 has it by
   default).
2. Go to **Configuration → Media → Drupella File Manager**, or navigate directly
   to `/admin/config/media/dfm`.

You'll see the settings form together with the list of configuration profiles.
DFM ships with two starter profiles, **member** and **admin**, which you can edit
or duplicate to build your own.

## Profiles — what a user can do and where

A profile is a reusable bundle of rules. Add, edit, duplicate or delete profiles
from the links under `/admin/config/media/dfm`. Each profile defines:

- **Folders and per-folder permissions** — the allowed folders and, for each one,
  which operations are permitted (browse, upload, delete, rename, move, copy,
  resize, and so on). Subfolders can inherit their parent's rules.
- **Upload extensions and image extensions** — which file types users may upload,
  and which count as images (for resize/crop).
- **Upload size limit and disk quota** — the maximum size of a single upload and
  the total storage a user may consume.
- **Chroot jail (optional)** — collapse the profile down to a single top-level
  directory so users can never step outside it.
- **Thumbnail style (optional)** — the image style used for thumbnails in the
  manager.

Folder names support **tokens** (replaced per user), which is how you give each
user their own personal folder from a shared profile. DFM checks every folder
path and rejects any that contain backslashes or `.`/`..` segments, so profile
folders cannot escape the storage root.

## Map profiles to roles and schemes

The settings form is where access is actually granted. For each **role** and each
**storage scheme** (public, private, or a custom stream wrapper such as S3), you
pick which profile applies. Key options include:

- **Role → profile → scheme mapping** — the core of access control. A user gets
  the file manager for a scheme only if one of their roles is mapped to a profile
  for that scheme. When a user has several roles, the most permissive mapping
  wins.
- **Merge folders** — when enabled, folder permissions from all of a user's role
  profiles are combined, rather than using just one.
- **Absolute URLs** — serve absolute file URLs instead of relative ones.
- **Textareas** — a pattern of textarea IDs that DFM should attach its
  file/image insertion buttons to.

> **Security tip:** Assigning a profile to the **anonymous** or **authenticated**
> role directly exposes file operations to those users. Only do this deliberately,
> and keep the profile's folders, extensions and permissions tight.

## Save

Click **Save configuration**. Mapped users can now open the file manager at
`/dfm/{scheme}` — for example `/dfm/public` — and will see only the folders and
actions their profile allows.

## Editor and field integrations

Once DFM is configured you can wire it into content editing:

- **CKEditor 5** — enable the DFM image and link buttons on a text format at
  **Configuration → Content authoring → Text formats and editors**.
- **BUEditor** — choose DFM as the file browser in the editor's settings.
- **File / image fields** — on the field's widget settings, tick the option to
  allow users to select files from Drupella File Manager.
