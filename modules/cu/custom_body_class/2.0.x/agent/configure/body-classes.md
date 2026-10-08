<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding body classes (per node and per content type)

No settings page (`configure: null`). There are three sources of body classes, all read by
`custom_body_class_preprocess_html()` for the node on the current route.

## 1. Per-node class — the `body_class` base field

`hook_entity_base_field_info()` adds a `string` base field `body_class` ("Add CSS class(es)")
to **every** node. Editors fill it in under *Custom Body Class Settings* on the node form.
Space-separate multiple classes.

```php
// Set on a node programmatically:
$node->set('body_class', 'promo-page featured');
$node->save();
```

At render, `$variables['attributes']['class'][]` gets `body_class[0]['value']`.

## 2. Per-node content-type flag — `specific_node_class`

A boolean base field ("If checked, add name of node type as class to body tag."). When TRUE,
the node's **content-type machine name** is added as a class (e.g. an Article node gets
`article`).

```php
$node->set('specific_node_class', TRUE)->save();
```

## 3. Per-content-type classes — node-type third-party setting

On the *node type edit* form (`/admin/structure/types/manage/<bundle>`) a "Custom Body Class
Settings" group adds a **CSS class(es)** textfield. Its value is stored as a third-party
setting on the `node_type` config entity:

```
node.type.<bundle>  →  third_party_settings.custom_body_class.classes: "<space separated>"
```

```php
// Set for the Article content type:
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('article');
$type->setThirdPartySetting('custom_body_class', 'classes', 'campaign-2026')->save();

// Read back:
$type->getThirdPartySetting('custom_body_class', 'classes', '');
```

```bash
drush cget node.type.article third_party_settings.custom_body_class.classes
```

Every node of that bundle then gets those classes on its `<body>`.

## Render order

`custom_body_class_preprocess_html()` appends, in order: the node's `body_class` value → the
node type name (if `specific_node_class`) → the content type's stored `classes`. All land in
the body tag's `class` attribute.

## Validation

`custom_body_class_node_special_character_form_validate()` sets a form error if the class
inputs contain any of `' ^ £ $ % & * ( ) } { @ # ~ ? > < , | = + ¬`. Stick to normal CSS
identifier characters (letters, digits, `-`, `_`) plus spaces to separate multiple classes.
