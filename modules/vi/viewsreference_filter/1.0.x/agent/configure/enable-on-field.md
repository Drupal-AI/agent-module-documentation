<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable exposed filters on a Views Reference field

There is **no admin settings page** for this module (`configure: null`). Its behavior is
switched on per viewsreference field by including `exposed_filters` in that field's
**`enabled_settings`** — a field setting defined by the parent `viewsreference` module.

## Where enablement is stored

Config entity: `field.field.<entity_type>.<bundle>.<field_name>`
Path within it (`field.field_settings.viewsreference`):

```yaml
settings:
  enabled_settings:
    exposed_filters: exposed_filters   # value may be the id or truthy; array_filter() is applied
```

`ViewsReferenceTrait` reads `array_filter($this->getFieldSetting('enabled_settings'))` and
instantiates each enabled `ViewsReferenceSetting` plugin, so once `exposed_filters` is in the
list the editor widgets appear on that field.

## Via the UI

1. Add a **Views reference** field to a bundle (Manage fields), or edit an existing one.
2. On the field settings form, under **"Enable extra settings"**, tick
   **Exposed Filters - editor view**.
3. Save. Now the entity edit form for that field shows the referenced view's exposed-filter
   widgets and a **Show Filters on Page** checkbox.

## Via drush php:eval (scriptable)

```php
use Drupal\field\Entity\FieldConfig;
$fc = FieldConfig::loadByName('node', 'article', 'field_view_ref');
$settings = $fc->getSetting('enabled_settings') ?: [];
$settings['exposed_filters'] = 'exposed_filters';   // add to the enabled list
$fc->setSetting('enabled_settings', $settings)->save();
```

To turn it off, remove the `exposed_filters` key (or set it falsy — it is `array_filter`ed
out) and save.

## Read it back

```bash
drush cget field.field.node.article.field_view_ref settings.enabled_settings
# expect a list containing: exposed_filters
```

Prerequisite: the field must be a `viewsreference` field and the referenced view/display must
have **exposed filters**, otherwise there is nothing for the plugin to render.
