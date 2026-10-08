<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filter Format Audit audits filter formats to identify affected content.

---

Filter Format Audit **audits text (filter) formats** — scanning content to identify where each format is
used and what content could be affected before you change or remove a format, so risky reformatting doesn't
silently break or expose content. It depends on core Filter and Dynamic Entity Reference, provides its own
permissions.

Use it before changing text formats to see impact. This is a **security/QA-positive** administration tool:
understanding which content uses a format helps avoid accidentally exposing raw HTML or breaking sanitization
when formats change. Its report is gated by its permission (admin/site-builder), and it has no access-control
role beyond that. Run the filter-format audit.

---

- Audit text (filter) formats.
- Find content affected by a format.
- Assess impact before changes.
- Depend on core Filter + Dynamic Entity Reference.
- Provide its own permissions.
- Avoid breaking sanitization.
- Be security/QA-positive.
- Gate the report by permission.
- Have no access-control role beyond permission.
- Run the audit.
- Handle format audits.
- Audit formats.
- Configure nothing (report).
- Handle the audit.
- Assess formats.
- Configure auditing.
- Handle formats.
- Report usage.
- Review the audit.
- Provide filter-format auditing.
