# Configuration

Mobile Detect works the moment it is enabled — the settings form holds a single
(optional, experimental) toggle. Most of the day‑to‑day "configuration" is done
per block via the visibility conditions.

## The settings form

1. Go to **Configuration → User interface → Mobile Detect**
   (`/admin/config/user-interface/mobile-detect`). You need the **Administer
   mobile_detect configuration** permission.
2. The form has one option:
   - **Add the is‑mobile page cache context globally** (`mobile_detect_is_mobile`,
     off by default). This is **experimental**. When on, it adds the
     `mobile_detect_is_mobile` cache context to *every* page, so the whole page
     cache is split by mobile vs non‑mobile. Turn it on only if you serve
     meaningfully different markup to mobile site‑wide; it increases the number
     of cached page variants.
3. Click **Save configuration**.

## Permission

The module defines one permission:

- **Administer mobile_detect configuration** — controls access to the settings
  form above. Grant it only to trusted administrators at **People → Permissions**.

## Block‑visibility conditions

This is where most configuration happens, and it needs no code. When you place or
edit a block in **Block layout**, open its **Visibility** tab. Two conditions
from this module appear:

### Device type

Tick the device types the block should show on:

- **Phone**
- **Tablet**
- **Desktop**

Leave all boxes empty to match every device. There is also a **negate** option
("The device is *not*…") to invert the rule — for example, show a block on
everything *except* phones.

### Device platform

Tick the platforms the block should show on:

- **Android**
- **iOS**

As with device type, an empty selection matches everything, and a negate option
is available.

You can combine these with each other and with Drupal's other visibility rules
(pages, roles, content types) for fine‑grained targeting. Both conditions add
their matching cache context automatically, so placement stays cache‑correct.

## The status block

The module provides a **Mobile Detect Status** block (place it from **Block
layout**). It has no settings of its own; it simply displays the detected state
and the active Mobile_Detect library version, which is handy for confirming
detection works on a given page. Scope where it appears using the visibility
conditions above.

## For themers and developers

Beyond the UI, the module exposes Twig functions (`is_mobile()`, `is_tablet()`,
`is_device()`, `is_ios()`, `is_android_os()`), the `mobile_detect` PHP service,
and three cache contexts for varying render output by device. Those are covered
in the [`agent/api/detection.md`](../../agent/api/detection.md) reference.
