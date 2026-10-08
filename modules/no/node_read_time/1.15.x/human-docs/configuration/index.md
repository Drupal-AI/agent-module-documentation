# Configuration

Node Read Time is driven by one settings form. Configuring it is a two-part job:
first choose the behavior on the settings page, then place the field on the
content types you activated.

## Open the settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → Reading time** (`/admin/config/reading-time`).

## The settings, field by field

- **Content types** — a checkbox per content type. Tick the ones that should have
  a reading time (for example Article but not Basic page). Ticking a type turns on
  the calculation and makes the `reading_time` field available on that type's
  display.
- **Words per minute** — the reading rate used for the estimate. The default is
  **225** words per minute; if you clear the field, the module falls back to 225.
  Lower it for a slower/technical audience, raise it for a faster one.
- **Unit of time** — how the result is formatted:
  - **Minutes** — whole minutes, e.g. "3 minutes".
  - **Minutes and seconds** — e.g. "2 minutes, 30 seconds".
  - **Below one minute** — minutes and seconds, but short posts always show at
    least "1 minute" instead of a sub-minute value.
  - **Default** — a bare rounded-up minute number with no unit text.

Click **Save configuration**.

## Show the reading time on your nodes

Activating a content type doesn't display anything on its own — you still choose
*where* the value appears:

1. Go to **Structure → Content types → {your type} → Manage display**
   (`/admin/structure/types/manage/<type>/display`).
2. The **Reading time** field starts in the *Disabled* region. Drag it into a
   visible region and set its position.
3. **Save.** View a node of that type and the estimate appears where you placed
   the field.

If you prefer to render it yourself in a Twig template, print
`{{ content.reading_time }}` in your node template.

## Other placements

- **Views** — a "Node read time" field is available when you build a view of
  nodes, so you can add reading time as a column to a listing.
- **In code** — every node also gets a computed `node_read_time` base field you
  can read programmatically (it returns a value only for activated content types).
