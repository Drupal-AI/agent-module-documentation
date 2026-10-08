Renders a Datetime field as a small calendar-page-style card (month/day/year blocks) on entity displays.

---

Calendar Card Formatter adds one field formatter plugin (`calendar_card_formatter`) that targets core `datetime` fields. Instead of printing a formatted date string, it themes each value as a stacked "calendar card" — a header block plus a wrapper of day/month/year blocks — using a bundled Twig template and CSS. The formatter has a single setting, `date_option`, choosing one of three layouts: Day Month Year, Day Month, or Month Year. It is display-only: no routes, no permissions, no services, no external calls, and it stores nothing. You enable it per view-display under Manage display, exactly like any other field formatter, and optionally override the template or CSS in your theme.

---

- Show event start dates on a card in a listing of event nodes.
- Display a "save the date" style block for a single Datetime field on an article.
- Render a conference or meetup date as a compact calendar tile in a teaser view mode.
- Present a publication date as a calendar card on a blog post's full display.
- Show a deadline or due date as a visually prominent card on a task/content type.
- Use the Day Month Year layout for full dates on landing pages.
- Use the Day Month layout for recurring annual observances where the year is irrelevant.
- Use the Month Year layout for archive/issue dates (e.g. a magazine issue).
- Style a webinar date inside a Views field output that renders the Datetime field with this formatter.
- Provide a themed date tile in a card-grid layout of upcoming events.
- Replace the default plain-text Datetime output on a bundle with a graphical card.
- Override `templates/calendar-card-formatter.html.twig` in your theme to change the card markup.
- Override `css/styles.css` (library `calendar_card_formatter/calendar_card_styles`) to restyle the card in your theme.
- Set the formatter via config (`core.entity_view_display.*`) as part of a config-managed deployment.
- Reuse the card on multiple view modes (teaser, full, custom) of the same content type.
- Combine with core Datetime's own storage while changing only presentation.
- Present birthday or anniversary dates as calendar cards on a profile display.
- Show a course start date as a card in an education/LMS content type.
- Display a product release date as a calendar tile on a catalog entry.
- Render a gallery/exhibition opening date as a card in an arts site.
- Show a "posted on" date tile alongside a node's title in a custom view mode.
