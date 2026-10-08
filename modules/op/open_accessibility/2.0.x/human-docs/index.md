# Open Accessibility — manual setup guide

**Open Accessibility** (`open_accessibility`) adds a floating accessibility
toolbar to the front end of your site — a widget offering visitor‑side
adjustments such as larger text, higher contrast, link highlighting, a
readable/dyslexia‑friendly font, cursor sizing, and hiding images for focus. It
wraps Jossef Harush Kadouri's open‑source Open Accessibility JavaScript widget
and exposes it as a Drupal block with a small settings form.

Before you reach for it, please read this, because it is the most consequential
advice in this area: **an accessibility overlay is not accessibility
conformance, and the accessibility community is broadly opposed to overlays.**
The reasons are concrete. People who need larger text or higher contrast almost
always already have that configured in their operating system and browser, and a
site‑level widget duplicates it at best. Screen‑reader users bring their own
software, and an overlay that manipulates the page can conflict with it. Most
importantly, an overlay cannot fix what actually fails an audit — missing
alternative text, unlabelled form controls, keyboard traps, poor heading
structure, insufficient contrast baked into the design. Those problems live in
your markup and content, not in a toolbar.

If your driver is a legal or procurement requirement (WCAG 2.2 AA, EN 301 549,
the European Accessibility Act), that requirement is met by fixing the site
itself — and an overlay can even be cited as evidence that the underlying
problems were known. Reach for this module only as an *addition* to a site that
already conforms, or to satisfy a stakeholder who wants a visible commitment
signal — never as a route to conformance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, configure the widget, and place its block.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Open Accessibility**
(`/admin/config/user-interface/open-accessibility`), behind a **Configure Open
Accessibility** permission. From there you tune which controls the widget offers
and how it appears.

## How to use it

Setup is three quick steps once the module is enabled:

1. Grant the **Configure Open Accessibility** permission to the roles that should
   manage the widget (administrators, typically), at **People → Permissions**.
2. Open the settings form at
   `/admin/config/user-interface/open-accessibility` and choose the options you
   want the toolbar to expose.
3. Place the **Open Accessibility** block into a region on your theme at
   **Structure → Block layout**, so the floating widget appears on the front end.

After placing the block, load a front‑end page as an anonymous visitor to confirm
the toolbar appears and its controls work.
