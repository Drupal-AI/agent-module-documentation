Adds ~34 mobile and browser-UI meta tags (viewport, theme-color, Apple web-app, Microsoft tile/pinned-site) to control how the site behaves on phones and tablets.

---

Mobile browsers and OS integrations read many meta tags to tune rendering and home-screen behavior: `viewport` for responsive scaling, `theme-color` for the browser chrome, Apple `apple-mobile-web-app-*` tags for full-screen web apps, and a large `msapplication-*` family for Windows tiles and pinned sites. This submodule registers all of them as Metatag plugins so they can be set as global defaults or per entity, token-enabled. Depends on the main Metatag module. Useful for progressive-web-app-like behavior, branded browser UI, and correct mobile rendering.

---

- Set the responsive `viewport` (width=device-width, initial-scale).
- Set the browser `theme-color` to match your brand.
- Enable full-screen iOS web-app mode (`apple-mobile-web-app-capable`).
- Set the iOS status-bar style (`apple-mobile-web-app-status-bar-style`).
- Set the iOS web-app title (`apple-mobile-web-app-title`).
- Promote a native app via `apple-itunes-app` smart banner.
- Disable auto-detection of phone numbers (`format-detection`).
- Declare an `application-name` for pinned sites.
- Point to a web-app `manifest`.
- Set Windows tile color (`msapplication-tilecolor`).
- Set Windows tile image (`msapplication-tileimage`).
- Configure Windows square/wide logo tiles (70×70…310×310).
- Set the pinned-site start URL (`msapplication-starturl`).
- Add pinned-site jump-list tasks (`msapplication-task`).
- Set the pinned-site navbutton color.
- Provide a tooltip for pinned sites (`msapplication-tooltip`).
- Enable ClearType hint (`cleartype`).
- Declare `HandheldFriendly` / `MobileOptimized` legacy hints.
- Set `x-ua-compatible` for legacy IE rendering.
- Provide an `alternate` link to a mobile site variant.
- Configure MSApplication notification polling.
- Deliver PWA-like install behavior on mobile.
- Standardize mobile UI tags site-wide as defaults.
- Override viewport/theme-color for a specific campaign page.
