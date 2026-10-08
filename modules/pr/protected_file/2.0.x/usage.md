Protected File adds a `protected_file` field type (an extended core File field) that lets an editor mark individual uploaded files as "protected", so that only users holding the `download protected file` permission can download them — while everyone still sees the file link.

---

The module extends core's File field into a `protected_file` field type whose widget adds a per-file **Protected** checkbox and whose default formatter renders a lock icon plus a configurable redirect (e.g. to `/user/login`) for visitors who lack permission. Enforcement is server-side in `hook_file_download()` (`protected_file_file_download()`): when a requested private file is referenced by a `protected_file` field and marked protected, the hook returns `-1` (access denied) for any user without the `download protected file` permission, so the download is blocked even if the direct URL is known. The field is **locked to the `private://` stream wrapper** (public files are rejected at field-storage config time and an install requirement warns if no private scheme is configured), because only private files route through `hook_file_download()`. A `ProtectedFileAccessEvent` (`protected_file.check_access`) is dispatched on every protected download so other modules can allow/deny per file, uri, and host entity. The formatter can open files in a new tab, redirect unauthorized users to a path (optionally inside a modal, optionally straight to the file after login), and customize the "protected" title text. A `protected_file` media source is also provided so protected files can back media entities. There is no global settings page (`configure` is null); everything is configured per field on Manage form/display.

---

- Require users to log in (or hold a role/permission) before they can download attached files, while still showing the file to everyone.
- Publish a document library where PDFs are visible but only downloadable by members.
- Gate downloadable assets (whitepapers, price lists, datasheets) behind registration.
- Let each editor decide, file by file within one field, which uploads are protected and which are open.
- Show a lock icon next to protected files so visitors know they must authenticate.
- Redirect anonymous users who click a protected file to `/user/login` and back to the file after login.
- Open the login/redirect path inside an AJAX modal instead of a full page navigation.
- Serve protected downloads from the `private://` filesystem with server-side permission enforcement (not just hidden links).
- Add a "Download protected file" permission to a members or subscribers role.
- Replace a standard File field with a Protected File field to add download gating without hiding the file entirely.
- Provide members-only course materials or event handouts on an otherwise public page.
- Distribute software builds or license keys only to authenticated/entitled users.
- Use the dispatched access event to implement custom rules (per-entity ownership, purchase checks, group membership) deciding who may download.
- Grant a partner/reseller role download rights to protected catalog files.
- Keep marketing assets browsable by search engines' human visitors while blocking the actual binary for non-members.
- Attach protected files to media entities via the provided `protected_file` media source.
- Configure allowed extensions, max upload size, and upload directory just like a normal File field, plus protection.
- Open downloaded files in a new browser tab via the formatter setting.
- Customize the tooltip/message shown on a protected link (e.g. "You need to be logged in to download this file").
- Override `protected-file-link.html.twig` to restyle the protected-file link and lock markup.
- Ensure that even users who discover the direct file URL cannot bypass the gate, because access is checked in `hook_file_download()`.
