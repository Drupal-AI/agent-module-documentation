# Enabling & configuring the Empty Paragraph filter

The module adds one filter plugin and nothing else — no settings page. You turn it on per
text format.

## Via the UI

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the format (e.g. *Full HTML*).
3. Check **"Empty paragraph filter"** under *Enabled filters*.
4. Under **Filter processing order**, drag *Empty paragraph killer* to (or near) the **bottom**
   so other filters run first, unless a later filter must process the output.
5. Save.

## The config it writes

Enablement lives in the format's config entity `filter.format.<format_id>`:

```yaml
filters:
  emptyparagraphkiller:
    id: emptyparagraphkiller
    status: true
    weight: 100     # high weight => runs last
    settings: {  }
```

Read it: `drush config:get filter.format.full_html filters.emptyparagraphkiller`.

## Enable it programmatically

```php
$format = \Drupal::configFactory()->getEditable('filter.format.full_html');
$filters = $format->get('filters');
$filters['emptyparagraphkiller'] = ['id' => 'emptyparagraphkiller', 'provider' => 'emptyparagraphkiller', 'status' => TRUE, 'weight' => 100, 'settings' => []];
$format->set('filters', $filters)->save();
```

(Or load the `filter_format` entity and call `setFilterConfig('emptyparagraphkiller', ['status' => TRUE, 'weight' => 100])`.)

## How the plugin works

`Drupal\emptyparagraphkiller\Plugin\Filter\EmptyParagraphKiller` (type
`TYPE_TRANSFORM_REVERSIBLE`):

- `prepare($text, $langcode)` → `preg_replace('#<p[^>]*>(\s|&nbsp;?)*</p>#', '[empty-para]', $text)`
  — swaps empty paragraphs for a placeholder.
- `process($text, $langcode)` → `str_replace('[empty-para]', '', $text)` wrapped in a
  `FilterProcessResult` — drops the placeholders.

Because it only transforms rendered output, stored content is untouched. There are **no filter
settings** to configure. Best paired with a WYSIWYG editor; without one, core's "Convert line
breaks" filter is usually sufficient.
