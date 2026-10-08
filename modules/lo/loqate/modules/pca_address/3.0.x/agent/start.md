<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PCA Address (Loqate submodule) — agent index

Adds Loqate autocomplete to the **Address** module. Depends on `loqate` + `address`. No config UI, no
permissions, no Drush.

- **The `pca_address_advanced` field widget + element, settings, how to enable** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Field widget id **`pca_address_advanced`** (`AddressPcaAddressWidget` extends Address
  `AddressDefaultWidget`); form element **`pca_address_advanced`** (`AddressPcaAddress` extends
  Address `Address`).
- Both `use` the base module's `PcaAddressFieldWidgetTrait` / `PcaAddressElementTrait` — all the
  Loqate wiring, field mapping and key resolution live there (see
  [../../../../3.0.x/agent/api/element.md](../../../../3.0.x/agent/api/element.md)).
- Widget settings: `show_address_fields`, `allow_manual_input`, `loqate_api_key` (per-widget Key
  override, else site default). API key + default mapping come from base `loqate` config.
