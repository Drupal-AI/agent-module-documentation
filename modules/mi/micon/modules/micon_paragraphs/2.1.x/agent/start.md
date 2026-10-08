<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Paragraphs — agent index

Adds an **Icon** picker to the Paragraphs type form (and hides the core `icon_file` upload);
stores the choice as a third-party setting and shows it in the Paragraphs types list. No
settings form, no `configure` route. Requires the contrib **paragraphs** module.

Key facts (grounded in `micon_paragraphs.module`):
- **Storage:** `paragraphs.paragraphs_type.<bundle>` config →
  `third_party_settings.micon_paragraphs.icon` = an icon selector like `fa-cube`.
  Read with `micon_paragraphs_icon($paragraphs_type)`.
- **Form:** `hook_form_paragraphs_type_form_alter()` adds `$form['icon']` (`#type => 'micon'`)
  and sets `$form['icon_file']['#access'] = FALSE`; an entity builder writes the setting and
  invalidates cache tag `micon.discovery`.
- **List:** paragraphs_type list builder replaced by `MiconParagraphsTypeListBuilder`.
- **String matches:** `hook_micon_icons_alter()` registers `paragraphs.<label>` and
  `paragraphs.<machine_name>` → the bundle's icon.

Set programmatically:
```php
$t = \Drupal\paragraphs\Entity\ParagraphsType::load('text');
$t->setThirdPartySetting('micon_paragraphs', 'icon', 'fa-cube');
$t->save();
```
See the parent `micon` docs for the icon selector / `micon()` API and the `micon_icons` plugin type.
