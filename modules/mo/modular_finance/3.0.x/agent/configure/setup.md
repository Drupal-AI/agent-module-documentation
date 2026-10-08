<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Modular Finance widgets

1. Enter the global **client token** at `/admin/config/modular_finance/settings` (requires *access administration pages*). Stored in `modular_finance.settings`.
2. Create one or more **Modular finance types** at the type collection (`entity.modular_finance_type.collection`). Each type has a **widget type** and a **widget token** supplied by Modular Finance.
3. Place the **Modular finance block** (`modular_finance_block`) in a region and select the type in the block form.
4. On render the block attaches the `modular_finance/modular-finance` library and exposes, under `drupalSettings.modularFinance[<widgetToken>]`:
   - `query` — `[data-token="<widgetToken>"]` selector
   - `widget` — widget type
   - `token` — widget token
   - `locale` — current language id
   - `c` — the global client token

Notes:
- All rendering happens client-side via the vendor JS; the module makes no server-side request, so there is no TLS/verify option to configure.
- The client token is emitted into the page (client-side) — it is a publishable widget key, not a secret; do not place private credentials in this field.
