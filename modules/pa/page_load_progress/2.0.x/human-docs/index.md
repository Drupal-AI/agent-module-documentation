# Page Load Progress — manual setup guide

**Page Load Progress** (`page_load_progress`) shows a full‑screen lock overlay with a spinning
throbber when a page takes a while to reload — so after a slow form submit or navigation, users
get clear "working…" feedback instead of wondering whether their click registered. As a bonus,
locking the screen helps prevent accidental double‑submits.

Out of the box it fires when a standard (non‑AJAX) form is submitted: the module quietly tags
submit buttons so the overlay appears after a short, configurable delay. You can optionally
extend it to also lock the screen when a visitor clicks an internal link, and you can limit
where it runs with a path list. It only ever loads for users who hold the **Use page load
progress** permission, so you decide which roles (including anonymous visitors) get the effect.

A settings form lets you tune the delay (immediate, or 1/3/5 seconds so the throbber only shows
on genuinely slow actions), the visibility path conditions, whether internal‑link clicks also
trigger it, and whether the **Esc** key can dismiss a stuck overlay. It is a purely cosmetic UI
module with no external dependencies — just core's jQuery and Drupal JavaScript.

This guide is written for a **human** clicking through the admin UI. If you want the exact
settings keys, visibility logic and drupalSettings for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form (delay, paths, links, Esc key),
   field by field, plus the two permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Page Load Progress**
(`/admin/config/user-interface/page-load-progress`), available to users with the *Administer
page load progress* permission. Grant the *Use page load progress* permission (which controls
who actually sees the throbber) at **People → Permissions** (`/admin/people/permissions`).
