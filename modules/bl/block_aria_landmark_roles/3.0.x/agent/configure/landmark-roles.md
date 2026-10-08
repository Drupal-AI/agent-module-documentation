<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting an ARIA landmark role on a block

## Where it lives

```yaml
# block.block.<block_id>
third_party_settings:
  block_aria_landmark_roles:
    role: navigation      # or none / application / banner / complementary /
                          # contentinfo / form / main / search
    label: 'Main menu'    # free text -> aria-label
```

Schema: `block.block.*.third_party.block_aria_landmark_roles` with a `Choice` constraint on
`role` limiting it to exactly those nine values, and `label` typed as `label`.

## Via the UI

1. *Structure › Block layout*, click **Configure** on any block
   (`/admin/structure/block/manage/<block_id>`).
2. Open **Block ARIA Landmark Roles settings** (a `details` element, open by default).
3. Pick a **Landmark role** and/or type a **Label**.
4. Save block.

No extra permission — the form only appears where you can already configure blocks.

## Via drush / PHP

```php
$block = \Drupal\block\Entity\Block::load('olivero_main_menu');
$block->setThirdPartySetting('block_aria_landmark_roles', 'role', 'navigation');
$block->setThirdPartySetting('block_aria_landmark_roles', 'label', 'Main menu');
$block->save();
```

Read it back:

```bash
drush cget block.block.olivero_main_menu third_party_settings
drush ev 'print \Drupal\block\Entity\Block::load("olivero_main_menu")
  ->getThirdPartySetting("block_aria_landmark_roles", "role") . PHP_EOL;'
```

Remove it again:

```php
$block->unsetThirdPartySetting('block_aria_landmark_roles', 'role');   // or set it to 'none'
$block->save();
```

## What gets rendered

`block_aria_landmark_roles_preprocess_block()`:

```php
$role = $block->getThirdPartySetting('block_aria_landmark_roles', 'role');
if ($role && $role !== 'none') {
  $variables['attributes']['role'] = $role;
}
if ($label = $block->getThirdPartySetting('block_aria_landmark_roles', 'label')) {
  $variables['attributes']['aria-label'] = $label;
}
```

- `role: none` or an unset role → **no `role` attribute at all**.
- An empty `label` → no `aria-label`.
- The two settings are independent: you can set only a label.
- Attributes are added to `$variables['attributes']`, so they appear wherever the active theme's
  `block.html.twig` prints `{{ attributes }}` (Olivero and Claro both do, on the block wrapper).
- The preprocess only runs when `$variables['elements']['#id']` is set, i.e. for blocks that are
  real `block` config entities (placed blocks), not for arbitrary render arrays.

## The role list in code

```php
Drupal\block_aria_landmark_roles\BlockAriaLandmarkRoles::get();            // indexed array
Drupal\block_aria_landmark_roles\BlockAriaLandmarkRoles::getAssociative(); // value => value
```

Both return: `application`, `banner`, `complementary`, `contentinfo`, `form`, `main`,
`navigation`, `search`. The form prepends `'none' => '- None -'`.

## Auditing a whole site

```bash
drush ev 'foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
  $r = $b->getThirdPartySetting("block_aria_landmark_roles", "role");
  $l = $b->getThirdPartySetting("block_aria_landmark_roles", "label");
  if ($r || $l) { print $b->id() . " role=" . ($r ?: "-") . " label=" . ($l ?: "-") . PHP_EOL; }
}'
```
