# Configure entity preview

Settings form `\Drupal\preview\Form\PreviewSettingsForm` (form id `preview_settings_form`,
extends `ConfigFormBase`) at route **`preview.settings`**, path **`/admin/config/content/preview`**,
permission **`administer site configuration`**. This is the module's `configure` link and the
`preview.admin_settings` menu link, placed under *Configuration → Content authoring*
(`system.admin_config_content`).

## What the form does

For every **content** entity type — except `node`, which core previews already — it renders an
"enable" checkbox, and for each bundle of an enabled type a bundle "enable" checkbox plus a
**Default view mode** radio set (`Default` + the bundle's configured view modes, from
`EntityDisplayRepository::getViewModeOptionsByBundle()`). Enabling a bundle *and* choosing a default
view mode is what makes the **Preview** button appear on that bundle's edit form.

`submitForm()` writes only bundles that are enabled and have a non-empty default view mode; anything
unchecked or left without a view mode is dropped from config.

## Config object: `preview.settings`

Single key `enabled` — a nested map of `entity_type_id → bundle_id → view_mode_id`.

| Key path | Type | Meaning |
| --- | --- | --- |
| `enabled` | mapping (sequence) | Top level, keyed by content entity type id. |
| `enabled.<entity_type_id>` | mapping (sequence) | Keyed by bundle id. |
| `enabled.<entity_type_id>.<bundle_id>` | string | The default view mode id to preview that bundle in (e.g. `default`, `teaser`, `full`). |

Example stored value:

```yaml
enabled:
  taxonomy_term:
    tags: teaser
  media:
    image: full
```

Default install ships `enabled: {}` (nothing enabled).

## Config schema (`config/schema/preview.schema.yml`)

`preview.settings` is a `config_object` whose `enabled` is a `sequence` of `sequence` of `string`
(view-mode ids by bundle by entity type).

## Set it without the UI

Drush (one nested value at a time):

```sh
drush config:set preview.settings enabled.taxonomy_term.tags teaser -y
```

PHP (replace the whole map):

```php
\Drupal::configFactory()->getEditable('preview.settings')
  ->set('enabled', [
    'taxonomy_term' => ['tags' => 'teaser'],
    'media' => ['image' => 'full'],
  ])
  ->save();
```

The view-mode id must actually exist for that bundle — the form only offers `default` plus the view
modes the bundle has configured. An entry pointing at a missing view mode falls back to default
rendering.
