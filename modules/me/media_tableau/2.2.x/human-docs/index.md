# Media Tableau — manual setup guide

**Media Tableau** (`media_tableau`) lets editors embed **Tableau visualizations**
— dashboards, vizzes and data stories — directly into Drupal content. An editor
pastes a Tableau URL into a plain string field, and the module renders it as an
embedded `<tableau-viz>` web component using Tableau's official Embedding API.

It works on top of the **Media Remote** module: you set up a Remote Media type
whose source string field uses Media Tableau's field formatter. When the stored
value matches an allowed Tableau URL, the formatter rewrites share‑style
"profile" URLs into proper embeddable ones and renders the viz. The formatter has
a few display options — iframe width and height, whether to show Tableau's
interactive toolbar, and which version of the Embedding API to load
(`latest`, `3.6` or `3.5`).

For security, Media Tableau only embeds URLs whose host is on an **allowed‑hosts
whitelist** that you control. Out of the box that list contains
`https://public.tableau.com` (Tableau Public); add your organization's Tableau
Cloud or Tableau Server host to embed internal vizzes. If you also run the CSP
(Content‑Security‑Policy) module, Media Tableau automatically adds your allowed
hosts to the `frame-src` directive so the embeds are not blocked — no extra
configuration needed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the URL‑rewrite
regex and the render template — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Media Remote) and enable it.
2. [Configuration](configuration/index.md) — the allowed‑hosts settings page and
   the field formatter's display options, field by field.

## Where it lives in the admin menu

The allowed‑hosts settings form is at **Configuration → Media → Tableau settings**
(`/admin/config/media/tableau`), gated by the **Administer media_tableau allowed
hosts** permission. The display formatter itself is chosen on a bundle's **Manage
display** tab.

## How to use it

At a high level:

1. Enable Media Tableau (and its dependency, Media Remote).
2. Create a **Remote Media** type with a source string field where editors paste
   the Tableau URL.
3. On that media type's **Manage display**, set the source field's format to
   **Remote Media - Tableau**, and adjust size/toolbar/API options.
4. If your viz is not on Tableau Public, add its host on the **Tableau settings**
   page.
5. Editors then create media entities by pasting a Tableau URL, and reference that
   media from content.

See [Configuration](configuration/index.md) for the details of each settings
screen.
