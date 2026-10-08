<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Power BI adds a "Media Power BI" media source so editors can create Media entities from Microsoft Power BI embed URLs and place those interactive reports anywhere Media works — fields, Media Library, and CKEditor.

---

The module provides a media source plugin, `media_power_bi` (label "Media Power BI"), whose source field is a `string_long` holding the Power BI embed URL. Creating a media type and choosing this source is the whole setup — there is no admin settings page (`configure: null`) and no permissions of its own. A media source field constraint (`media_power_bi`, class `MediaPowerBiConstraintValidator`) validates the stored URL: it must be non-empty and its host must be one of `app.powerbi.com`, `app.powerbigov.us`, `app.high.powerbigov.us`, or `app.mil.powerbigov.us` (checked by `MediaPowerBiHelper::isValidPowerBiUrl()`); otherwise a helpful error tells the editor to re-copy from Power BI's share/embed dialog. A custom Media Library add form (`MediaPowerBiMediaForm`, form id `..._power_bi`) gives a single "Embed Code" textarea for pasting the fragment. For display, the module registers a field formatter, `media_power_bi` (for `string_long`), with `width` (default `100%`) and `height` (default `900px`) settings; it renders the `media_power_bi` theme hook (template `media-power-bi.html.twig`) as a simple `<iframe src="{{ url }}">`, but only for URLs that pass the same host validation. It depends on core `media` and `media_library`. In short: install, create a Media type using the Power BI source, then embed reports through the Media Library or a media reference field.

---

- Embed a Power BI report on a page by referencing a "Power BI" media entity.
- Let editors paste a Power BI share/embed URL into the Media Library to create an embed.
- Add interactive BI dashboards to node content via a media reference field.
- Insert a Power BI visualization into CKEditor through the Media embed button.
- Create a reusable library of Power BI reports as Media entities.
- Validate that only genuine Power BI hosts (app.powerbi.com etc.) are accepted.
- Reject empty or non-Power BI URLs with a clear editor-facing error message.
- Support Power BI Government cloud URLs (powerbigov.us, high/mil variants).
- Set a custom iframe width/height per display (e.g. 100% × 600px) via formatter settings.
- Show the same report at different sizes in teaser vs full view using two view modes.
- Manage Power BI embeds with the same permissions/workflow as other Media.
- Curate approved dashboards centrally and reuse them across many pages.
- Give non-technical editors a paste-the-code flow instead of hand-writing iframes.
- Reference a Power BI media item from a Paragraph or Layout Builder component.
- Display a department KPI dashboard embedded from Power BI on an intranet page.
- Keep embed markup safe by rendering through a controlled iframe template.
- Swap a report's URL in one Media entity and update every place it is embedded.
- Store report titles/metadata alongside the embed as Media entity fields.
- Add Power BI reports to a media browser for editors to pick from.
- Present a full-width analytics report (default 100% × 900px) on a dashboard page.
- Use the Media Library "Embed Code" textarea to add a report without leaving the editor.
- Provide governed, validated Power BI embedding without custom iframe code.
- Combine Power BI media with other media types in a single media field.
- Restrict what URLs can be embedded to the trusted Power BI domains only.
