<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Reference Field Suite (vrfs) — agent index

**A suite of improved formatters, a select widget, and settings plugins for the Views Reference Field (viewsreference) module, for embedding configurable views via a reference field.**

- **Version:** 2.0.x (2.0.0-alpha1 on disk)
- **Core:** ^9 || ^10 || ^11 — depends on viewsreference:viewsreference and autocomplete_deluxe:autocomplete_deluxe.
- **Plugins:** `FieldFormatter/ViewsReferenceFieldFormatterImproved`, `FieldFormatter/ViewsReferenceLazyFieldFormatterImproved`, `FieldWidget/ViewsReferenceSelectWidgetImproved`, `ViewsReferenceSetting/{ViewsReferenceFilters,ViewsReferenceExposedFilters,ViewsReferenceArgumentTokenizer}`.
- **Permission:** `administer vrfs configuration` (restrict access). No routes of its own.

**Security:** Reviewed the serialized-data handling — all three decode sites use `unserialize(..., ['allowed_classes' => FALSE])` (`ViewsReferenceFieldFormatterImproved.php:59`, `ViewsReferenceSelectWidgetImproved.php:131`, `ViewsReferenceLazyFieldFormatterImproved.php:24-25`), so PHP object injection is prevented. No `_access: 'TRUE'` routes, no raw SQL, no disabled TLS, no unverified callbacks. No security findings.

See [plugins/overview.md](plugins/overview.md).