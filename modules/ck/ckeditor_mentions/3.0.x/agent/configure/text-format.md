# Configure — enable mentions per text format

There is **no admin settings page** (`configure` is null). Mentions are configured per **text
format** through the CKEditor 5 plugin `ckeditor_mentions_mentions`. The plugin declares no
toolbar button and no conditions, so its settings section ("Mentions") appears for **every**
CKEditor 5 text format; you enable it per mentions type.

## UI
`/admin/config/content/formats/manage/{format}` → in **CKEditor 5 plugin settings** open the
**Mentions** section → tick **Enable Mentions: User** (and/or Node / Realname) → configure the
per-type fields → Save. (`hook_help` links here from `filter.admin_overview`.)

Also grant the [`use inline mentions`](../permissions/permissions.md) permission — without it the
editor loads no mention feeds and the AJAX route is denied.

## Per-type settings (form: `Plugin\CKEditor5Plugin\Mentions::buildConfigurationForm`)
| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable` | bool | `FALSE` | Turn this mentions type on for the format |
| `marker` | string (1 char) | `@` | Character that triggers autocomplete. **Must be unique per format** (validated) |
| `removeMarker` | bool | `FALSE` | Drop the marker from the inserted visible text |
| `charcount` | int | `2` | Minimum characters typed before a lookup fires (`minimumCharacters`) |
| `dropdownLimit` | int | `10` (`MentionsTypeBase::DEFAULT_DROPDOWN_LIMIT`) | Max suggestions shown (applied as a query `range()`) |
| `useRewrittenUrl` | bool | `FALSE` | Use the URL alias instead of the canonical path for the mention's `href` |
| `filterByBundle` | string[] | `[]` | Restrict matches to these bundles (only shown for bundle-able entity types, e.g. node) |

## Where it is stored (config)
`editor.editor.{format}` → `settings.plugins.ckeditor_mentions_mentions.plugins.{type}` where
`{type}` is a mentions-type plugin id (`user`, `node`, `realname`, …). Schema:
`config/schema/ckeditor_mentions.schema.yml` (`ckeditor5.plugin.ckeditor_mentions_mentions`).

## Set it via PHP / drush
```php
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $editor->getSettings();
$settings['plugins']['ckeditor_mentions_mentions']['plugins']['user'] = [
  'id' => 'user',
  'enable' => TRUE,
  'marker' => '@',
  'removeMarker' => FALSE,
  'charcount' => 2,
  'dropdownLimit' => 10,
  'useRewrittenUrl' => FALSE,
  'filterByBundle' => [],
];
$editor->setSettings($settings);
$editor->save();
```
Run with `drush php:eval '...'`. The matching filter format must also permit the mention markup
(`<a class data-mention data-mention-uuid data-entity-id data-entity-uuid data-plugin href>`);
those elements are declared by the CKEditor 5 plugin so enabling it registers them with filter_html.

## Runtime
`Mentions::getDynamicPluginConfig()` builds, for each enabled type, a CKEditor `mention` feed
pointing at `Url::fromRoute('ckeditor_mentions.ajax_callback', {editor_id, plugin_id, match:'--match--'})`.
The JS (`js/build/*`) replaces `--match--` with the typed text and calls the endpoint, which runs
the mentions-type plugin and returns JSON suggestions. If the current user lacks `use inline
mentions`, `getDynamicPluginConfig()` returns `[]` (no feeds).

## CKEditor 4 → 5 upgrade
`src/Plugin/CKEditor4To5Upgrade/MentionsUpgrade.php` maps a legacy `mentions` CKEditor 4 plugin
setting (`mentions_type`, `marker`, `charcount`, `enable`) to the `ckeditor_mentions_mentions`
config above during a format upgrade.
