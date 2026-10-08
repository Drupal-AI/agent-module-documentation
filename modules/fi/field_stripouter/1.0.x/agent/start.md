<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Strip field outer div (field_stripouter) — agent index
**Adds a per-formatter "Strip outer div" third-party setting and exposes it to field templates as `{{ stripouter_valueonly }}`.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Mechanism (all in `field_stripouter.module`):** `hook_field_formatter_third_party_settings_form`, `hook_field_formatter_settings_summary_alter`, `hook_preprocess_field`.
- **Note:** the module only sets the Twig variable; the active theme's `field.html.twig` must actually omit the wrapper markup.
- **Routes/permissions/services:** none.
- **Security:** no routes or permissions; setting lives in manage-display formatter config (already permission-gated). Output helper only, no mutation.