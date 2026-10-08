# Views TimelineJS — agent index

Provides a Views **style plugin** `timelinejs` that renders a View's rows as a Knight Lab
TimelineJS3 timeline. Depends on core Views. Configure a timeline by setting a View display's
format to TimelineJS and mapping fields to slide properties (Start date is required).

- **Build a timeline View: select the style, map fields, slide/era/title types, presentation options** →
  [configure/timeline-view.md](configure/timeline-view.md)
- **Site-wide library location setting (CDN vs local, version pinning)** →
  [configure/timeline-view.md](configure/timeline-view.md) (Library location section)
- **Theme hook, template, and the JS that boots the widget** →
  [theming/render.md](theming/render.md)

Key facts:
- Style plugin id `timelinejs` (`@ViewsStyle`), `usesFields = TRUE`, `usesRowPlugin = FALSE`.
  Style config schema: `views.style.timelinejs`.
- Field mappings live in `display_options.style.options.timeline_fields.*`; **`start_date` is required**.
  Row Type values: `title`/`timeline_title_slide` (title slide), `era`/`timeline_era` (era, needs
  start+end), anything else = event slide.
- Library source: config `views_timelinejs.settings:library_location` ∈ `cdn`, `cdn_3.9.7`,
  `cdn_3.8.18`, `local`. Settings form route `views_timelinejs.admin`.
- No permission of its own (settings form uses `administer site configuration`); no plugin types, no Drush.
