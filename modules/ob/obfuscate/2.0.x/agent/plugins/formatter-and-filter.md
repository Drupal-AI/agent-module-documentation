<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Obfuscate: field formatter & text filter

These are ordinary core plugins (Field formatter + Filter). The module defines **no** plugin
type/manager of its own.

## Email field formatter — `obfuscate_field_formatter`

Class `ObfuscateFieldFormatter` (`FormatterBase`), label "Obfuscate", for field type `email`.

- **Settings** (`settingsForm`):
  - `obfuscate_method` — radios `html_entity` / `rot_13`. Default comes from
    `obfuscate.settings:obfuscate.method` (so it inherits the system-wide method but overrides
    it per field instance).
  - `link_label` — optional custom link text shown instead of the address; supports **tokens**
    (entity tokens, replaced in `viewElements` via `\Drupal::token()`), rendered with a
    `token_tree_link`.
- **Render** (`viewElements`): for each item calls
  `ObfuscateMailFactory::get($method)->getObfuscatedLink($item->value, [], $linkLabel)`.

Set it on *Manage display* of any Email field, e.g. via Drush:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_email', [
  'type' => 'obfuscate_field_formatter',
  'settings' => ['obfuscate_method' => 'rot_13', 'link_label' => 'Contact [node:title]'],
])->save();
```

## Text filter — `obfuscate_mail`

Class `Plugin\Filter\ObfuscateMail`, title "Email address obfuscation filter", type
`TYPE_TRANSFORM_IRREVERSIBLE`. Enable it on a text format at
*Configuration → Content authoring → Text formats and editors*.

- `process()`:
  1. Placeholders out inline base64 `data:` images (so large images don't break the regex), then
     restores them at the end.
  2. Converts `mailto:` links (`callbackMailto`) and bare addresses (`callbackBareEmailAddresses`),
     each via the `obfuscate_mail` service → `getObfuscatedLink()`. Regex patterns are ported from
     the SpamSpan module and match addresses / `mailto:` URLs (with optional query string).
  3. Safeguards already-ROT13-obfuscated spans across passes (DOM-based `rot13Safeguard` /
     `restoreRot13Safeguard`).
  4. Runs `Xss::filter()` on the final text and attaches the `obfuscate/rot13` library.
- Uses the **system-wide** method (no per-filter setting). `tips()` says each address is
  obfuscated with the system-wide configuration.

Both paths ultimately call the same method classes documented in
[../api/service-and-twig.md](../api/service-and-twig.md).
