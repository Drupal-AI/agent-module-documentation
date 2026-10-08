# One Click Accessibility — manual setup guide

**One Click Accessibility** (`one_click_accessibility`) adds a front‑end
accessibility toolbar — a small "Accessibility Tools" widget that sits on your
public pages and lets visitors adjust how the site reads for them. From that one
control a visitor can increase or decrease the text size, switch to greyscale,
turn on high contrast or negative contrast, force a light background, underline
all links, and switch to a more readable font.

It is a client‑side usability aid: everything it does happens in the visitor's
browser and affects only their own view. It does not change your content, your
markup, or anyone's access to the site. That also means it *complements* genuine
accessibility work — semantic HTML, alt text, ARIA, WCAG‑compliant content — but
it does not replace it. Think of it as a convenience layer on top of a site that
is already built accessibly.

The widget is rendered as a block, so after enabling the module you place the
block in a region and choose which side of the screen it appears on. A small
settings form lets you tune the widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the accessibility block, pick
   its position, and choose which helpers it offers.

## Where it lives in the admin menu

The module's settings form is registered as `one_click_accessibility.settings`;
reach it from the **Extend** page by clicking **Configure** next to *One Click
Accessibility*, or from the **Configuration** section of the admin menu. The
widget itself is a block, so you also visit **Structure → Block layout** to place
it in a region. See [Configuration](configuration/index.md) for the details.
