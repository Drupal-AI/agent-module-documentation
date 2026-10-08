<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Content Type — agent index

Adds an **Icon** picker to the node type form; stores the choice as a third-party setting and
shows it in the content-types list. No settings form, no `configure` route, no permissions of
its own (the node type form is gated by `administer content types`).

Key facts (grounded in `micon_content_type.module`):
- **Storage:** `node.type.<bundle>` config → `third_party_settings.micon_content_type.icon`
  = an icon selector like `fa-file`. Read with `micon_content_type_icon($node_type)`.
- **Form:** `hook_form_node_type_form_alter()` adds `$form['icon']` (`#type => 'micon'`); an
  entity builder writes the third-party setting and invalidates cache tag `micon.discovery`.
- **List:** node_type list builder replaced by `MiconContentTypeListBuilder` (adds an Icon column).
- **String matches:** `hook_micon_icons_alter()` registers `content_type.<label>` and
  `content_type.<machine_name>` → the type's icon, so `micon('content_type.article')` resolves.

Set programmatically:
```php
$t = \Drupal\node\Entity\NodeType::load('article');
$t->setThirdPartySetting('micon_content_type', 'icon', 'fa-file');
$t->save();
```
See the parent `micon` docs for the icon selector / `micon()` API and the `micon_icons` plugin type.
