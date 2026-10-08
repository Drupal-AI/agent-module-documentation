# Configuration

Everything about Tour is authored in the admin UI at **Configuration → User
interface → Tours** (`/admin/config/user-interface/tour`). You need the
*Administer tour* permission to reach these pages.

## The tour list

The main page lists every tour on the site. From here you can:

- **Add tour** — start a new tour.
- **Edit** — change a tour's pages and its tips.
- **Clone** — copy an existing tour as the starting point for a similar one.
- **Enable / Disable** — turn a tour on or off without deleting it.
- **Delete** — remove a tour entirely.

## Creating a tour

A tour has two things to define: **which pages it appears on** and **its tips**.

### Pages (routes)

When you add or edit a tour you tell it which page(s) it should show up on. You can
attach a tour to:

- A specific admin or content form, such as the "Add article" form.
- The front page.
- A page for a particular content type, node, or taxonomy vocabulary — by
  supplying the route's parameters (for example limiting an add‑form tour to the
  *article* content type). Leave the parameters off to match the page regardless.

A single tour can be attached to more than one page.

### Tips

Each tip is one step of the walkthrough. On the tour's **tips** screen you add tips
and, for each one, set:

- **Label** — the heading shown at the top of the tip pop‑up.
- **Body** — the explanatory text for that step.
- **Selector** — a CSS/DOM selector identifying the element on the page to point
  at. Leave it empty and the tip shows as a centered pop‑up in the middle of the
  screen instead of being anchored to anything.
- **Position** — where the pop‑up sits relative to the element it points at (top,
  bottom, left, right, and their start/end variants). This is ignored when there is
  no selector.
- **Weight** — controls the order of the tips; lower weights come first, so set
  these to make the walkthrough flow logically.

The module ships one kind of tip, a **text** tip (a simple heading and body). More
tip types can be added by developers via the `tour_tip` plugin system.

## Global settings

A settings form under **Configuration → User interface → Tours → Settings**
(`/admin/config/user-interface/tour/settings`) controls site‑wide behaviour:

- **Hide the Tour button when no tour is available** — off by default; turn it on so
  the button only appears on pages that actually have a tour.
- **Use custom button labels** — off by default. When on, you can set your own text
  for the button in the two fields below instead of the standard "Tour" / "No
  tour" labels:
  - **Available label** — the button text when a tour is available.
  - **Unavailable label** — the button text when none is available.
- **Enable recap page** — off by default. When on, each tour also gets a static
  "recap" page listing its steps as plain text, which users can read instead of
  running the interactive walkthrough.

Click **Save configuration** to apply. Tours are configuration entities, so they
(and these settings) export and deploy between environments with `drush
config:export` / `config:import`, and they support configuration translation for
multilingual sites.

## Launching a tour

A user with *Access tour* on a page that has a matching tour can start it in
several ways: the **Tour** button in the toolbar, the optional *Tour button* block
placed anywhere on the page, the *Tour* item in the Navigation top bar (with the
Navigation module), the `?tour` URL parameter, or the **alt+t** keyboard shortcut.
