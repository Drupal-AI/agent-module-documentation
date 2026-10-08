# Configuration

Dismissible Message Bar has **no single settings form**. "Configuring" it means
two things: creating notification entities, and placing the block that renders
them. Everything about a message lives on the notification entity itself.

## 1. Create a notification

1. Go to `/dmb_notifications/add` and pick a notification type (the `default`
   bundle is created for you on install; add more types under
   **Structure → DMB Notification types** if you need them).
2. Fill in the fields (below) and save.

### The notification fields

Every notification on the default bundle comes with these fields:

| Field | What it controls |
|-------|------------------|
| **Content** (`field_p_content`) | The bar's actual content, built from Paragraphs. Edit the field's settings to choose which Paragraph types (text, buttons, images…) editors may add. |
| **Notification date range** (`field_notification_date_range`) | A start/end window during which the bar may display. Outside this window it never shows. |
| **Sitewide** (`field_sitewide`) | Show the bar on every page, ignoring the path limits below — but excluded pages still override it. |
| **Notification pages** (`field_notification_pages`) | Paths where the bar is allowed to appear, one pattern per line, with `*` wildcards (e.g. `/products/*`). |
| **Excluded pages** (`field_excluded_pages`) | Paths where the bar must *never* appear, one per line. **Excluded pages override sitewide.** |
| **Content types** (`field_content_types`) | Limit the bar to specific content types (e.g. only on `article` nodes). |
| **Notification type** (`field_notification_type`) | A taxonomy term categorizing the bar; its name also becomes a CSS class on the bar so you can style it. |
| **Cookie expiration** (`field_cookie_expiration`) | How many days a visitor's dismissal is remembered (default **365**). |
| **Cookie off** (`field_cookie_off`) | If ticked, dismissals are *not* remembered — the bar returns on every page load. |
| **Auto dismiss** (`field_auto_dismiss`) | Automatically hide the bar after a delay, without the visitor closing it. |
| **Dismiss time** (`field_dismiss_time`) | Seconds before auto-dismiss (default **15**, max **120**). |

### Path pattern tips

Each non-empty line in the path fields is a pattern. Use `*` as a wildcard
(`/section/*` matches everything under `/section`). A leading `!` negates a
pattern (`!/admin/*`). Leading/trailing slashes are normalized for you. Path
matching uses Drupal's standard path matcher, so it works with path aliases.

## 2. Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`) and add the
   **DMB Notifications block** to the region where you want bars to appear
   (typically a header or "highlighted" region).
2. In the block's settings you can optionally set a **Notification type** — an
   autocomplete to one of your `dmb_notification_type` terms. Leave it empty to
   show all types, or pick a term to scope this block to just that category.
3. You can place the block multiple times, each scoped to a different type and
   region, to run several independent bars.

## How display is decided

The block renders a lightweight placeholder and hands the list of visible
notifications (and their rules) to a small JavaScript behavior. The browser then
decides which bars to actually show based on the current path, content type, and
date, injects the pre-rendered markup, and wires up the close button. Closing a
bar writes its id into the `dismissible_message_bar` cookie so it stays hidden
for the configured number of days. This client-side approach is what keeps the
feature working behind page caches such as Varnish.

## Publishing and theming

- **Publish / unpublish** a notification to stage it before it goes live; the
  **`view unpublished dmb notifications entities`** permission controls who can
  preview drafts.
- The theme adds a `dmb-notification` body class on pages that have visible bars,
  and each bar carries a CSS class derived from its notification type — handy
  hooks for styling. Override the `dmb_notification.html.twig` template to change
  the bar markup.
