Registers core Media entities with Rabbit Hole so you can control what happens when a media item is viewed at its canonical `/media/*` page — display, access denied, page not found, or redirect — per media type or per item.

---

`rh_media` is the Rabbit Hole submodule for core Media. Enabling it registers a Rabbit Hole entity plugin for the `media` entity type, which adds the "Rabbit Hole settings" vertical tab to media type edit forms and (when overrides are allowed) individual media edit forms. Media items usually exist to be embedded in other content, so their standalone canonical pages are rarely wanted; this submodule lets you return a 404, deny access, or redirect those pages. Behavior, redirect codes, tokens, and fallback handling all come from the base `rabbit_hole` module — this submodule only wires up media support. It depends on `rabbit_hole` and core `media`.

---

- Return 404 on media canonical pages so embedded images/videos aren't reachable standalone.
- Deny access to media pages to keep files from being viewed directly.
- Set a per-media-type default behavior, overridable per item.
- Redirect a media item's page to the article that embeds it.
- Hide document media pages from crawlers by 404-ing them.
- Redirect using a token such as `[media:field_source_url]`.
- Return "page not found" instead of "access denied" to hide existence.
- Configure a fallback action for empty/invalid redirect targets.
- Apply access-denied to a private media type only.
- Override the media-type default on a specific high-value item.
- Redirect legacy media URLs to new locations with a 301.
- Let trusted roles bypass the action to view the real media page.
- Grant a role permission to administer Rabbit Hole on media only.
- Keep "remote video" media items from rendering their own page.
- Redirect a media page to `<front>`.
- Stop image media pages from being indexed for SEO cleanup.
- Route audio media pages to a player page via redirect.
- Prevent standalone media pages on a decoupled/headless site.
