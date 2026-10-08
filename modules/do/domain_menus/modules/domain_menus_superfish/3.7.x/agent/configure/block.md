<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Superfish domain menu block

Plugin: `domain_menus_active_domain_superfish_block` (`DomainMenusSuperfishBlock`), category
**Superfish**, `admin_label` "Domain menus active domain menu". It subclasses
`Drupal\superfish\Plugin\Block\SuperfishBlock`, so its configuration form is Superfish's full block
form **plus** one added select at the top:

- **`menu_name`** (required) — options are the domain-menu names read from
  `domain_menus.settings:domain_menus_menu_names` (newline-split). This is a *name* (e.g. `main`),
  not a menu id.

At render, `getDerivativeId()` builds the actual menu id
`sprintf('dm%u-%s', $activeDomain->getDomainId(), $menu_name)` — i.e. `dm<activeDomainId>-<name>` —
so one placement follows whichever domain is active.

## Place it (UI)

1. Go to *Structure → Block layout* (`/admin/structure/block`).
2. Add block in a region → choose **Domain menus active domain menu** (Superfish category).
3. Set **Domain menu name** and any Superfish options, then Save.

## Place it via config (drush)

```php
$block = \Drupal\block\Entity\Block::create([
  'id' => 'domainsuperfish_main',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content',
  'plugin' => 'domain_menus_active_domain_superfish_block',
  'settings' => [
    'id' => 'domain_menus_active_domain_superfish_block',
    'label' => 'Active domain Superfish menu',
    'menu_name' => 'main',
  ],
]);
$block->save();
// read back: drush cget block.block.domainsuperfish_main settings.menu_name
```

Note: the block only renders correctly when at least one Domain exists (its derivative id needs an
active domain). Placement/config, however, works regardless. There is no other configuration surface
in this submodule.
