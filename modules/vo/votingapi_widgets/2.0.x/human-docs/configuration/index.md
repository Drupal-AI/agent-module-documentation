# Configuration

All configuration happens on a **Voting API field** you add to an entity bundle —
there is no separate settings page. This page walks through adding the field and
each group of settings it exposes, then the permissions that control who can vote.

## 1. Add the field

1. Go to a bundle's field admin, for example
   **Structure → Content types → Article → Manage fields → Add field**.
2. Choose **Voting api field** as the field type and give it a label (for example
   "Rating").
3. Note that **cardinality is forced to 1 and locked** — a voting field always
   holds a single value, so you will not see the "number of values" control.

## 2. Storage settings (chosen once, locked after the first vote)

These decide the fundamental behaviour of the field and cannot be changed once
votes exist:

- **Vote type** — the Voting API vote type used to record votes (default `vote`).
- **Vote plugin (widget)** — which widget the field uses: **fivestar** (1–5 stars),
  **like** (thumbs-up), or **useful** (thumbs up / down). Default is fivestar.
- **Status** — the default voting state for new content: no voting, closed, or
  open.

## 3. Instance (field) settings

- **Result function** — how the aggregate result is calculated. This is normally a
  per-field derivative such as an average, a count, or a "useful" tally scoped to
  this one field. If you leave it unset, the field falls back to the average of its
  own votes.
- **Anonymous window** and **User window** — the vote "rollover" period, in seconds,
  for anonymous visitors (tracked by IP) and logged-in users. It controls how long
  before a repeat vote from the same person is treated as a brand-new vote rather
  than an edit of their existing one. Use `0` for "every vote is unique
  immediately", `-1` for "one vote ever", or `-2` to use the site-wide Voting API
  default. The allowed values are a fixed set ranging from 5 minutes up to a week.

## 4. Widget settings (Manage form display)

On the bundle's **Manage form display** tab, the Voting API widget offers:

- **Show initial vote** — when ticked, the entity's own add/edit form shows a "Your
  vote" control so an editor can seed a starting vote. The open/closed status radios
  and the vote control each appear only if the editor holds the matching per-field
  permission.

## 5. Formatter settings (Manage display)

On the **Manage display** tab, set the field's format to the Voting API formatter
and open its cog to choose:

- **Style** — a visual style offered by the chosen widget. Five-star offers several
  (`default`, `css-stars`, `fontawesome-stars`, `bootstrap-stars`, and the
  `bars-horizontal` / `-movie` / `-pill` / `-square` bar themes); like and useful
  offer `default` only.
- **Read-only** — render the results but disable voting, for a display-only rating.
- **Show results** — append the results summary (average, count, etc.) below the
  widget.
- **Show own vote** — show the viewer their own cast vote instead of the aggregate.
  Handy on add/edit forms or "my ratings" style displays.

Because the vote form is rendered through a lazy builder, per-user vote state stays
out of the page cache, so the host page can still be cached while each visitor sees
their own voting state.

## 6. Grant the voting permissions

Every voting field generates **four permissions of its own**, named after the field
(for example, for a `field_rating` on article nodes you get
`vote on node:article:field_rating` and its siblings). Assign them at
**People → Permissions**:

| Permission | Lets a user… |
|-----------|--------------|
| **Vote on …** | Cast a new vote. |
| **Edit own vote on …** | Change their existing vote within the rollover window. |
| **Clear own vote on …** | Remove their own vote. |
| **Edit voting status on …** | Open or close voting (the status radios). |

To allow **anonymous voting**, grant "Vote on …" to the Anonymous user role;
duplicate votes are then limited by the field's anonymous rollover window (keyed on
IP address). Remember that adding a new voting field creates a **new** set of
permissions that you will need to assign.
