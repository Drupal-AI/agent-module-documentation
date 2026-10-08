<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable & configure the Responsive Table filter

There is **no dedicated admin page** (`configure: null`). You enable the filter per **text
format** and set its two options there.

## Filter plugin

- **id:** `filter_responsive_table` (class `FilterResponsiveTable`)
- **type:** `TYPE_TRANSFORM_REVERSIBLE` — transforms output at render time; stored text is unchanged.
- **settings:**

  | Setting | Default | Meaning |
  |---|---|---|
  | `wrapper_element` | `figure` | HTML tag wrapped around each `<table>` (required; `Xss::filter`ed). |
  | `wrapper_classes` | `responsive-figure-table` | Space-separated class(es) on the wrapper. |

Each match becomes:
`<{wrapper_element} class="{wrapper_classes}" tabindex="0" aria-label="Scrollable table"><table…>…</table></{wrapper_element}>`.
The `responsive_table_filter/responsive-table` CSS (attached on every page) gives
`.responsive-figure-table { max-width:100%; overflow-x:auto; }` — that is what makes it scroll,
so if you change `wrapper_classes` you must add matching CSS yourself.

## Via the UI

1. Go to **Configuration › Content authoring › Text formats and editors**
   (`admin/config/content/formats`).
2. Edit the format (e.g. *Full HTML*).
3. Under **Enabled filters**, tick **Responsive Table filter**.
4. Under **Filter processing order** / the filter's settings, optionally set the wrapper element
   and classes.
5. Order it after "Limit allowed HTML tags" if that filter is used. **Save configuration.**

## Where it is stored

Config entity `filter.format.<format_id>`:

```yaml
filters:
  filter_responsive_table:
    id: filter_responsive_table
    provider: responsive_table_filter
    status: true
    weight: 20
    settings:
      wrapper_element: figure
      wrapper_classes: responsive-figure-table
```

Config schema key: `filter_settings.filter_responsive_table` (maps `wrapper_element`,
`wrapper_classes`).

## Scriptable

```php
use Drupal\filter\Entity\FilterFormat;

$format = FilterFormat::load('full_html');
$format->setFilterConfig('filter_responsive_table', [
  'status' => TRUE,
  'settings' => ['wrapper_element' => 'div', 'wrapper_classes' => 'scroll-table'],
]);
$format->save();
```

Read it back:

```bash
drush cget filter.format.full_html filters.filter_responsive_table
```
