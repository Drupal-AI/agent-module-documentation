# Configuration

ShareThis works with its shipped defaults (buttons on Article and Page), so this
form is about tuning what appears and where.

## Open the settings form

1. Log in as a user with the **Administer Sharethis** permission (an administrator
   by default; otherwise grant it at `/admin/people/permissions`).
2. Go to **Configuration → Web services → ShareThis**, or navigate directly to
   `/admin/config/services/sharethis`.

Everything on this form is saved to the `sharethis.settings` configuration object.

## Where the buttons appear (location)

The single most important setting decides how the buttons are rendered:

- **Content** *(default)* — the buttons render as an extra field inside each enabled
  content type's display. This is the "buttons at the bottom of the article" look.
- **Links** — the buttons render per view mode instead, so you can show them on the
  full page but not the teaser (or vice versa). When you choose this, a matrix of
  bundle × view mode lets you tick exactly which displays get buttons.
- **Neither / block only** — pick anything else and the module renders nothing on
  nodes; instead you place one of the two blocks (see below) wherever you want.

## Which content types get buttons

The **content types** checkboxes decide which bundles show the buttons (in *content*
mode) — for example, tick **Article** but untick **Basic page** to limit sharing to
articles. In *links* mode, the per-view-mode matrix does the same job at the display
level.

## Which services and how they look

- **Services** — the ordered list of sharing targets shown in the bar (Facebook,
  Tweet/X, LinkedIn, email, Pinterest, and so on). Reorder or trim it to match your
  audience.
- **Button style / widget style** — choose the button family and widget layout
  (icon size and arrangement).
- **On-hover menu** — expand a larger sharing menu when the visitor hovers, rather
  than showing every service inline.
- **Shorten URLs** — pass shared links through ShareThis's URL shortener.
- **Open in new window / count from zero** — behaviour toggles for how shares open
  and how counts display.
- **Weight** — the render position of the button block within the node content
  (higher sinks it lower).

## Twitter extras

Three optional fields tailor tweets:

- **Twitter handle** — a username appended to tweets (the "via @handle" credit).
- **Twitter recommends** — an account suggested to the sharer as a follow.
- **Twitter suffix** — extra text or hashtags added to the tweet.

Leave any of these blank to omit them.

## Save

Click **Save configuration**. If you changed placement or content types, reload a
node to confirm the buttons appear where you expect.

## The two blocks

If you set *location* to block-only (or just want buttons somewhere other than the
node), place a block from **Structure → Block layout → Place block**:

- **Sharethis** — shares the **current page** (its title and URL come from whatever
  page the block is rendered on). Good for a sidebar or footer share bar.
- **Sharethis Widget** — shares a **specific, fixed URL** you configure on the block
  itself. In the block's settings you set an internal path (**Sharethis path**) or
  an external URL (**Sharethis path external**) to share, regardless of the current
  page.

## The Views field

In the Views UI you can add a **ShareThis** field to any view, giving each row its
own share buttons for that row's node. Add it like any other field when building or
editing a view.

## A note on grading / offline testing

Because the buttons rely on ShareThis's external `sharethis.com` scripts, checking
that the module is set up correctly is best done against its configuration and the
rendered button markup rather than against live sharing behaviour, which needs the
external service. Advanced hooks and the rendering service are covered in the
[`agent/` docs](../agent/start.md).
