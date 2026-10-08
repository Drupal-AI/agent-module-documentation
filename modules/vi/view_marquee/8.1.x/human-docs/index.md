# View Marquee — manual setup guide

**View Marquee** (`view_marquee`) is a Views **style plugin** that renders a
view's rows inside an HTML `<marquee>` element — producing a scrolling ticker of
content with a configurable direction and speed. It turns any existing view into a
scrolling banner without adding a JavaScript carousel library.

Typical uses include a scrolling news ticker of your latest articles, a horizontal
band of announcements or alerts, a looping list of sponsor names, scrolling
testimonials, or an upcoming‑events ticker. You can scroll left, right, up, or
down, choose a continuous scroll or a back‑and‑forth "alternate" bounce, set the
speed and step delay, apply a CSS class to each row, and optionally pause the
scroll when a visitor hovers over it so they can read a row.

There is no admin settings page, no permissions, and no configuration to store
globally — everything lives inside each view display's style options. You simply
switch a view's **Format** to *Marquee* and adjust its options. It depends only on
core's **Views** module.

> **Heads‑up:** `<marquee>` is a deprecated, non‑standard HTML element. Browsers
> still render it today, but long‑term support isn't guaranteed — keep that in mind
> before relying on it for critical UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere of its own — the module has no admin page. Its one effect is a new **Format
→ Marquee** option available when you edit any view under **Structure → Views**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit the view you want to scroll (**Structure → Views**), or create a new one.
3. In the view's **Format** setting, choose **View Marquee** (Marquee).
4. Click the format's settings link to open its options and configure the scroll:

   | Option | What it does |
   |--------|--------------|
   | **Row class** | CSS class placed on each row's wrapper (default `marquee-row`), for styling. |
   | **Direction** | Which way the content scrolls — left, right, up, or down. |
   | **Behavior** | `scroll` for a continuous loop, or `alternate` for a back‑and‑forth bounce that reverses at each edge. |
   | **Speed** | Pixels moved per step (backs the `scrollamount` attribute) — higher is faster. |
   | **Delay** | Delay between scroll steps (backs `scrolldelay`) — higher is slower/jumpier. |
   | **Mouseover** | When enabled, the scroll pauses while the visitor hovers over the marquee, then resumes. |

5. Save the view. Any display type — block, page, or attachment — can use the
   marquee format, so you can drop a scrolling ticker anywhere a view can appear.
