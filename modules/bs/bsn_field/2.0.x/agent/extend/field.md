<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the BSN field

## Attach to an entity
Add a field of type **BSN** through Field UI, or in config the field type id is `bsn`. Default widget `bsn_default` (`BSNDefaultWidget`); display uses the core `string` formatter (registered for `bsn` via `bsn_field_field_formatter_info_alter()`).

## In a Webform
Enable the module and add the **BSN** element (`Plugin/WebformElement/BSNField`) to any Webform to collect a validated BSN.

## Validation
All paths funnel through `_bsn_field_elfproef(string $bsn): bool` in `bsn_field.module`:
- reverses the digits; multiplies each by its position weight, except the **last** digit is multiplied by `-1` (the module's modification of the standard elfproef);
- passes only when `sum % 11 < 1` **and** `7 < log10(bsn) < 9` (magnitude in the plausible BSN range).

The field constraint (`BSNItem::getConstraints()`) and the render element (`BSNElement::validateBsn()`) both enforce this; an invalid value raises “Provide a valid BSN number.” Reuse the helper for custom validation if needed.
