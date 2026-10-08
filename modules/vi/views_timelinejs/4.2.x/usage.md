Views TimelineJS adds a Views **style plugin** (`timelinejs`) that renders the rows of a View as an interactive Knight Lab TimelineJS3 timeline, mapping View fields to slide properties like start date, headline, media, and background.

---

Enable it, then on any View choose *Format → TimelineJS*. Because the style uses fields (`usesFields = TRUE`, no row plugin), you add the View fields you need and then map them to timeline properties in the style options: **Start date** (required), End date, Display date, Headline, Body text, Media (plus Media credit/caption/thumbnail), Background image, Background color, Group, Type, and Unique ID. Each data row becomes a TimelineJS entity; the optional **Type** field decides which — an empty/other value makes an event slide, `title`/`timeline_title_slide` makes the single title slide, and `era`/`timeline_era` makes an era (eras require both start and end dates). Dates are parsed from the mapped field's rendered text using PHP date parsing, so the field must output a parseable date string. The style's presentation options map straight onto TimelineJS settings (width, height, font set, scale factor, hash bookmarks, timenav position/height, language, start-at-end) plus an extra "Start at current" option that opens the timeline on the slide nearest today. A site-wide settings form (route `views_timelinejs.admin`, `/admin/config/development/views-timelinejs`, permission `administer site configuration`) selects where the TimelineJS library loads from via `views_timelinejs.settings:library_location` — the Knight Lab CDN (latest, 3.9.7, or 3.8.18) or a local copy in `libraries/timeline3`. Rendering is themed through `views_timelinejs_view_timelinejs` (template `views-timelinejs-view-timelinejs.html.twig`) with the `create_timeline` JS library initializing the widget from `drupalSettings`. Special handling extracts a raw URL from Image-field markup for media/background/thumbnail. Requires the Views module.

---

- Present a company or project history as an interactive horizontal timeline built from nodes.
- Turn a "Milestones" content type into a scrollable TimelineJS timeline via a View.
- Build a historical events timeline where each article is one slide with a date and media.
- Show a product roadmap or release history sourced from a View of content.
- Render a biography / "life events" timeline from a person's referenced date fields.
- Add a title slide (intro) to a timeline by mapping a Type field with value `title`.
- Draw shaded era bands (e.g. "Phase 1") using rows typed `era` with start and end dates.
- Map an Image field as slide media so photos appear on each event.
- Use a background-image field to give slides full-bleed backgrounds.
- Group events into rows/lanes (e.g. by department or category) using a Group field.
- Embed YouTube/Vimeo/tweets as slide media by outputting their URLs in a mapped field.
- Display a friendly "Display date" string instead of the raw start/end dates.
- Open the timeline on the most recent (or nearest-to-today) slide with "Start at current".
- Open the timeline on the last slide with the "Start at the end" option.
- Localize the timeline UI by forcing a specific TimelineJS language.
- Pin the TimelineJS library to a specific tested version (3.9.7 or 3.8.18) via settings.
- Serve TimelineJS from a local `libraries/timeline3` copy instead of the CDN for privacy/offline.
- Add bookmarkable per-slide URLs with the hash-bookmark option and a Unique ID field.
- Combine exposed filters/contextual filters with the timeline to show a filtered slice of history.
- Reuse an existing View's fields (title, body, date, image) as timeline slide content.
- Control timeline size and navigation with width, height, timenav position and height options.
- Build a "news over time" timeline from a feed of imported content.
- Create an editorial timeline for a long-running story or investigation.
- Provide a chronological archive page as an alternative to a plain list View.
