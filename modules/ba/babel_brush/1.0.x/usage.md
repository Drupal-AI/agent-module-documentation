<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Babel Brush adds one admin form that searches Drupal core Locale source strings by keyword and bulk-deletes the selected strings from both the locales_source and locales_target tables.

---

Babel Brush is a small maintenance utility built on core's Locale (interface translation) module. It provides a single form at Configuration → Regional and language → Babel Brush (`/admin/config/babel_brush/search`) where an administrator types a keyword, gets a checkbox list of matching translatable source strings (LIKE match on `locales_source.source`, with each string's translation context shown), then selects strings — individually or via Select all / Deselect all — and deletes them. Deletion removes the rows from `locales_source` and `locales_target`, so the source string and all of its translations are cleared at once. Access is limited to users holding the restricted `administer babel brush search form` permission. This is version 1.0.0-alpha1: alpha, minimally maintained, and covers Drupal 10 and 11. It has no configuration settings, no export/import, and no undo — a delete is immediate and permanent.

---

- Search interface-translation source strings by a keyword substring.
- Find every source string whose text contains a given word or phrase.
- See the translation context of each matching source string before acting.
- Bulk-delete stale or obsolete translatable strings from the Locale tables.
- Remove a source string together with all of its translations in one action.
- Clean up leftover strings from a module that has been uninstalled.
- Purge test or placeholder strings accidentally exported into `t()` calls.
- Tidy the interface-translation database on a multilingual site.
- Select all matched results at once for a fast bulk cleanup.
- Deselect all to reset a selection before deleting.
- Delete individually ticked strings while leaving others in place.
- Reduce clutter in the core Locale "Translate interface" UI.
- Drop strings that no longer appear anywhere on the site.
- Free translators from re-translating strings that should not exist.
- Restrict this maintenance capability to trusted admins via a dedicated permission.
- Trigger a fresh locale re-scan afterward by clearing removed strings first.
- Remove duplicated or malformed source strings surfaced by a keyword search.
- Support translation-string housekeeping on both Drupal 10 and Drupal 11 sites.
- Locate strings by a shared prefix or fragment (e.g. an old brand name).
- Clean translation data before a site content freeze or migration.
