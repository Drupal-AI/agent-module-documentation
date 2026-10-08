<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telephone (telephone) — agent index

The `telephone` field type, its entry widget and a `tel:` link formatter. **This is core's Telephone
module continued in contrib.** Source `telephone.info.yml` declares
`core_version_requirement: '^11.3 || ^12'`, so 1.0.x installs on Drupal 11.3+ (and Drupal 12). On core
that still ships the module the identical core version applies — same machine name, same plugin ids,
same config. Only dependency: core **`field`**. Package *Field types*. Installed 1.0.1.

Key facts:
- Field type id **`telephone`** → `Plugin\Field\FieldType\TelephoneItem` (`varchar(256)`, single
  `value` string; default widget `telephone_default`, default formatter core `basic_string`).
- Widget id **`telephone_default`** → `TelephoneDefaultWidget` — an HTML5 `#type => 'tel'` input with
  an optional `placeholder`.
- Formatter id **`telephone_link`** → `TelephoneLinkFormatter` — renders a `tel:` `#type => 'link'`
  anchor; optional `title` setting replaces the visible number.
- Hooks are OO (`src/Hook/TelephoneHooks.php`): `#[Hook('help')]`,
  `#[Hook('field_formatter_info_alter')]` (adds `telephone` to core's `string` formatter),
  `#[Hook('field_type_category_info_alter')]` (places the type in the fallback/general category and
  attaches the icon library). `telephone.services.yml` only sets `skip_procedural_hook_scan: true`.
- `telephone.libraries.yml` (`drupal.telephone-icon`) + `css/telephone.icon.theme.css` supply the
  *Add field* icon; `config/schema/telephone.schema.yml` covers widget/formatter settings.
- **No permissions, no routes, no services of its own, no Drush, no submodules.** `configure: null`.
- Validation is length-only (max 256 chars); no phone-number pattern is enforced.

Solution docs:
- **Field type, widget and `tel:` link formatter — settings, config, operation** →
  [fields/field.md](fields/field.md)

Upgrade note: because ids are unchanged, adopting the contrib module is `composer require
drupal/telephone` and nothing else — existing `field.storage.*` / `field.field.*` and display config
keep working. On 11.3 you may need a `"replace": {"drupal/telephone": "*"}` entry (see project page).

```bash
drush cget core.entity_view_display.node.contact.default content.field_phone.type   # telephone_link
```
