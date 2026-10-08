# Back-2-Top — manual setup guide

**Back-2-Top** (`back_2_top`) adds a "back to top" button that appears once a page is
taller than the screen and, when clicked, scrolls the visitor smoothly back to the top.
It's written in dependency‑free vanilla JavaScript — no jQuery, no third‑party library —
so it stays lightweight.

The whole module is a single settings form plus a bit of code that attaches the button
site‑wide. There are no extra routes, no external requests, and nothing a visitor can
interact with beyond the button itself. It runs on Drupal 10 and 11.

You can control quite a lot from the settings form — whether the button is on, where it
sits, its colour, opacity and size, which icon (or custom image) it uses, and whether
it also appears on admin pages. Because it's all one simple form, the details are
covered right here rather than in a separate configuration page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The settings form is at **Configuration → User Interface → Back-2-Top Settings**
(`/admin/config/user-interface/back-2-top`), and it requires the **Administer site
configuration** permission.

## How to use it

After enabling the module, open the settings form and turn the button on — it is
**disabled until you enable it**. From the same form you can:

- **Enable / disable** the button.
- **Position** it in a bottom corner — bottom‑left, bottom‑centre or bottom‑right.
- Set its **colour** with a colour picker (match it to your theme), its **opacity**,
  and its **size** in pixels.
- Choose a built‑in **icon** — arrow, chevron or triangle — or **upload a custom image**
  (stored as a managed file).
- Decide whether the button also **shows on admin pages** or only on the front end.

Save the form and the button is attached across the site immediately, staying hidden
until a page is long enough to scroll. To remove it later, just switch it off in the
same form. Configuration is stored in `back_2_top.settings`.
