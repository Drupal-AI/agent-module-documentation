# Create and manage custom publishing options

## Admin UI

Route `entity.custom_publishing_option.collection` → `/admin/config/content/custom_publishing_option`
(Structure/Config → under `system.admin_config_content`). Admin permission on the routes:
`administer site configuration` (the config entity's `admin_permission`); the menu/collection is
also intended for holders of `administer custom publishing options`. Links:

- add: `/admin/config/content/custom_publishing_option/add`
- edit: `/admin/config/content/custom_publishing_option/{id}/edit`
- delete: `/admin/config/content/custom_publishing_option/{id}/delete`

## The config entity

Config name: `custom_pub.custom_publishing_option.<id>` (config_entity). Exported keys:

```yaml
id: archived                     # machine name -> also the node base field name
label: 'Archived'
description: 'Archive without unpublishing'
publish_under_promote_options: false   # true => checkbox grouped under core "Promotion options"
uuid: ...
```

## What creating an option does

`CustomPublishingOption::postSave()` installs a **boolean base field on the `node` entity named
`<id>`** (revisionable, translatable, default FALSE, shown as a `boolean_checkbox` widget). So the
option becomes a real node field on every content type, usable in Views (field/filter/sort), the
node form (a checkbox under the "Custom Publish Options" details, or under core "Promotion options"
if `publish_under_promote_options` is TRUE), and JSON:API/REST. `postDelete()` uninstalls that
field storage when the option is deleted.

The node type edit form is altered so each option appears in the type's "Publishing options"
checkboxes, letting you set the field's default value per content type.

## Scriptable create / read / delete

```php
use Drupal\custom_pub\Entity\CustomPublishingOption;
CustomPublishingOption::create([
  'id' => 'archived',
  'label' => 'Archived',
  'description' => 'Archive without unpublishing',
  'publish_under_promote_options' => FALSE,
])->save();               // installs node base field "archived"

// read
$opt = CustomPublishingOption::load('archived');
$opt->getDescription();
$opt->isPublishUnderPromoteOptions();

// delete (uninstalls the node base field)
CustomPublishingOption::load('archived')->delete();
```

```bash
drush cget custom_pub.custom_publishing_option.archived
drush pm:list # (n/a) — no drush commands; use config + entity API
```

Confirm the field exists: it shows up in
`\Drupal::service('entity_field.manager')->getFieldStorageDefinitions('node')['archived']`.

## Config schema

`custom_pub.custom_publishing_option.*` — id (string), label (label), description (text),
uuid (string), publish_under_promote_options (boolean).
