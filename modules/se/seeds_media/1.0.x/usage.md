Seeds Media adds a small set of media-library conveniences from the Seeds distribution: a "default media" protection flag, an in-use warning when editing media, and a linkable entity-embed container.

---

Seeds Media is a lightweight companion to core Media and the contrib `media_library_edit` module. It does not ship media types, view modes, or image styles of its own; instead it augments the existing media edit experience. It adds an `is_default` boolean base field to every media entity, alters the media image edit form so that media flagged as "default" cannot be edited by ordinary users (only holders of `bypass default media access`), and — when enabled in settings — shows a warning if the media being edited is already referenced by other content. A `MediaHelper` service counts how many entity-reference fields point at a given media item, and a `hook_preprocess` wraps entity-embed containers in a link when the embed display supplies a `link_url`. Configuration lives in a single settings form under Configuration → Media.

---

- Install the module together with its required contrib dependency `drupal/media_library_edit` (`^3.0`).
- Enable the "Check Media Usability" warning at `/admin/config/seeds-media` (Configuration → Media → Seeds Media).
- Warn content editors before they modify a media asset that is used elsewhere on the site.
- Prevent the number of accidental edits to shared/reused media (logos, placeholders, brand imagery).
- Mark a media item as a "default" asset via the "Default media" checkbox on its edit form.
- Restrict editing of default-flagged media so only trusted roles (holders of `bypass default media access`) may change them.
- Grant the "Default media" checkbox only to roles that hold `assign default medias` so editors can designate protected assets.
- Keep site-wide placeholder or fallback media stable across a multi-author editorial team.
- Query, from custom code, how many times a media entity is referenced across all media reference fields via the `seeds_media.helper` service (`MediaHelper::mediaUseablity()`).
- Build editorial safeguards on top of the `is_default` base field exposed on all media bundles.
- Turn embedded media (via CKEditor entity embed) into a clickable link by setting a `link_url` in the embed display settings.
- Open embedded-media links in a new tab by setting `link_url_target` to 1 in the embed display settings.
- Provide a consistent media-management baseline when building a site on the Seeds distribution/profile.
- Give the media library the "edit in place" capability that `media_library_edit` provides, integrated with the default-media guard.
- Distinguish "current selection" media from newly added media in the media library widget so the usability warning does not falsely flag the item you are already using.
- Administer the module's behavior through the dedicated `administer seeds media` permission.
- Use as a drop-in enhancement for any Drupal 10 or 11 site that relies on core Media and the media library, not only Seeds sites.
- Reduce support tickets caused by editors unknowingly changing media shared across many pages.
