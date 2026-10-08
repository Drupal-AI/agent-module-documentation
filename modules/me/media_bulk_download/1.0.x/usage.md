<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Bulk Download allows bulk downloading of media from the library.

---

Media Bulk Download lets users **bulk-download selected media as a single archive** — selecting media items
(e.g. from the media library) and downloading them together as a zip. It depends on core Media, provides its own
permissions.

Use it to let editors download many media files at once. It is a media feature gated by the **`download bulk
media`** permission, and its download endpoint is sound: the served file's path comes from the **current user's
own private tempstore** (prepared by the bulk action, then deleted after send) — not from a request-supplied
id — so there is no id-tampering path to arbitrary files. (The access checking on which media may be included
belongs to the bulk action that builds the archive.) Grant the permission to trusted roles. It has no broader
access-control role. Configure the bulk-download action.

---

- Bulk-download media as an archive.
- Select and zip media items.
- Serve the media library.
- Depend on core Media.
- Provide the 'download bulk media' permission.
- Download many files at once.
- Serve the file from the user's private tempstore.
- Not take a request-supplied file id (no id-tampering).
- Delete the temp file after send.
- Grant the permission to trusted roles.
- Have no broader access-control role.
- Configure the bulk action.
- Handle bulk download.
- Download media.
- Configure the action.
- Zip media.
- Handle the download.
- Bundle files.
- Restrict the permission.
- Provide media bulk download.
