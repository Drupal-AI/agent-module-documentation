<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The obfuscation formatters

## The three formatters

Chosen per field on the bundle's **Manage display** (`entity_view_display`):

| Formatter id | Field type | Transform before encrypt |
|---|---|---|
| `altcha_obfuscated_email` | `email` | prefixes `mailto:` |
| `altcha_obfuscated_telephone` | `telephone` | prefixes `tel:` |
| `altcha_obfuscated_string` | `string` | value as-is |

(`AltchaObfuscatedEmailFormatter` / `...TelephoneFormatter` extend the string formatter and
just override the transform.)

Set programmatically:
```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_contact_email', [
  'type' => 'altcha_obfuscated_email',
  'label' => 'hidden',
  'settings' => ['reveal_text_override' => 'Show address'],
])->save();
```
Stored as `content.<field>.type = altcha_obfuscated_email` in the view-display config.

## Settings

- **Per-formatter:** `reveal_text_override` (string) — overrides the reveal-button text for
  this field only. Schema: `field.formatter.settings.altcha_obfuscated_{email,string,telephone}`.
- **Global (`altcha.settings`, shared with the parent module):**
  - `obfuscate_reveal_text` — default "Click to reveal" button text.
  - `obfuscate_max_number` — obfuscation proof-of-work complexity.
  - `obfuscate_library_override` — custom obfuscation JS library.
  - `hide_logo` / `hide_footer` and the i18n label overrides also apply.

## How it renders

`AltchaObfuscatedFormatterBase::viewElements()`:

1. Encrypts each value with `ObfuscationUtility::encrypt()` — AES-256-GCM (`ext-openssl`),
   IV derived from a random number bounded by `obfuscate_max_number`; output base64.
2. Emits an `altcha_widget` element with `plugins => 'obfuscation'`, `floating => TRUE`
   (forced), the encrypted `obfuscated` attribute, and a themed
   `altcha_obfuscate_reveal_button` ("Click to reveal", or `reveal_text_override`).
3. The visitor's browser runs the ALTCHA obfuscation plugin's proof-of-work to decrypt and
   show the real value — so the plaintext is never in the initial HTML.

No plugin type is defined here; these are ordinary field-formatter plugins. To customize
reveal text globally use `obfuscate_reveal_text`; per field use `reveal_text_override`.
