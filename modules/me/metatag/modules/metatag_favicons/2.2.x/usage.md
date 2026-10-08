Adds favicon and touch-icon `<link>` meta tags for the many icon variants modern browsers and mobile devices expect.

---

Modern sites need more than one favicon: browsers, iOS home-screen icons, Safari pinned-tab masks, and various resolutions all use different `<link rel>` tags. This submodule registers those icon links as Metatag plugins, covering the standard `icon`, Apple touch icons (precomposed and standard, across resolutions), and Safari `mask-icon`. Set them as global defaults so every page advertises the full icon set, or override per section. Depends on the main Metatag module. Token support lets you point at managed files or theme paths.

---

- Set the standard `icon` (favicon) link.
- Provide Apple touch icons for iOS home-screen bookmarks (`apple-touch-icon`).
- Provide precomposed Apple touch icons (`apple-touch-icon-precomposed`).
- Supply multiple touch-icon resolutions (57×57 up to 180×180).
- Set a Safari pinned-tab `mask-icon` with a theme color.
- Advertise a high-resolution favicon for retina displays.
- Configure icons globally so all pages share them.
- Override icons for a specific section or campaign.
- Point icon URLs at managed files via tokens.
- Provide iPad-specific touch icons.
- Provide iPhone-specific touch icons.
- Ensure bookmarks look correct on iOS.
- Ensure pinned tabs look correct in Safari.
- Keep icon configuration in exportable config.
- Replace theme-hardcoded favicon markup with managed tags.
- Support Android/Chrome home-screen icons.
- Standardize favicons across a multisite platform.
- Update the whole icon set from one config screen.
