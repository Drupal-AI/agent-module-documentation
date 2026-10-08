<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu block options & filtering rules

Menu Multilingual has **no settings page**. You configure it per menu block, on the block's
configuration form (Block layout, `/admin/structure/block`, or any place a menu block is placed).

## The two options (third-party settings)

Under a "Multilingual options" details on the block form:

| Checkbox | Third-party setting | Effect |
|---|---|---|
| Hide menu items without translated label | `only_translated_labels` | Drops links whose `menu_link_content` (or `ViewsMenuLink` view) has no translation in the current language |
| Hide menu items without translated content | `only_translated_content` | Drops links whose target entity isn't in / translated to the current language |

Stored on the block config entity:
```yaml
# block.block.<block_id>
third_party_settings:
  menu_multilingual:
    only_translated_labels: true
    only_translated_content: false
```
Schema: `block.block.*.third_party.menu_multilingual` (two booleans). The "content" checkbox is
disabled unless `node` translation is enabled; the "label" checkbox unless `menu_link_content`
translation is enabled.

Only blocks whose plugin id is `menu_block` or `system_menu_block` get these options
(`Helpers::isMenuBlock()`), and filtering only runs when at least one option is TRUE
(`Helpers::hasMenuMultilingualValues()`).

## Read / set from code or drush

```bash
drush cget block.block.<block_id> third_party_settings.menu_multilingual
```
```php
$block->setThirdPartySetting('menu_multilingual', 'only_translated_labels', TRUE);
$block->setThirdPartySetting('menu_multilingual', 'only_translated_content', FALSE);
$block->save();
```

## Filtering rules (what counts as "translated")

Applied by `menu_multilingual.modifier` for the current language:

- **Label check** — a `menu_link_content` link passes if the current language equals its
  langcode, or it has a translation in that language. A `ViewsMenuLink` passes if the view's
  config has that language (or a language config override exists for it).
- **Content check** — only applies to links routing to an entity (`entity.*` route). The linked
  entity passes if its langcode is the current language or it has a translation in it.
- **Both enabled** — a link must pass **both** checks.
- **"Not applicable" (`zxx`) / non-translatable entities** — always kept (belong to all languages).
- **"Not specified" (`und`)** — always filtered out as untranslated.
- **Children** — when a menu item is filtered, all of its sub-items are removed with it. If a
  block ends up with no items, the block renders empty.

Cache: after adding a menu item or changing block settings, run `drush cr` (menu/block render
caching can otherwise show stale results).
