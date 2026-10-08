# `link_with_type` field widget

A drop-in replacement for core's Link widget that adds a per-link **Type** selector, letting an editor
tag each link value as an action or an informational link. Used on the `localgov_common_tasks` field so
the [services CTA block](../blocks/cta-block.md) can style buttons differently.

| Item | Value |
|---|---|
| Widget plugin id | `link_with_type` |
| Class | `Drupal\localgov_services\Plugin\Field\FieldWidget\LinkWithType` |
| Extends | `Drupal\link\Plugin\Field\FieldWidget\LinkWidget` |
| Applies to field type | `link` |
| Config-schema key | `field.widget.settings.link_with_type` (inherits `field.widget.settings.link_default`) |

## Behaviour

`formElement()` calls the parent Link widget then appends a select at `options.type`:

| Stored value | Option label |
|---|---|
| `action` | Action (default) |
| `basic` | Information |

The chosen value is persisted inside the link item's `options` array (`options.type`). Downstream code
reads `$item->options['type']` — e.g. `ServicesCtaBlock` treats `action` as a `cta-action` button and
anything else as `cta-info`.

## Enabling it on a field

Set the widget on a `link` field's form display (via UI at *Manage form display*, or in config):

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'localgov_services_landing', 'default')
  ->setComponent('localgov_common_tasks', ['type' => 'link_with_type'])
  ->save();
```

No extra widget settings beyond the inherited link-default settings (placeholder for URL/title).
