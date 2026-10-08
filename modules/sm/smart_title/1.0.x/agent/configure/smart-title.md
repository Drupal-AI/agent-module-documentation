# Configure Smart Title

Two layers of state: **which bundles are eligible** (one simple config), and **per view
display** whether Smart Title is on plus its format settings (third-party settings on the
`entity_view_display`).

## 1. Make a bundle eligible

`smart_title.settings` holds a single key `smart_title`: a flat list of
`"<entity_type>:<bundle>"` strings.

```yaml
# config: smart_title.settings
smart_title:
  - 'node:article'
  - 'node:page'
```

The **Smart Title UI** submodule provides the form at `/admin/config/content/smart-title`
(permission `administer smart title`) that manages this list. You can also set it directly:

```php
\Drupal::configFactory()->getEditable('smart_title.settings')
  ->set('smart_title', ['node:article'])->save();
\Drupal\Core\Cache\Cache::invalidateTags(['entity_field_info']); // re-expose the extra field
```

Only entity types whose label base field is **not already display-configurable** are listed
in the UI. Enabling a bundle exposes a `smart_title` extra field on that bundle's view
displays (via `hook_entity_extra_field_info()`), hidden by default.

## 2. Enable Smart Title on a view display

On *Manage display* for a view mode, the **Smart Title** details section has a
"Make entity title configurable" checkbox. Ticking it and saving stores, on
`core.entity_view_display.<entity>.<bundle>.<mode>`:

```yaml
third_party_settings:
  smart_title:
    enabled: true
    settings:
      smart_title__tag: h2          # h1..h6, div, span, or '' (no wrapper)
      smart_title__classes:          # array of CSS class strings
        - node__title
      smart_title__link: true        # link the title to the entity
content:
  smart_title:                       # the extra field, placed in a region/weight
    weight: -5
    region: content
    settings: {  }
    third_party_settings: {  }
```

Dragging the `smart_title` field out of *Disabled* into a region makes the title render
there; the theme's original label is suppressed by `smart_title_preprocess()` so it is not
duplicated.

### Format settings (`third_party_settings.smart_title.settings`)

| Key | Type | Meaning | Default |
|---|---|---|---|
| `smart_title__tag` | string | Wrapper tag: `h1`–`h6`, `div`, `span`, or empty for none | `h2` |
| `smart_title__classes` | array of strings | CSS classes on the wrapper | `['<entity_type>__title']` |
| `smart_title__link` | boolean | Wrap the title in a link to the entity | `true` |

### Doing it in code

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setThirdPartySetting('smart_title', 'enabled', TRUE)
   ->setThirdPartySetting('smart_title', 'settings', [
     'smart_title__tag' => 'h1',
     'smart_title__classes' => ['article__title'],
     'smart_title__link' => FALSE,
   ])
   ->setComponent('smart_title', ['weight' => -5, 'region' => 'content'])
   ->save();
```

## Notes

- Choices are **per view mode**; a display without `enabled: true` renders the label the
  normal (theme) way.
- Uninstalling the module removes the `smart_title` component from every affected display
  (`smart_title_uninstall()`).
- Works with any entity type that has a *Manage display* form and a label key; supported
  with Field Layout. Not intended for Layout Builder-enabled displays (the form alter
  bails out when `layout_builder.enabled` is set).
