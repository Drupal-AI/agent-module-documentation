<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Vocabulary — agent index

Adds an **Icon** picker to the taxonomy vocabulary form; stores the choice as a third-party
setting on the vocabulary. No settings form, no `configure` route, no list-builder override.

Key facts (grounded in `micon_vocabulary.module`):
- **Storage:** `taxonomy.vocabulary.<vid>` config →
  `third_party_settings.micon_vocabulary.icon` = an icon selector like `fa-tags`.
  Read with `micon_vocabulary_icon($vocabulary)`.
- **Form:** `hook_form_taxonomy_vocabulary_form_alter()` adds `$form['icon']`
  (`#type => 'micon'`); an entity builder writes the setting and invalidates cache tag
  `micon.discovery`.
- **String match:** `hook_micon_icons_alter()` registers `vocabulary.<lowercased label>`
  (definition id `vocabulary.<vid>`) → the vocabulary's icon.

Set programmatically:
```php
$v = \Drupal\taxonomy\Entity\Vocabulary::load('tags');
$v->setThirdPartySetting('micon_vocabulary', 'icon', 'fa-tags');
$v->save();
```
See the parent `micon` docs for the icon selector / `micon()` API and the `micon_icons` plugin type.
