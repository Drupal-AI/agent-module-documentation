<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Private Access enables advanced access control for media entities.

---

Media Private Access **adds an access control handler for media entities** — replacing media's access
handler so that viewing a media entity is restricted to administrators, the media **owner**, and users with a
per-type **`view <type> media`** permission (standalone media pages are limited to admins/owners). It depends on
core Media, provides its own permissions, in the Media package.

Use it to restrict who can view media entities. It is an access-control feature and its **media-entity** access
is real and correctly enforced (it properly returns `forbidden`), so it is respected by the standalone media page
and by access-aware paths (Views/JSON:API check media access). **Important caveat:** it only governs the media
**entity** — it does **not** protect the underlying **file bytes**. It implements no `hook_file_download` and does
not require the private file scheme, so a media item whose file is in **`public://`** (the default) remains
**directly downloadable by its file URL**, bypassing this handler entirely. For genuine file protection you must
store the files in the **`private://`** scheme (where core file access + `hook_file_download` apply) — restricting
the media entity alone gives a false sense of file privacy for public-scheme files. It layers on core media
access. Configure the per-type access modes and use the private file scheme for restricted files.

---

- Restrict media entity view.
- Limit to admin/owner/permission-holders.
- Replace media's access handler.
- Depend on core Media.
- Provide its own permissions.
- Properly return forbidden (real entity access).
- Be respected by standalone pages + Views/JSON:API.
- ONLY govern the media ENTITY, not file bytes.
- Implement NO hook_file_download / not require private scheme.
- Leave public:// file bytes directly downloadable (bypass).
- Use private:// for genuine file protection.
- Not rely on entity access alone for file privacy.
- Handle media access.
- Restrict media.
- Configure the access modes.
- Gate media view.
- Handle the entity access.
- Protect media entities.
- Use the private scheme for files.
- Provide media entity access control.
