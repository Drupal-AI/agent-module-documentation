# Configuration

All configuration happens inside a View at **Structure → Views**
(`/admin/structure/views`). There is no module settings page.

## Add a JSON Feed display

1. Create or edit a View of the content you want to syndicate.
2. Add the fields you want to expose (the row plugin maps *fields*, so add the
   fields to the View first — for example title, body, an image, and a date).
3. Click **Add** next to the display list and choose a **JSON Feed** display.
4. Give the display a **Path** — this is where the JSON will be served.
5. Optionally set the display's **Attach to** (and **Link display**) to your
   View's Page display. When attached to a page, the module adds an `alternate`
   `<link>` tag and a feed icon to that page so readers can discover the feed.

The JSON Feed display automatically selects the JSON Feed **Format** (style) and
**Row** plugins for you.

Two things are required for the feed to validate and render:

- The View must have a **title**, or you must turn on *Use the site name for the
  title* in the style settings.
- In the row settings, you must map the **id** and **url** attributes, and at least
  one of **content_html** or **content_text**.

## Format (style) options

Open the **Format** settings on the display to set feed-level values:

- **JSON Feed description** — a short description of the feed (up to 1024
  characters). It supports token substitution from the first row.
- **Author** — the feed's author `name`, `url`, and `avatar` (static text values
  that describe who publishes the feed).
- **Feed Expired** — mark the feed as `expired` when it will no longer be updated
  (useful for retiring a temporary feed gracefully).
- The feed's **home page URL** is taken from the display's *Link display* setting;
  point it at your main Page display so this is populated (it falls back to the site
  front page).

Behind the scenes the style builds the standard JSON Feed object — `version`,
`title`, `description`, `home_page_url`, `feed_url`, `favicon`, `author`, `items`,
and a `next_url` when there are more pages. Empty values are omitted.

## Row options — mapping fields to item attributes

Open the **Row** settings. Each option is a dropdown listing the fields you added
to the View. Map them to the JSON Feed item attributes you want:

| Attribute | What to map to it |
|---|---|
| **id** *(required)* | A unique, stable identifier for each item. |
| **url** *(required)* | The item's permalink (resolved to an absolute URL). |
| **external_url** | A URL to content hosted elsewhere (absolute). |
| **title** | The item title (plain text). |
| **content_html** | The item body — the one attribute that keeps HTML. |
| **content_text** | A plain-text body (use instead of, or alongside, content_html). |
| **summary** | A short plain-text summary. |
| **image** | A representative image URL (absolute). |
| **banner_image** | A wide banner image URL (absolute). |
| **date_published** / **date_modified** | Publish / update timestamps. |
| **tags** | A comma-separated field, split into an array of tags. |
| **author name / url / avatar** | Per-item author details. |

A few things worth knowing:

- Most text attributes are stripped of HTML for safety — **content_html** is the
  deliberate exception, because the JSON Feed spec allows HTML there.
- URL attributes are resolved to absolute URLs automatically.
- Date fields are **not** reformatted by the module. Configure the date field in
  the View (its field settings) to output the RFC 3339 format
  (`Y-m-d\TH:i:sP`) so the feed's dates are valid.
- Empty per-item attributes are dropped from the output.

## Preview and serve

In the Views live preview the JSON is wrapped in a `<pre>` block so you can read it.
At the real path the feed is served with `Content-Type: application/json`. Large
feeds paginate — when there are more results, the feed's `next_url` points readers
to the next page.
