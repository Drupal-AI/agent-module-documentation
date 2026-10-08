<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable media dimension overrides on a text format

Media Embed Extra has **no configuration of its own** (`configure: null`). It works whenever
a text format is set up for media embedding. Two filter settings on the format matter:

1. **Embed media** (`media_embed`) must be enabled — Media Embed Extra swaps this filter's
   class, so its per-embed dimension handling only runs when this filter is on.
2. If **Limit allowed HTML tags and correct faulty HTML** (`filter_html`) is enabled, the
   allowed-HTML string must permit the `<drupal-media>` tag **with** the `data-width` and
   `data-height` attributes, or Drupal strips them before rendering:

   ```
   <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-caption data-width data-height>
   ```

## Where it is stored

Config entity `filter.format.<format>` (e.g. `filter.format.full_html`):

```yaml
filters:
  media_embed:
    status: true
  filter_html:
    status: true
    settings:
      allowed_html: '... <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-caption data-width data-height> ...'
```

## Via the UI

1. Go to *Administration » Configuration » Content authoring » Text formats and editors*
   (`/admin/config/content/formats`) and edit the format (e.g. **Full HTML**).
2. Under **Enabled filters**, tick **Embed media**.
3. If **Limit allowed HTML tags** is enabled, add `data-width` and `data-height` to the
   `<drupal-media …>` entry in **Allowed HTML tags**.
4. Save. When an editor now double-clicks an embedded **image** media item, the dialog shows a
   **Dimensions** fieldset with Width and Height fields.

## Via drush php:eval (scriptable)

```php
use Drupal\filter\Entity\FilterFormat;
$f = FilterFormat::load('full_html');
$f->setFilterConfig('media_embed', ['status' => TRUE]);
// If filter_html is on, ensure the allowed_html string includes data-width/data-height.
$f->save();
```

## Read it back

```bash
drush cget filter.format.full_html filters.media_embed.status
drush cget filter.format.full_html filters.filter_html.settings.allowed_html   # must contain data-width / data-height
```

Note: there is nothing module-specific in this config — Media Embed Extra participates purely
by overriding the core `media_embed` filter class (see [../api/mechanism.md](../api/mechanism.md)).
