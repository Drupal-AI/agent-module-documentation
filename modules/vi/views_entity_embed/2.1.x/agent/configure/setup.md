<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up embedding of Views

No module settings page (`configure: null`). Setup is three things on the editor/format side.

## 1. Enable the `views_embed` filter on the text format

The **Display embedded views** filter (`views_embed`) is what renders `<drupal-views>` tags.
Enable it on each format that should support embedded Views.

```yaml
# filter.format.<format>
filters:
  views_embed:
    status: true
```

## 2. Allow the `<drupal-views>` tag (if HTML is limited)

If **Limit allowed HTML tags** (`filter_html`) is on, add the tag and its attributes to the
allowed-HTML list, otherwise they are stripped:

```
<drupal-views data-view-name data-view-display data-view-arguments data-embed-button data-caption data-align>
```

## 3. Create / place the Views Embed button

The module installs an embed button `views` (type **Views** = `embed_views`). To add another,
go to *Configuration » Content authoring » Embed buttons* and create a button whose **Embed
type** is *Views*. On the button you may optionally:

- **Filter which Views to be allowed** (`filter_views` + `views_options`), and/or
- **Filter which Display to be allowed** (`filter_displays` + `display_options`).

Leaving those unchecked allows all Views / displays.

Then, in the format's **CKEditor 5 toolbar**, drag the Views Embed button into the active
toolbar so editors can insert Views.

## Config for an embed button (scriptable)

```php
\Drupal::entityTypeManager()->getStorage('embed_button')->create([
  'id' => 'my_views_button',
  'label' => 'Views',
  'type_id' => 'embed_views',
  'type_settings' => [
    'filter_views' => 1,
    'views_options' => ['content' => 'content'],   // only allow the 'content' View
    'filter_displays' => 0,
    'display_options' => [],
  ],
])->save();
```

## What gets stored in the content

An embedded View is a `<drupal-views>` element:

```html
<drupal-views data-view-name="content" data-view-display="page_1"
  data-view-arguments='{"override_title":false,"title":"","filters":[]}'></drupal-views>
```

## Read it back

```bash
drush cget filter.format.full_html filters.views_embed.status
drush cget embed.button.views type_id            # -> embed_views
```
