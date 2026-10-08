<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Alias Display makes a media entity's canonical URL (its path alias) serve the underlying file directly in the browser — e.g. a PDF opens at `/policies/handbook` instead of rendering the media view page or exposing `sites/default/files/handbook.pdf`.

---

The module swaps the controllers on core's `entity.media.canonical` and `entity.media.revision` routes (via a `RouteSubscriber`) for its own `DisplayController`. When a media entity is viewed, the controller checks a series of conditions and, if they pass, streams the media's source file as a `CacheableBinaryFileResponse` instead of the normal media render array. It only acts on media whose source is a **File** media source (image/document/audio/video file sources, not oEmbed), and only when the file exists on a valid stream. It bows out (rendering the media normally) when the global **kill switch** is on, when an allow-list of **media bundles** is configured and this bundle isn't on it, when the file is missing, or — if the `media_alias_display_field_override` submodule is installed — when the media's `field_override_mad_module` checkbox is set. Two settings live in `media_alias_display.settings`: `kill_switch` (boolean) and `media_bundles` (a sequence of allowed media type ids; empty = all), edited at `/admin/config/media/media_alias_display`. Query-string tricks on the alias: `?edit-media` redirects users with edit access to the media edit form, and `?dl` or `?download` forces the file to download rather than display inline. The module **requires** core Media's "Standalone media URL" setting to be enabled (a warning shows on the status report otherwise) and depends on Media Library. It ships a dedicated cache context (`media_alias_display_kill_switch_toggle`) so responses re-render when the kill switch is toggled. There are no permissions of its own — the settings form uses `administer site configuration`.

---

- Serve a PDF at a clean, memorable alias (`/reports/annual-2025`) instead of the raw file path.
- Let editors swap the file on a media entity and have every link update automatically.
- Hide the `sites/default/files/...` path from public-facing document links.
- Open documents inline in the browser (PDF viewer) rather than showing the media page.
- Force a file to download by appending `?dl` or `?download` to its alias.
- Give staff a quick edit shortcut by appending `?edit-media` to a file's alias.
- Restrict the direct-file behavior to specific media bundles (e.g. only "Document").
- Apply the behavior to all media bundles by leaving the bundle allow-list empty.
- Temporarily disable the whole module site-wide with the kill switch, without uninstalling.
- Use Pathauto to auto-generate friendly aliases for document media entities.
- Reference one media object in many places and update the file once.
- Keep private-scheme files served with a private Cache-Control while public files stay cacheable.
- Serve audio/video files directly at their alias for embedding or direct links.
- Preserve the correct MIME type / Content-Type when streaming the file.
- Stream a specific media revision's file via the revision route.
- Exclude individual media items from the behavior (with the field-override submodule).
- Provide stable document URLs for printed materials or QR codes that never change on re-upload.
- Avoid building custom controllers/routes to serve files behind aliases.
- Ensure links in rich text that point to a media alias open the file, not the entity page.
- Let anonymous users view a public document at its alias while edit links stay protected.
- Cache file responses (via `CacheableBinaryFileResponse`) for performance.
- Redirect broken/missing-file media gracefully to the normal media page instead of erroring.
- Serve institutional forms/handbooks/policies at branded URLs.
