<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Locale delete (locale_delete) — agent index

**Adds a confirm-form route to permanently delete one interface-translation string (source + all targets).**

- **Version:** 1.0.x (dev-1.0.x checkout)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** drupal:locale
- **Route:** `locale_delete.delete` → `/admin/config/regional/translate/delete/{lid}` (perm `use locale delete`).
- **Form:** `LocaleDeleteForm` (extends `ConfirmFormBase`); deletes from `locales_source` + `locales_target` by `lid` with parameterized queries; logs and redirects to `locale.translate_page`.

**Security:** destructive but properly gated — dedicated permission `use locale delete`, confirm-form (CSRF-protected + explicit confirmation), parameterized SQL. No security findings.