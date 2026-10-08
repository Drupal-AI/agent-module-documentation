<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the "Improve line breaks" filter

There is **no configure route** (`configure: null`). Like every filter, this one is turned on
per **text format**, and its state lives inside that format's config entity.

## The filter and its one setting

- Plugin id: `improve_line_breaks_filter` (title "Improve line breaks"), default weight `50`,
  type `TYPE_TRANSFORM_IRREVERSIBLE` (runs on output, does not change the stored value).
- Setting: `remove_empty_paragraphs` (boolean, default `FALSE`).
  - `FALSE` → replace each empty paragraph with `<br />`.
  - `TRUE` → delete empty paragraphs entirely.

## Where it is stored

```yaml
# filter.format.<format>   (e.g. filter.format.basic_html)
filters:
  improve_line_breaks_filter:
    id: improve_line_breaks_filter
    provider: improve_line_breaks_filter
    status: true
    weight: 50
    settings:
      remove_empty_paragraphs: false
```

## Via the UI

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Edit a format (e.g. **Basic HTML**).
3. Under **Enabled filters**, tick **Improve line breaks**.
4. Under **Filter processing order**, drag it near the end (after filters that must run first).
5. On the **Improve line breaks** tab in **Filter settings**, optionally tick **Remove empty
   paragraphs** to delete rather than replace them.
6. **Save configuration**.

## Via drush php:eval (scriptable)

```php
use Drupal\filter\Entity\FilterFormat;
$format = FilterFormat::load('basic_html');
$format->setFilterConfig('improve_line_breaks_filter', [
  'status' => TRUE,
  'weight' => 50,
  'settings' => ['remove_empty_paragraphs' => FALSE],  // TRUE = delete instead of replace
]);
$format->save();
```

Disable again with `$format->setFilterConfig('improve_line_breaks_filter', ['status' => FALSE])->save();`.

## Read it back

```bash
drush cget filter.format.basic_html filters.improve_line_breaks_filter
# status: true; settings.remove_empty_paragraphs: false
```

## Config schema

`config/schema/improve_line_breaks_filter.schema.yml` defines
`filter_settings.improve_line_breaks_filter` with a single boolean `remove_empty_paragraphs`,
plugged into core's `filter_settings.*` mapping so the format config validates.
