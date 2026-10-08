Adds App Links (applinks.org) meta tags to Metatag so shared URLs can deep-link into native iOS, Android, Windows and web apps.

---

App Links is an open cross-platform standard for deep linking: when a URL is shared into a mobile app, `al:*` meta tags tell the client which native app to open and where. This submodule registers those tags as Metatag plugins (in the "App Links" group) so they can be set as defaults or per entity, with token support. It covers iOS, iPad, iPhone, Android, Windows, Windows Phone, Windows Universal, and a web fallback. Depends on the main Metatag module. Configure the tags anywhere Metatag tags appear (global defaults, per bundle, or per-entity field). Useful for publishers and commerce sites that also ship mobile apps and want shared links to open in-app.

---

- Deep-link shared URLs into an iOS app (`al:ios:url`, `al:ios:app_store_id`, `al:ios:app_name`).
- Deep-link into an iPhone-specific app target (`al:iphone:*`).
- Deep-link into an iPad-specific app target (`al:ipad:*`).
- Deep-link into an Android app (`al:android:url`, `al:android:package`, `al:android:class`, `al:android:app_name`).
- Deep-link into a Windows app (`al:windows:url`, `al:windows:app_id`, `al:windows:app_name`).
- Deep-link into a Windows Phone app (`al:windows_phone:*`).
- Deep-link into a Windows Universal app (`al:windows_universal:*`).
- Provide a web fallback URL when no app is installed (`al:web:url`).
- Control whether to fall back to the web (`al:web:should_fallback`).
- Set app-link defaults globally for the whole site.
- Override app-link tags per content type (e.g. only articles open in-app).
- Populate app-link URLs from tokens like `[node:url]`.
- Ensure Facebook and messaging apps open your native app when links are shared.
- Route campaign links to the correct app store when the app is missing.
- Provide platform-specific app names for nicer in-app banners.
- Support multiple app platforms simultaneously on one page.
- Migrate app-link configuration between environments as Metatag defaults.
- Deep-link product pages into a shopping app.
- Deep-link article pages into a news app.
