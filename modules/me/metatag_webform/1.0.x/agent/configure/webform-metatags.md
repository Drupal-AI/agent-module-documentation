<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set and read a webform's meta tags

Metatag Webform has **no global configure route** (`configure: null`). Metatags are set
per webform.

## Via the UI

1. Go to **Structure → Webforms** (`/admin/structure/webform`), click **Build** (or Settings)
   on a webform.
2. Open the **Settings** primary tab, then the **Metatags** secondary tab
   (`/admin/structure/webform/manage/<webform_id>/metatags`).
3. Fill in any Metatag fields (Basic tags like Page title / Description, Open Graph, Twitter
   cards …). The "type" selector is hidden — the type is always `webform`.
4. **Save** ("Webform metatags saved."). Rebuild caches if needed.

Access is controlled by Webform's own `update` access on that webform
(`_entity_access: webform.update`) — no dedicated permission.

## Where it is stored

A **`metatag_defaults`** config entity (Metatag's own entity type), id `webform.<webform_id>`:

```
config name: metatag.metatag_defaults.webform.<webform_id>
id:     webform.<webform_id>
label:  'Webform: <webform title>'
status: true
tags:
  title: '...'
  description: '...'
  # any Metatag tag plugin id => value
```

Read it back:

```bash
drush cget metatag.metatag_defaults.webform.contact
# or
drush ev '\Drupal::entityTypeManager()->getStorage("metatag_defaults")->load("webform.contact")->get("tags");'
```

## How the tags reach the page

`metatag_webform_metatags_alter()` runs on the webform **canonical** route
(`entity.webform.canonical`), loads the enabled `webform.<id>` defaults, and
`array_merge`s its `tags` into the page metatags — so only tags you set override the site
defaults, on that webform's page only.

## Scriptable (drush php:eval)

```php
use Drupal\metatag\Entity\MetatagDefaults;
$md = MetatagDefaults::load('webform.contact')
   ?? MetatagDefaults::create(['id' => 'webform.contact', 'label' => 'Webform: Contact']);
$md->set('tags', ['title' => 'Contact us | Acme', 'description' => 'Get in touch.']);
$md->setStatus(TRUE);
$md->save();
```

## Lifecycle

- Deleting the webform deletes its `webform.<id>` defaults (`hook_entity_delete()`).
- Uninstalling the module deletes **all** `webform.*` metatag defaults (`hook_uninstall()`).
