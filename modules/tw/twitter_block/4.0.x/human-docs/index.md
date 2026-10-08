# Twitter Block — manual setup guide

**Twitter Block** (`twitter_block`) is a lightweight module that provides a single
configurable block for embedding a Twitter/X user timeline on your site. You place
one or more instances of the block on the Block layout page, and each instance
renders an embedded timeline for a given `@username`.

Under the hood the block emits a `<a class="twitter-timeline">` link carrying your
settings as `data-*` attributes and attaches Twitter's `widgets.js`, which loads
externally and progressively turns the link into the live timeline in the
visitor's browser. The block's configuration form exposes the options Twitter's
embedded-timeline widget supports, grouped into **Appearance** (theme, link color,
border color, chrome), **Functionality** (related accounts, tweet limit, Do Not
Track), **Size** (width, height), and **Accessibility** (language, ARIA
politeness).

It is purely a front-end widget embed — it never handles OAuth, tweeting from
Drupal, or any server-side Twitter API integration. It has no settings page and no
permissions of its own: creating and positioning the blocks relies entirely on
core Block's *Administer blocks* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

There is no central settings page. You add and configure timeline blocks from
**Structure → Block layout** (`/admin/structure/block`) — the block appears under
the *Twitter* category when you click *Place block*.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the timeline, and choose
   **Twitter block** (in the *Twitter* category).
3. Fill in the block form:
   - **Username** *(required)* — the account's screen name **without** the `@`
     (for example `drupal`). This is the timeline that gets embedded.
   - **Appearance:**
     - **Theme** — *Default* (light) or *Dark*.
     - **Link color** — a 6-character hex value **without** the `#` (for example
       `abc123`).
     - **Border color** — a 6-character hex value without the `#`.
     - **Chrome** — checkboxes to hide parts of the widget: *noheader*, *nofooter*,
       *noborders*, *noscrollbar*, and *transparent* (transparent background). Tick
       whichever you want to remove for a more compact, blended-in look.
   - **Functionality:**
     - **Related** — comma-separated screen names suggested to follow after a
       visitor interacts with a tweet.
     - **Tweet limit** — *Auto* (a scrolling feed) or a fixed number from 1 to 20.
     - **Do Not Track** — when enabled, the embed does not tailor content to the
       visitor.
   - **Size:**
     - **Width** — in pixels (Twitter accepts roughly 180–520).
     - **Height** — in pixels (minimum 200).
   - **Accessibility:**
     - **Language** — a language code to override Twitter's auto-detection; leave
       it empty to emit the current interface language.
     - **Politeness** — the ARIA `aria-live` value, *polite* or *assertive*; use
       *assertive* when the timeline is a primary content source.
4. Optionally set a block title and any core block visibility conditions (restrict
   it to certain pages or roles), then **Save block**.

Place as many instances as you like — for example one block per account (a
corporate handle and a support handle). Each placed block is a normal `block`
config entity, so you can export it and deploy it across environments. Only fill
in the settings you care about; anything you leave blank falls back to the
widget's own defaults.
