<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media: Embeddable adds an "Embeddable" media type whose source is a block of embed/iframe HTML, so a third-party embed code becomes a reusable, referenceable media entity instead of markup pasted into body text.

---

The module ships a Media source plugin `media_embeddable` (class `HTMLEmbed`, `allowed_field_types = {"text_long"}`) and a pre-built media type `media_embeddable` ("Embeddable") backed by the `field_media_embeddable` text_long field; installing it also creates the field, default/media-library form and view displays, and copies a thumbnail icon. Editors supply the embed code two ways: the standard media add/edit form (`/media/add/media_embeddable`) uses a plain `text_textarea` widget, while the Media Library "Add" flow uses the module's `EmbeddableForm` (extends `media_library\Form\AddFormBase`) with a `validateHtml` step that parses the input with `DOMDocument`/`DOMXPath` and enforces the `media_embeddable.settings` rules on any `<script>` tags — `allow_tag_without_src`, `allow_tag_with_content`, and an `only_allowed_hosts` host allowlist (defaults: `instagram.com`, `twitter.com`, `x.com`) matched by regex against each `script src`. On display, the `html_field_formatter` formatter (`HTMLFieldFormatter`) wraps the stored field value with `Markup::create()` and renders it through the `media-embeddable.html.twig` template, i.e. the saved HTML is output as-is (it does not pass through a text-format filter); an optional "Responsive" formatter setting attaches `media_embeddable/responsive` (CSS + jQuery/once JS) that reads each iframe's width/height client-side and sets a padding-bottom aspect ratio, skipping Facebook iframes. There is no server-side fetching whatsoever — no HTTP client, no `file_get_contents`, no oEmbed resolver; the embed's own scripts and iframes load in the visitor's browser. A single admin settings form lives at `/admin/config/media_embeddable` behind the `administer media embeddable` permission (`restrict access: true`); the module provides no Drush commands. Because the stored HTML is rendered verbatim, creating/editing this media type is equivalent to granting raw-HTML output — scope the core media create/edit permissions for the `media_embeddable` bundle to the same people you would trust with a Full HTML text format, and place provider embeds behind your consent manager since the third-party script sees every visitor.

---

- Turn a third-party embed code into a reusable media entity.
- Reuse one embed across many pages, updated in a single place.
- Store a video embed from a platform core oEmbed does not support.
- Embed an interactive map as media.
- Store a survey or booking widget embed in the media library.
- Add a data-visualisation or dashboard embed.
- Reference an embed from an entity-reference / media field.
- Insert an embed through the Media Library modal.
- Restrict pasted `<script>` sources to an allowlist of provider hosts.
- Forbid inline `<script>` bodies or src-less scripts via settings.
- Keep third-party markup out of node body fields.
- Give an embed a searchable name and manage it under editorial workflow.
- Replace an expired provider snippet globally by editing one entity.
- Embed a social post (Instagram / X / Twitter) as media.
- Add a chat or feedback widget to selected pages.
- Render iframes responsively with an auto aspect-ratio wrapper.
- Standardise how content editors add embeds site-wide.
- Track which pages reference a given embed via media usage.
- Provide a curated set of approved embeds to editors.
- Place third-party embed scripts behind a cookie-consent gate.
