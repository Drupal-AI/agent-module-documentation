Deprecated AdTech Factory (v1) provider for Advertising Entity — adds an `adtech_factory` AdType and default/iFrame/FIA view handlers that emit AdTech Factory ad tags.

---

`ad_entity_adtech` is the legacy AdTech Factory integration for the Advertising Entity framework; new projects should use `ad_entity_adtech_v2` instead. It registers an `adtech_factory` AdType whose per-ad settings are the `data-atf` and `data-atf-format` attributes plus optional default targeting, and three AdView handlers: a default HTML container, a self-contained iFrame, and a Facebook Instant Articles view. The AdTech library URL and default page targeting are set once in the ad_entity global settings; the module loads that external library into the HTML head on non-admin pages and passes page/ad targeting to it. Configuring ads and the library source requires the `administer ad_entity` permission.

---

- Create AdTech Factory ad units inside Advertising Entity.
- Set each ad's `data-atf` and `data-atf-format` attributes.
- Add default per-ad targeting key-values.
- Configure the external AdTech library source URL globally.
- Define default page-level targeting for all AdTech ads.
- Render an AdTech ad as a plain HTML container.
- Render an AdTech ad as a self-contained iFrame with width/height/title.
- Render an AdTech ad for Facebook Instant Articles.
- Load the AdTech library into the HTML head on non-admin pages.
- Preload the AdTech library when script preloading is enabled.
- Pass consent/personalization state into iFrame ads.
- Migrate from JSON page-targeting to array form via the provided update.
- Keep AdTech admin restricted to `administer ad_entity`.
- Evaluate migrating to the supported v2 integration.
- Combine AdTech ads with content-driven Advertising context.
