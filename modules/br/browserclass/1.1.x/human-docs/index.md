# Browser Class — manual setup guide

**Browser Class** (`browserclass`) adds CSS classes describing the visitor's
browser, platform, and device to the page's `<body>` tag, giving theme developers
convenient hooks for cross‑browser and cross‑device styling. Enable it and classes
like `chrome`, `ff`, `safari`, `ie11`, `win`, `mac`, `iphone`, and `mobile` /
`desktop` appear on `<body>` automatically — no configuration required.

The body classes are added client‑side: on every page the module attaches a small
script that reads the browser's user‑agent, works out the browser (with a major
version, e.g. `ie11` or `ff123`), the platform (`win`, `mac`, `linux`, `android`,
iOS variants, the BSDs, and more), and whether the device is mobile or desktop, and
adds those as classes to `<body>`. Because this happens in the browser, cached
pages still get the correct classes for each visitor.

In parallel, the same detection is available server‑side as **tokens** — for
example `[browserclass:browser-classes]`, `[browserclass:browser]`,
`[browserclass:platform]`, and `[browserclass:device]` — which you can use anywhere
tokens are supported. All token output is sanitized. Other modules can contribute
extra classes by implementing a `browserclass_classes` hook.

One caveat worth keeping in mind: this is old‑school user‑agent sniffing aimed at
legacy and edge‑case browsers, so treat the classes as a styling convenience rather
than a reliable way to detect browser capabilities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page and no permissions. Enable the module and the
body classes and tokens are immediately available.

## How to use it

There is nothing to configure. After enabling the module:

- **In your theme's CSS**, key styles off the body classes — for example
  `body.ie11 .my-widget { … }` for an Internet Explorer fix, `body.mobile { … }`
  for a mobile‑only tweak, or `body.safari { … }` for a Safari quirk. Inspect any
  page's `<body>` tag to see the exact classes applied for your browser.
- **Anywhere tokens are supported** (blocks, messages, some config), print the
  detection with tokens such as `[browserclass:browser-classes]` (the full class
  list), `[browserclass:browser]`, `[browserclass:platform]`, or
  `[browserclass:device]` (`mobile` / `desktop`). The chained `[user:browserclass]`
  and `[site:browserclass]` tokens are also available.
- **From another module**, implement `hook_browserclass_classes($agent)` to merge
  in your own custom classes; they surface in `[browserclass:hook-classes]`.
