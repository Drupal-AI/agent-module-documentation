<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Mega Menu block

We Mega Menu does **not define a plugin *type*** of its own. It provides one core Block plugin,
rendered once per menu via a derivative.

## `we_megamenu_block` (derivative-per-menu)

`src/Plugin/Block/WeMegaMenuBlock.php`:

```php
@Block(
  id = "we_megamenu_block",
  admin_label = @Translation("Mega Menu"),
  category = @Translation("Drupal 8 Mega Menu"),
  deriver = "Drupal\we_megamenu\Plugin\Derivative\WeMegaMenuBlock",
)
```

The deriver (`src/Plugin/Derivative/WeMegaMenuBlock.php`) loads **every menu**
(`Menu::loadMultiple()`) and creates one derivative per menu, so the block library shows a
**"Mega Menu" block for each menu** under the category **"Drupal 8 Mega Menu"**. The full plugin
id is `we_megamenu_block:<menu_name>` (e.g. `we_megamenu_block:main`).

`build()` returns a `we_megamenu_frontend` render element for the block's derivative id
(the menu name), attaches the `we_megamenu/form.we-mega-menu-frontend` library, and renders using
the site's **default theme** as the `block_theme`. Cache tags include
`config:system.menu.<menu>` and `we_mega_menu.block.<menu>`; a cache context of
`route.menu_active_trails:<menu>` is added.

## Placing it

- **UI:** Structure > Block layout > *Place block* in a region, pick the "Mega Menu" block for
  your menu (category "Drupal 8 Mega Menu"), Save.
- **Code / config:**

```php
\Drupal\block\Entity\Block::create([
  'id' => 'olivero_megamenu_main',
  'theme' => 'olivero',
  'region' => 'header',
  'plugin' => 'we_megamenu_block:main',
  'settings' => ['id' => 'we_megamenu_block:main', 'label' => 'Main mega menu', 'label_display' => FALSE],
])->save();
```

A menu only renders as a mega menu when **both** a `we_megamenu` table row exists for
`(menu_name, theme)` (see [../configure/megamenus.md](../configure/megamenus.md)) **and** this
block is placed. If no row exists yet, the front-end preprocess auto-seeds one via
`WeMegaMenuBuilder::initMegamenu()` on first render.

## Contextual link

`we_megamenu.links.contextual.yml` adds a **"Mega Menu Configure"** contextual link on the block,
routing to the builder (`we_megamenu.admin.configure`) for that menu.
