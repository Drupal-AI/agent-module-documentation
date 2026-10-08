<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# X-frame-options Configuration — agent index

Sets the `X-Frame-Options` HTTP response header site-wide (clickjacking protection) via a kernel
response subscriber. Project `x_frame_options`; **enabled module machine name is
`x_frame_options_configuration`** (all routes/config/services use that name).

- **The directive options, the config object & its nested keys, drush read/write** →
  [configure/header.md](configure/header.md)

Key facts: config object `x_frame_options_configuration.settings` with nested keys
`x_frame_options_configuration.directive` (`DENY` | `SAMEORIGIN` | `ALLOW-FROM` | `ALLOW-ALL`) and
`x_frame_options_configuration.allow-from-uri`. Route
`x_frame_options_configuration.settings` at
`admin/config/system/x_frame_options_configuration/settings` (permission
`administer site configuration`). Subscriber `XframeSubscriber` runs at RESPONSE priority -20;
`ALLOW-ALL` removes the header. No config schema/default config (empty until first save → header
falls back to `0`). No permissions, no Drush, no plugins.
