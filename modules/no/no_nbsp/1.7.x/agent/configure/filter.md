# Enable the No-nbsp text filter

The filter plugin is `filter_no_nbsp` ("No Non-breaking Space Filter"), a
`TYPE_TRANSFORM_IRREVERSIBLE` filter. There is **no module settings page**; you configure it
per text format.

## Via the UI

1. *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`), edit a format (e.g. Basic HTML).
2. Under **Enabled filters**, tick **No Non-breaking Space Filter**.
3. (Optional) Under **Filter settings** for it, tick **Preserve placeholders**.
4. Mind filter order — it runs in the "Filter processing order" like any other filter.
5. Save.

## What it does

Rendering through that format replaces every `&nbsp;` entity **and** every raw U+00A0
character with a normal space, then collapses runs of spaces to one (`_no_nbsp_eraser()`).

- **Preserve placeholders** (`preserve_placeholders`, default `false`): when on, a non-breaking
  space immediately following a `>` (i.e. sitting inside an otherwise-empty tag such as
  `<p>&nbsp;</p>`) is turned into a normal space but not merged away — keeping intentional
  spacer markup. When off, all nbsp are removed/normalised unconditionally.

## Where the setting is stored

In the text format's own config, not a module config object:

```yaml
# filter.format.<format_id>
filters:
  filter_no_nbsp:
    id: filter_no_nbsp
    provider: no_nbsp
    status: true
    weight: 20
    settings:
      preserve_placeholders: false
```

Schema: `filter_settings.filter_no_nbsp` (one boolean `preserve_placeholders`).

## Scripted enable (drush php)

```php
$f = \Drupal\filter\Entity\FilterFormat::load('basic_html');
$f->setFilterConfig('filter_no_nbsp', [
  'status' => TRUE,
  'settings' => ['preserve_placeholders' => FALSE],
]);
$f->save();
```

Read back: `drush cget filter.format.basic_html filters.filter_no_nbsp`.
