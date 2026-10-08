# Configuration

Guided Tour has no site‑wide settings form to fill in — you configure it by
**creating tours**. Each tour is its own configuration item, so tours export and
deploy with the rest of your site's configuration and are multilingual‑ready via
Config Translation.

## Create a tour

1. Go to **Administration → Configuration → User interface → Guided Tour**.
2. Click **Add tour**.
3. Give the tour a name and define its **steps in YAML**. Each step points at a
   **CSS selector** on the page and describes the tooltip:
   - the element's selector,
   - the popover text,
   - the popover position, and
   - the button labels.

> **Tip:** the companion **Chrome extension** lets you click any element on a page
> to copy its CSS selector, ready to paste straight into the YAML — much faster
> than finding selectors by hand.

## Target who sees the tour, and where

Each tour can be scoped so the right people see it in the right place:

- **Role‑based** — show different tours to different roles (including anonymous
  visitors).
- **Route‑based** — aim a tour at one specific page/route, or run it across all
  pages.
- **Bundle filter** — target specific content types.

## Behaviour options

- **Dismissal cookie** — a configurable cookie remembers that a visitor has seen
  (or dismissed) a tour, so it doesn't reappear on every visit. You control the
  cookie so you can decide how persistent that "seen" state is.
- **Replay button** — offer a way to run a tour again, either as a **floating
  action button (FAB)** or **inline** as a block.
- **Shadow DOM / Web Components** — tours can target elements inside web components,
  which many modern themes and widgets use.

## A note on selectors

Because steps are tied to CSS selectors, a tour is only as stable as the markup it
points at. If a theme update changes class names or structure, revisit the tour's
YAML and update the affected selectors so the tooltips still land on the right
elements.
