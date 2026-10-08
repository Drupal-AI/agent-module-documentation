# Configuration

All of the module's options live on a single page. This is where you decide how
maintenance mode behaves — none of it takes effect until maintenance mode is
actually on (or scheduled to come on).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Maintenance**
   (`/admin/config/development/maintenance`).

The form groups its options into the areas below.

## Custom maintenance message

Choose what visitors see on the maintenance page. You can supply:

- **Plain text** — a simple message.
- **Formatted HTML** — richer content using a text format / rich editor.
- **A full node** — render an existing node as the maintenance page content, so
  you can build a branded "we'll be back soon" page with normal content editing.

## Scheduling maintenance

Rather than flipping maintenance mode by hand, you can have the module
**automatically enable or disable** it based on a start and end time/date. This
is ideal for planned deployment windows — set the schedule and the site takes
itself offline and brings itself back up on time.

## Access control (who sees the maintenance page)

Fine-grained rules decide who is shown the maintenance page while it's active:

- **By IP address** — show or hide maintenance mode for specific IPs.
- **By route path** — apply maintenance to (or exempt) particular paths.
- **By query string** — vary behaviour based on query parameters.

Use these to keep parts of the site reachable, or to let specific visitors
through. Remember this works *alongside* core's *access site in maintenance mode*
permission — keep that permission limited to trusted roles.

## User redirection

Instead of showing the maintenance page, you can **redirect anonymous users to a
custom URL** — for example a status page hosted elsewhere. The redirect can be
immediate or after a short delay.

## Page reload options

Help waiting visitors know when you're back:

- Add a **reload button** to the maintenance page, and/or
- **Automatically refresh** the page (every 15 seconds) so it reappears as soon
  as the site returns.

## Custom HTTP status code

By default Drupal returns **503 Service Unavailable** during maintenance, which
is the correct signal to search engines. If you have a reason to change it, you
can override it to another valid code (for example 200 or 403) — but leave it at
503 unless you specifically need otherwise, so crawlers treat the downtime as
temporary.

## Maintenance themes

Pick from the module's built-in templates — such as **clean** or **particles** —
to control the look of the maintenance page without building your own theme.

## Status report and logging

The form also surfaces a small **status report**: when maintenance mode was last
enabled, plus room for a log note so your team has a record of why the site was
taken offline.

## Save

Click **Save configuration**. Settings apply the next time maintenance mode is
active (immediately if it is on now, or at the scheduled time if you configured a
schedule).
