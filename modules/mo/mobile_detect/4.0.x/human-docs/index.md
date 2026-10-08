# Mobile Detect — manual setup guide

**Mobile Detect** (`mobile_detect`) wraps the well‑known
`mobiledetect/mobiledetectlib` PHP library as a Drupal service, so your themes,
Twig templates, and block‑visibility rules can react to **what device the
visitor is on** — phone, tablet, iOS, or Android — based on the browser's
User‑Agent string. It is a server‑side detection helper, useful for
device‑specific content decisions that CSS alone can't make.

For site builders, the most visible features work with no code. It ships two
**block‑visibility conditions** — one for **device type** (phone / tablet /
desktop) and one for **platform** (iOS / Android) — so you can show or hide any
block per device from the Block layout UI. It also adds `is-mobile` and
`is-tablet` classes to the page's `<body>` tag automatically, giving your
theme's CSS something to target, and provides a "Mobile Detect Status" block that
confirms detection is working and shows the active library version.

For themers and developers, it adds Twig functions — `is_mobile()`,
`is_tablet()`, `is_device('iPhone')`, `is_ios()`, `is_android_os()` — for
branching template markup, exposes the `mobile_detect` service for PHP, and
registers cache contexts so device‑varying output stays cache‑correct. One
important caveat: User‑Agent detection is not a replacement for responsive CSS,
and spoofed agents or shared caches can affect results — always pair
device‑varying output with the provided cache contexts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, permission,
   block‑visibility conditions, and the status block.

## Where it lives in the admin menu

- The settings form sits at **Configuration → User interface → Mobile Detect**
  (`/admin/config/user-interface/mobile-detect`).
- The block‑visibility conditions appear on each block's **Visibility** tab in
  **Block layout**, and the "Mobile Detect Status" block is placed from Block
  layout too.

## How to use it

Most people use Mobile Detect one of two ways. Site builders place a block and,
on its **Visibility** tab, restrict it by **device type** or **platform** — for
example a "Call us" phone‑link block shown only on phones, or an App Store badge
shown only on iOS. Themers branch templates with the Twig functions, e.g.
`{% if is_mobile() %}…{% endif %}`, or style against the automatic `is-mobile` /
`is-tablet` body classes. See [Configuration](configuration/index.md) for the UI
features and the [`agent/`](../agent/start.md) docs for the Twig functions,
service, and cache contexts.
