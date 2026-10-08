<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module settings (`mask.settings`)

Configure route **`mask.settings`** → `admin/config/content/mask` (permission
`administer mask module`). Config object `mask.settings`, schema in `config/schema/mask.schema.yml`.

## Keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `use_cdn` | boolean | `true` | Serve the jQuery Mask Plugin from a CDN. |
| `plugin_path` | string | `''` | Local `public://` path to the minified library when not using the CDN. |
| `translation` | sequence | shipped 5 symbols | The placeholder-symbol → regex table. |

When `use_cdn` is true the library loads from
`https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js`
(`Drupal\mask\Mask::getCdnUrl()`). When false, the settings form will try to download the
library to `public://jquery.mask.min.js` on save, or you point `plugin_path` at a file that
must live under `public://`.

## Translation symbols (the mask alphabet)

Each mask character in a field's `value` is one of these symbols. Shipped defaults (all
`locked: true`, cannot be edited/removed):

| Symbol | Pattern | Meaning | Flags |
|---|---|---|---|
| `0` | `\d` | a number | |
| `9` | `\d` | optional number | `optional` |
| `#` | `\d` | repeating number | `recursive` |
| `A` | `[a-zA-Z0-9]` | a letter or a number | |
| `S` | `[a-zA-Z]` | a letter | |

So a mask `00/00/0000` accepts a date; `(00) 0000-0000` a phone; `AAA-000` three
alphanumerics, a dash, three digits.

## Adding a custom symbol

On the settings form, **Add another** row and set: Symbol (1 char), Pattern (a regex char
class), optional Fallback/Description, and Optional/Recursive flags. Saved into
`mask.settings` `translation` keyed by the symbol. Scriptable:

```php
$cfg = \Drupal::configFactory()->getEditable('mask.settings');
$t = $cfg->get('translation');
$t['Z'] = ['pattern' => '[a-z]', 'fallback' => '', 'description' => 'lowercase',
           'optional' => FALSE, 'recursive' => FALSE, 'locked' => FALSE];
$cfg->set('translation', $t)->save();
```

The symbol table is also surfaced (read-only) in each field's **Available patterns** details on
Manage form display. The five shipped symbols are `locked` and cannot be altered via the form.
