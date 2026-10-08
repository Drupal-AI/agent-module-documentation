# Flag Rating — manual setup guide

**Flag Rating** (`flag_rating`) adds star/like‑style **rating** functionality on
top of the [Flag](https://www.drupal.org/project/flag) module. Instead of a plain
on/off flag, it lets users rate content — for example clicking a star rating — and
stores the score, with **Views** integration so you can display and aggregate the
results.

It works by adding a new flag link plugin: you create a flag, choose the **AJAX
Rating Link** plugin type, and point it at the field that will hold the scores.
Each flag can have its own icon (a default star SVG is provided, and you can
upload a PNG, JPG, or SVG per flag), and the output is themeable through two Twig
templates and CSS you can override or extend from your theme.

A word on integrity: like any user‑generated rating, ratings can be gamed. Flags
are per‑user for authenticated users, which keeps repeat votes in check; for
anonymous visitors the signal is weaker and easier to spoof, so treat anonymous
ratings as approximate. The module has no access‑control role of its own —
flagging access follows the Flag module's configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with Flag, Views, and Node).

There is **no central settings page** — you configure a rating by creating a flag
with the AJAX Rating Link plugin and placing it via **Manage display**, so this
guide folds that into "How to use it" below rather than a separate configuration
chapter.

## Where it lives in the admin menu

- **Flags:** create and edit the rating flag at **Structure → Flags**
  (`/admin/structure/flags`).
- **Display:** place the rating on content at a content type's **Manage display**
  tab (**Structure → Content types → *(your type)* → Manage display**).

## How to use it

1. Go to **Structure → Flags** and create a new flag. For its plugin type, choose
   **AJAX Rating Link**.
2. Save the flag, then edit it again and select the **field which will hold the
   scores**. Optionally upload an icon for this flag.
3. Save your changes.
4. Place the flag on your content like a field — go to the content type's **Manage
   display** (for example **Structure → Content types → Article → Manage
   display**) and position the rating flag where you want it.
5. Use Views to display or aggregate the collected ratings. If you want to
   restyle the stars, override the `flag-rating.html.twig` and
   `flag-rating-icon.html.twig` templates or extend the module's CSS library from
   your theme.
