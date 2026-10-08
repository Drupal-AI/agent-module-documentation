# Configuration

Rate is configured, not just switched on. There are three things to do: build a
widget, attach it to content, and grant the voting permission. A fourth screen
holds optional global bot‑detection settings.

## Build a widget

1. Log in as a user with the **Administer rate** permission (an administrator by
   default).
2. Go to **Structure → Rate widgets** (`/admin/structure/rate_widgets`) and click
   **Add** (`/admin/structure/rate/add`).

Each widget is a **Rate widget** config entity with these settings:

- **Label and machine name** — a human name and its internal id.
- **Template** — the widget's style: **fivestar**, **thumbs up**, **thumbs
  up/down**, **yes/no**, **emotion**, **number up/down**, or **custom** (you
  define the buttons yourself).
- **Value type** — how VotingAPI totals the votes: **points** (all votes summed),
  **percent** (averaged, as for a star score), or option counts (tallied per
  choice, as for emotion reactions).
- **Options** — the individual buttons, each with a value, a label, and an
  optional CSS class. Values must be unique whole numbers. For a fivestar widget
  these are the five star values; for a custom widget you add whatever choices you
  want.
- **Entity types / comment types** — the node bundles (e.g. *Article*) and comment
  bundles the widget attaches to. A widget only appears on the content types you
  list here, and you can list several.
- **Voting** — controls whether an optional **deadline** applies (see below) and
  the *rollover windows* for anonymous and registered users. A rollover window is
  how long someone must wait before they can vote again — you can allow re‑voting
  after a set period, never, or immediately.
- **Display** — where the widget's **label** and **description** sit relative to
  the buttons, and whether the widget is **read‑only** (results shown, no voting)
  — useful in listings.
- **Results** — what the results summary shows and where it is positioned.

Save the widget. It now renders automatically on every item of the content types
you attached it to.

### Voting deadline

If you turn on the deadline option, Rate adds a date field
(`field_rate_vote_deadline`) to each attached entity. Fill it in on a piece of
content and, once that date passes, the widget renders disabled — a simple way to
close voting automatically.

### Where votes are stored

Votes go into VotingAPI's `votingapi_vote` table, tagged with the widget's machine
name. Voting is AJAX‑only, and users can undo a vote where the widget allows it.

## Grant voting permissions (required)

Creating a widget does **not** let anyone vote yet. For every content type a
widget is attached to, Rate generates a permission named **cast rate vote on
node of article** (and the equivalent for other bundles and for comment widgets).
Go to **People → Permissions** and grant the matching permission to each role
that should be allowed to vote. Until you do, the widget shows but no vote is
recorded.

The other permissions are:

- **Administer rate** — create, edit and delete widgets and reach the settings
  form (give this to trusted admin roles only).
- **View rate results page** — see the per‑node **Rate Voting results** tab at
  `/node/{node}/node-rating`.

## Global settings — bot detection and logging

Go to **Configuration → Search and metadata → VotingAPI → Rate**
(`/admin/config/search/votingapi/rate`). These settings are site‑wide and apply
to all widgets:

- **Votes per minute threshold** — the maximum votes allowed from one IP address
  in a minute before it is treated as a bot (default 25).
- **Votes per hour threshold** — the same limit measured per hour (default 250).
- **BotScout API key** — optional. If you have a key from BotScout.com, Rate
  checks voter IPs against their reputation database.
- **Disable logging** — when ticked, Rate stops writing its messages to the
  Drupal log.

Bad user‑agent patterns (another bot defence) are not on this form; they are kept
in the `rate_bot_agent` database table, where `%` is a wildcard, e.g. `%bot%`.

## Views and charts

Rate provides a **Rate widget** Views field so you can render a widget inside any
View — handy for "most popular" listings when combined with a VotingAPI results
sort. If the Charts module is installed, the results tab can draw graphs of the
vote data.
