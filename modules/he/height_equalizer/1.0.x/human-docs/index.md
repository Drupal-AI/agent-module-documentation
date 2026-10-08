# Height Equalizer — manual setup guide

**Height Equalizer** (`height_equalizer`) makes elements that match a CSS
selector share the same height. It's the classic "equal-height cards" problem —
a row of teaser cards or panels where one has more text than the others and ends
up taller, breaking the tidy grid. You give Height Equalizer a selector for those
elements, and it measures them and levels their heights so the row lines up.

What sets this module apart is how it does the work. Rather than the older
approach of recalculating on every window-resize event, it uses the browser's
**ResizeObserver** and **MutationObserver** to detect layout and content changes
and adjust heights only when something actually changes — with debounced
calculations to keep it efficient. It has **no jQuery dependency**, works with
AJAX and dynamic content, and plays nicely with Views, Paragraphs, Layout
Builder, Commerce, and custom templates.

You manage it from a **central configuration form** where you define one or more
target CSS selectors — no per-element data attributes to sprinkle through your
markup. The configuration is exportable (it ships a config schema), and it's a
purely front-end/theming helper with no content or access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — adding the CSS selectors whose
   elements should share a height.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → User interface →
Height Equalizer**. See [Configuration](configuration/index.md).
