# Configuration

Fivestar has **no central settings page** — despite what the module's info file
suggests, that overview route isn't registered in this version. Instead, you
configure a rating by adding a **Fivestar rating** field to an entity and setting
its options on the usual field‑management screens. This page walks through that.

## Step 1 — Add the rating field

1. Go to the bundle you want to make ratable — for a content type, **Structure →
   Content types → [type] → Manage fields**.
2. Click **Create a new field** (or **Add field**) and choose the **Fivestar
   rating** field type.
3. Give it a label (for example, *Rating*) and save.

## Step 2 — Storage setting: vote type

On the field's storage settings you choose the **vote type** — the Voting API vote
type each rating is recorded against. Think of it as the "rating axis": you might use
the default *vote*, or create *quality*, *satisfaction*, or *overall* so a single
entity can carry several separate ratings. Manage the available vote types at
**Structure → Vote types** (`/admin/structure/vote-types`).

> **Important:** the vote type is a storage‑level setting and is locked once the
> field has data, so decide on it before people start rating.

## Step 3 — Field (instance) settings

On the field's settings you control how rating behaves:

- **Number of stars** — 1 to 10 (default 5).
- **Allow clear** — off by default; when on, users get a "Cancel rating" option to
  remove their vote.
- **Allow re‑vote** — on by default; lets a user change an existing vote.
- **Allow own‑vote** — on by default; controls whether users may rate their own
  content. Turn it off to stop authors rating their own posts.
- **Rated while** — choose **viewing** (the default: visitors vote on the rendered
  entity) or **editing** (the rating is captured on the edit form, for example an
  author's self‑assessment).
- **Voting target** (optional) — record the vote against a *related* entity as well.
  When enabled, you name an entity‑reference field on this entity that points to the
  target, and the Fivestar field on that target to affect. This "bridges" a rating
  onto a parent or related item.

## Step 4 — Choose the input widget (Manage form display)

On **Manage form display**, the Fivestar field offers two widgets:

- **Stars** (`fivestar_stars`) — interactive clickable stars.
- **Select list** (`fivestar_select`) — a plain accessible `<select>` ("Give N of
  M"), which works without JavaScript.

The stars widget also lets you pick a **star skin** (see below).

## Step 5 — Choose the display formatter (Manage display)

On **Manage display**, pick how the rating is shown:

- **Stars** (`fivestar_stars`) — interactive/average stars; with rate‑while‑viewing,
  visitors can vote right here via AJAX.
- **Rating** (`fivestar_rating`) — a numeric value out of the star count, e.g.
  `4.2/5`.
- **Percentage** (`fivestar_percentage`) — a numeric percentage, e.g. `92`.

## Star skins

Wherever the stars widget or formatter appears, you can choose a **skin** to change
the star imagery without writing any CSS. The built‑in skins are: **basic**,
**craft**, **drupal**, **flames**, **hearts**, **lullabot**, **minimal**,
**outline**, **oxygen**, and **small**. Developers can register more from a custom
module.

## Permission

Fivestar defines a single permission, **rate content** ("Use Fivestar to rate
content"). Grant it at **People → Permissions** (`/admin/people/permissions`) to
every role that should be allowed to submit ratings — including the Anonymous role if
you want visitors to vote (subject to Voting API's own rules).

## Rating from code

If you need to cast or read ratings programmatically, Fivestar exposes services:
`fivestar.vote_manager` casts and queries votes (`addVote()`), and
`fivestar.vote_result_manager` reads Voting API's aggregated results
(`getResults()`). There's also a reusable `#type => 'fivestar'` Form API element for
embedding a rating control in any custom form, and hooks —
`hook_fivestar_widgets()`, `hook_fivestar_widgets_alter()`, and
`hook_fivestar_access()` — for adding skins or controlling who may vote.
