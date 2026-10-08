<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metatag Auto Pagination (metatag_auto_pagination) — agent index

**Automatically injects `rel="prev"`/`rel="next"` pagination link meta tags derived from the active core pager.**

- **Version:** 2.0.x
- **Core:** `^11`
- **Depends:** metatag
- **Services:** `metatag_auto_pagination.pager_manager` (reads `@pager.manager` + request stack), `metatag_auto_pagination.attachment_tools` (injects head links). Metatag tag plugin `PagerLinks`; hooks `AttachmentAlter`, `OutOfPagination`.
- **Routes / permissions:** none of its own. Configured via Metatag basic settings (Admin » Configuration » Search and metadata » Metatag), "AUTO PAGER LINKS" section.

**Security:** no routes, no permissions, no forms, no anonymous or mutating endpoints; only reads the current pager and emits `<link>` head tags. No security findings.
