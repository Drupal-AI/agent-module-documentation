# Configuration

Setting up Emoji Reactions has a few parts: attach the reaction field to the
entities you want, choose how it displays, manage which emojis are available, set
who can react, and — optionally — review the analytics. None of it is hard, and
sensible defaults are in place from the start.

## 1. Attach the reaction field

The module provides an **Emoji Reaction** field type that plugs into Drupal's
standard field UI — no special entity type is needed.

1. Go to the bundle you want reactions on, for example **Structure → Content types
   → Article → Manage fields**.
2. **Add field**, choose **Emoji Reaction**, and save.

You can add the field to nodes, comments, taxonomy terms, users, paragraphs, and
other fieldable entities the same way.

## 2. Choose a display layout

Reactions are rendered by a field formatter with **23 layouts**, configured **per
view mode** under **Manage display**:

1. On the bundle's **Manage display** tab, find the reaction field.
2. Pick a layout from the formatter settings. Options include core layouts (Pills,
   Bubbles, Grid, Compact, Minimal, Toolbar, Floating, Card, Inline, Ribbon),
   stylised themes (Neon, Glassmorphic, Retro, Magazine, Timeline), and
   social‑media‑inspired styles (Facebook, Twitter/X, Reddit, Instagram, LinkedIn,
   Slack, WhatsApp, Discord).
3. In the formatter settings you can also **whitelist which emojis** appear in that
   view mode.

Because this is per view mode, a *Teaser* can show compact pills while the *Full*
page shows the animated Facebook‑style bar — all from the same field.

## 3. Manage the emojis

The module ships six emojis and lets you curate the full set from its **emoji
management** admin list:

- **Add emojis** as Unicode characters, external image URLs, or raw SVG markup.
- **Reorder** them by drag‑and‑drop — the order is reflected in every widget
  site‑wide.
- **Enable or disable** individual emojis globally without deleting them; existing
  reaction counts are preserved.
- Set an **accessibility label** (aria‑label) on each emoji, read aloud by screen
  readers.

## 4. Set reaction behaviour

- **Single or multiple mode** — choose whether a user may hold one reaction per
  item or react with several emojis at once.
- **Reaction change** — allow users to swap their reaction instead of removing it
  first.
- **CSS animation** — a configurable bounce fires on click for instant feedback.
- **Real‑time count polling** — an optional JavaScript loop refreshes counts
  across open sessions at a configurable interval (default 15 seconds).

## 5. Permissions and anti‑abuse

Emoji Reactions provides its own permissions — assign them at **People →
Permissions**:

- Grant reacting to the roles you want.
- **React as anonymous** — grant this to let unauthenticated visitors react;
  anonymous reactions are tracked by IP, session, or both, with a configurable
  expiry window.
- Restrict who can see the reaction log and statistics to appropriate roles, since
  those records tie users to content and are personal data.

**Flood protection** uses Drupal's native flood API to limit reactions per IP per
hour (default 30), curbing abuse without extra infrastructure.

If you expose reactions over the built‑in **REST API** (for a decoupled front
end), make sure the REST resource's permissions and authentication are configured
so the endpoints enforce access.

## 6. Analytics: the log and statistics

- **Reaction log** — every reaction is recorded with timestamp, user, entity,
  emoji, browser, operating system, device type, anonymised IP, and language. The
  admin log is filterable (by user, emoji, entity, date range, browser, OS, device
  type), sortable, and supports bulk deletion.
- **Per‑entity statistics** — a report page shows the reaction breakdown for a
  single item.
- **Site‑wide statistics** — an aggregate report at **Reports → Emoji Reactions
  Statistics** shows overall engagement.

## Views integration

Reactions are exposed to Views, so you can build custom listings and dashboards —
for example "most‑reacted content this week" — using standard Views fields and
filters.
