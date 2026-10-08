Adds the full Open Graph Protocol (`og:*`, `article:*`, `book:*`, `profile:*`, `video:*`) meta tag family so shared links render rich previews on Facebook, LinkedIn, and other platforms.

---

The Open Graph Protocol standardizes how a URL describes itself to social platforms: title, description, canonical URL, type, and — crucially — preview images and videos. This submodule registers ~59 OG tags as Metatag plugins, including the core `og:title`/`og:description`/`og:image`/`og:url`/`og:type`, image and video sub-properties (dimensions, alt text, secure URLs, MIME types), locale/alternate locales, and object-type extensions for articles, books, profiles, videos, and places. All are token-enabled and can be set as defaults or overridden per entity. Depends on the main Metatag module; commonly paired with `metatag_facebook` and `metatag_twitter_cards`. One of the most important submodules for social SEO.

---

- Set a share title with `og:title` (e.g. `[node:title]`).
- Set a share description with `og:description`.
- Provide a preview image with `og:image` (plus `og:image:width/height/alt/secure_url/type`).
- Set the canonical share URL with `og:url`.
- Declare the object type with `og:type` (article, website, video, …).
- Set the site name with `og:site_name`.
- Localize shares with `og:locale` and `og:locale:alternate`.
- Add a preview video with `og:video` (+ dimensions, secure URL, type, duration).
- Add preview audio with `og:audio`.
- Mark article metadata: `article:published_time`, `article:modified_time`, `article:author`, `article:section`, `article:tag`, `article:publisher`.
- Mark book metadata: `book:author`, `book:isbn`, `book:release_date`, `book:tag`.
- Mark profile metadata: `profile:first_name`, `profile:last_name`, `profile:username`, `profile:gender`.
- Mark video-object metadata: `video:actor`, `video:director`, `video:writer`, `video:series`, `video:release_date`, `video:tag`.
- Provide place/location data: `place:location:latitude`, `place:location:longitude`.
- Add contact data: `og:email`, `og:phone_number`, `og:fax_number`.
- Add address data: `og:street_address`, `og:locality`, `og:region`, `og:postal_code`, `og:country_name`.
- Add `fediverse:creator` for Mastodon attribution.
- Provide "see also" links with `og:see_also`.
- Set the `og:determiner` grammar hint.
- Improve click-through with rich Facebook/LinkedIn previews.
- Set global OG defaults and override per content type.
- Populate image tags from an entity's image field via tokens.
- Ensure large-image link previews when content is shared.
