<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block-visibility Condition plugins

Two core-`Condition`-type plugins the module ships. Use them under a block's *Visibility*
settings (or anywhere the condition system runs). Both add their matching cache context so
placement stays cache-correct, and both evaluate TRUE for **all** requests when left empty.

## `mobile_detect_device_type` — Device type

Class `MobileDetectDeviceType`, `@Condition(id = "mobile_detect_device_type", label = "Device type")`.
Configuration key **`devices`** (sequence). Checkbox options:

- `phone` — Phone
- `tablet` — Tablet
- `desktop` — Desktop

Config schema `condition.plugin.mobile_detect_device_type` → `devices: sequence of string`.
Supports negation ("The device is **not** …"). Example block-visibility config:

```yaml
visibility:
  mobile_detect_device_type:
    id: mobile_detect_device_type
    devices: { phone: phone }
    negate: false
```

## `mobile_detect_platform` — Device platform

Class `MobileDetectPlatform`, `@Condition(id = "mobile_detect_platform", label = "Device platform")`.
Configuration key **`platform`** (sequence). Checkbox options:

- `android` — Android
- `ios` — iOS

Config schema `condition.plugin.mobile_detect_platform` → `platform: sequence of string`.
Also supports negation.

```yaml
visibility:
  mobile_detect_platform:
    id: mobile_detect_platform
    platform: { ios: ios }
    negate: false
```

Both are configured through the Block layout UI (place a block → Visibility tab) — no code
required. Empty selection = matches everything.
