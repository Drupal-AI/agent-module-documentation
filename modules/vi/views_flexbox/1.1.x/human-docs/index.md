# Views Flexbox — manual setup guide

**Views Flexbox** (`views_flexbox`) adds a **Flexbox** display *style* to Views, so
you can render the results of any view as a CSS flexbox container instead of a
table, unformatted list, or the core grid. That gives you flexbox's alignment and
spacing controls straight from the Views UI — direction, justification, cross-axis
alignment, wrapping — plus an optional built-in **Card** theme for tile/card
listings. It's a quick way to build a responsive logo wall, a related-content strip,
a product grid, or a card gallery without hand-writing layout CSS.

You configure it entirely per view display: set the display's **Format → Style** to
**Flexbox**, then open its settings to choose the flex options. Because the style
uses a row plugin, you pick any Row style (Fields, Content/teaser, and so on) as
usual, and each result row is wrapped in a `.views-flexbox-item` inside a
`.views-view-flexbox` container. Your chosen settings are emitted as modifier
classes on the wrapper (for example `views-flexbox-direction-row`,
`views-flexbox-justify-center`), and the module's CSS libraries turn those into the
actual layout — which also means you can theme further by targeting those classes.

With the **Card** style selected you get two extras: the card CSS library, and a
"Link to content" option that wraps each card in a link — either the row entity's
canonical URL or a URL you build from Views field tokens. Custom per-item classes
and link sources both support Views field replacement tokens when the display uses
fields.

The module is lightweight: one Views style plugin, no admin settings page, no
permissions, and no dependencies beyond core Views. (Minor note for the curious: the
shipped config schema is slightly out of sync — `justify` is typed as boolean and
the link options aren't declared — but everything works via Views' generic option
handling.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no global settings page — everything is set per view display in the Views
UI.

1. Edit a view and, on the display you want, open **Format** and set the **Style**
   to **Flexbox** (then click **Apply**).
2. Open the Flexbox style's **settings** and choose your options:
   - **Style preset** — `_none_` (plain flexbox, no extra CSS) or **Card Layout**
     (attaches the card CSS library).
   - **Direction** — `row`, `row-reverse`, `column`, or `column-reverse`
     (`flex-direction`).
   - **Justify** — `start`, `end`, `center`, `space-between`, `space-around`, or
     `space-evenly` (`justify-content`).
   - **Align items** — `start`, `end`, `center`, `stretch`, or `baseline`
     (`align-items`).
   - **Align content** — `start`, `end`, `center`, `stretch`, `space-between`, or
     `space-around` (`align-content`, for multi-line wrapping).
   - **Default item classes** — on by default; adds an `item-<N>` class to each
     item. Untick for leaner markup.
   - **Custom item classes** — extra space-separated classes added to every item
     (supports Views field tokens when the display uses fields).
   - **Link to content** *(Card style only)* — wraps each item in a link. When on,
     an optional **Link source** field lets you supply a token-built URL; otherwise
     it falls back to the row entity's canonical URL.
3. Pick any **Row style** (Fields, Content, teaser, …) as you normally would, then
   **Save** the view.

To restyle beyond the built-in options, target the generated modifier classes
(`views-view-flexbox`, `views-flexbox-item`, `views-flexbox-direction-*`, etc.) in
your theme's CSS.
