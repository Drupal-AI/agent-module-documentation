<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Browser Class adds CSS classes describing the visitor's browser, platform, and device (mobile/desktop) to the page's `<body>` tag, giving theme developers hooks for cross-browser and cross-device styling.

---

The module works entirely client-side for the body classes: `hook_page_attachments_alter()` attaches the `browserclass/global-browserclass` library on every page, and its JavaScript (`js/browserclass.min.js`, depends on `core/jquery`) reads `navigator.userAgent`, derives a list of classes (browser name + major version, platform, and `mobile`/`desktop`), and `addClass()`es them to `<body>`. Detected browsers include IE (with version, e.g. `ie11`), Chrome/CriOS, Safari, Firefox (`ff`/`ff123`), Opera, Opera Mini, Netscape, Konqueror, and several niche engines; platforms include Windows (`win`), macOS (`mac`), Linux, Android, iOS variants (`ipad`/`ipod`/`iphone`), the BSDs, Nokia, and BlackBerry. In parallel, a PHP side (`browserclass.tokens.inc`) provides the same detection server-side from `$_SERVER['HTTP_USER_AGENT']` and exposes it as tokens (`[browserclass:browser-classes]`, `[browserclass:browser]`, `[browserclass:platform]`, `[browserclass:device]`, `[browserclass:hook-classes]`, plus `[user:browserclass]` / `[site:browserclass]`), each `Html::escape()`-sanitized. Other modules can contribute extra classes by implementing a `browserclass_classes` hook. There is no admin UI, no configuration, and no permissions — enable it and the classes appear. Note the module is old-school user-agent sniffing: version detection targets legacy browsers and mobile heuristics, so treat it as a styling convenience rather than reliable capability detection.

---

- Add `ie`/`ie11`-style classes to `<body>` to apply Internet Explorer-specific CSS fixes.
- Target Safari-only rendering quirks with a `safari` body class.
- Apply Firefox-specific styles using the `ff` (and `ff<version>`) class.
- Style Chrome differently via the `chrome` / `chrome<version>` class.
- Differentiate desktop vs mobile layouts using the `mobile` / `desktop` body classes.
- Apply platform-specific styling with `win`, `mac`, `linux`, `android`, `iphone`, `ipad` classes.
- Provide iOS-only tweaks by keying off `iphone` / `ipad` / `ipod`.
- Hide or restyle a feature that misbehaves in Opera Mini using the `operamini` class.
- Give legacy/niche browsers (Konqueror, Netscape, Lynx, etc.) fallback styling hooks.
- Print the visitor's browser classes anywhere tokens are supported via `[browserclass:browser-classes]`.
- Output just the browser name (`[browserclass:browser]`) or platform (`[browserclass:platform]`) in a template or config.
- Insert a device string with `[browserclass:device]` in a block, node, or message.
- Use `[user:browserclass]` / `[site:browserclass]` chained tokens where a browserclass type is expected.
- Let another module inject custom body classes by implementing the `browserclass_classes` hook.
- Give a theme a consistent set of body classes without writing custom user-agent JS.
- Serve a "please upgrade your browser" banner styled/targeted by the IE version class.
- Adjust touch-target sizes only for mobile devices detected by the module.
- Add analytics or QA hooks that read the browserclass tokens server-side.
- Provide quick cross-browser bug reproduction by inspecting the applied body classes.
