# Place the toggle & the front-end contract

There is **no admin settings page** (`configure: null`). "Configuration" is (1) placing the
block and (2) writing theme CSS that reacts to the mode attribute.

## Place the block

UI: *Structure → Block layout* (`/admin/structure/block`), click **Place block** in a region,
choose **Dark Mode Toggle**, save. Standard core block visibility (pages, roles, content
types) applies.

Via config, a placement is a `block` config entity `block.block.<id>` with
`plugin: dark_mode_toggle`, e.g. scripted:

```php
\Drupal\block\Entity\Block::create([
  'id' => 'olivero_dark_mode_toggle',
  'theme' => 'olivero',
  'region' => 'content',
  'plugin' => 'dark_mode_toggle',
  'settings' => ['id' => 'dark_mode_toggle', 'label' => 'Dark Mode Toggle', 'label_display' => '0'],
  'visibility' => [],
])->save();
```

Read it back: `drush cget block.block.olivero_dark_mode_toggle plugin` → `dark_mode_toggle`.

## The attribute + storage contract (what your theme CSS keys off)

The JS keeps two attributes on the `<html>` element:

| Attribute | Values | Meaning |
|---|---|---|
| `data-dmt-mode` | `dark` \| `light` | the active variant — **style off this** |
| `data-dmt-source` | `user` \| `system` | whether the user chose it or it follows the OS |

- Clicking **Light**/**Dark** → `localStorage['dmt-mode'] = 'light'|'dark'`, source `user`.
- Clicking **System** → removes `localStorage['dmt-mode']`, mode follows
  `matchMedia('(prefers-color-scheme: dark)')`, source `system`, and keeps updating live if
  the OS preference changes.
- `dark-mode-toggle.init.js` runs in the `<head>` and applies the stored/OS value **before
  paint** to prevent a flash of the wrong theme.

The module changes nothing visually on its own. Example theme CSS:

```css
:root[data-dmt-mode="dark"] { --bg: #111; --fg: #eee; }
```

Tailwind (per the README):

```
@custom-variant dark (&:where([data-dmt-mode=dark], [data-dmt-mode=dark] *));
```
