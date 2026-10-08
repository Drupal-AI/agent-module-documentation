<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permanent Entities provides entities that cannot be created or deleted.

---

Permanent Entities **provides entities that cannot be created or deleted** — entity types whose instances are
fixed (e.g. required singletons/reference data that must always exist and must not be removed), preventing
accidental or malicious creation/deletion. It provides its own permissions, in the Entity package.

Use it for protected, must-always-exist content. It is a data-integrity/protection feature: by blocking create and
delete operations it guards critical entities from removal. Security/robustness note: verify the create/delete
restriction is enforced on the paths that matter for your site (UI, and any API/programmatic delete paths) so the
"permanent" guarantee actually holds where you depend on it, and understand that editing (update) may still be
allowed. It layers protection on core entity operations. Configure the permanent entity types.

---

- Provide entities that can't be created/deleted.
- Protect must-always-exist content.
- Guard critical entities from removal.
- Provide its own permissions.
- Serve data integrity/protection.
- Block create + delete operations.
- BE a data-integrity/protection feature.
- Verify the restriction covers UI + API/programmatic delete paths.
- Allow update (editing) unless otherwise restricted.
- Layer protection on core entity operations.
- Configure the permanent entity types.
- Handle permanent entities.
- Protect entities.
- Configure the types.
- Prevent deletion.
- Handle the protection.
- Fix entities.
- Guard content.
- Verify the block.
- Provide permanent entities.
