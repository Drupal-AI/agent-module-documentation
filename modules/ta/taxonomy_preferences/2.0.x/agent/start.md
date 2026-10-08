<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Preferences (taxonomy_preferences) — agent index

**A block where users pick taxonomy terms; selections are stored in `$_SESSION` for use as a Views session/contextual filter.**

- **Version:** 2.0.x (2.0.0)
- **Core:** ^10.3 || ^11
- **Dependencies:** drupal:locale, drupal:config_translation
- **Configure:** `taxonomy_preferences.settings` — `/admin/config/system/taxonomy_preferences` (perm `access taxonomy preferences settings`)
- **Routes:** `taxonomy_preferences.settings` (admin), `taxonomy_preferences.admin` `/taxonomy_preferences` (block form, perm `access content`)
- **Permissions:** `access taxonomy preferences settings`, `access taxonomy preferences block`
- **Block:** `TaxonomyPreferencesBlock` · **Session keys:** `taxonomy_preferences.preferences_key`, `taxonomy_preferences.visibility`

**Security:** The `/taxonomy_preferences` form route is gated only by core `access content` (effectively anonymous), but the only side effect is writing the visitor's OWN session preferences — no server-side/business mutation. Admin `user_message` is rendered as raw `#markup` (trusted admin/config-translation input). Report noted, low impact.
