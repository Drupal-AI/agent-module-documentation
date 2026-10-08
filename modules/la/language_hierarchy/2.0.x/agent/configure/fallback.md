# Language Hierarchy — configuring fallback

No settings form and no permission of its own. You configure the hierarchy through core's
**language** admin forms, and it is stored as a per-language third-party setting.

## Where the parent is stored
On each `configurable_language` config entity:
```
third_party_settings:
  language_hierarchy:
    fallback_langcode: <parent langcode>   # '' or absent = no fallback
```
Config name `language.entity.<langcode>`; schema key
`language.entity.*.third_party.language_hierarchy` (`fallback_langcode` string).

## Setting it via the UI
- **Per language**: edit a language at `admin/config/regional/language/edit/<langcode>`. The
  module adds a **"Translation fallback language"** select
  (`language_hierarchy_form_language_admin_edit_form_alter()`); pick the parent (or "- none -").
- **Whole tree at once**: on the languages overview
  (`admin/config/regional/language`) the module turns the table into a drag-and-drop
  **parent/child hierarchy** (a "Parent" column with tabledrag); indent a language under another
  to set its fallback. Saved by `language_hierarchy_language_admin_overview_form_submit()`.

## Setting it in code / drush
```php
use Drupal\language\Entity\ConfigurableLanguage;
$lang = ConfigurableLanguage::load('de-at');
$lang->setThirdPartySetting('language_hierarchy', 'fallback_langcode', 'de');
$lang->save(); // triggers language_hierarchy_update_priorities()
```
Reading the ancestors of a language: `language_hierarchy_get_ancestors($configurable_language)`
returns the ordered ancestor list (most specific first), with cycle protection.

## The priority table
`language_hierarchy_update_priorities()` (re)builds the `language_hierarchy_priority` table
(columns `langcode`, `priority`) on every language insert/update/delete and on config import. A
child language's priority is its **depth** in the hierarchy (deeper = more relevant); languages
with no parent are seeded from negative weight-based values. This table is what orders fallbacks in
config overrides, locale lookups, path-alias queries, and the Views handlers — you normally never
edit it directly.

## Verifying the effective chain
```
drush php:eval '\
  print implode(",", array_keys(\Drupal::languageManager()->getFallbackCandidates(["langcode" => "de-at"])));'
```
This returns the resolved candidate order (e.g. `de-at,de,en,und`).
