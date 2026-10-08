# Link Iframe Formatter — manual setup guide

**Link Iframe Formatter** (`link_iframe_formatter`) is a field formatter for
core's Link field that renders the link as an **`<iframe>`** rather than as a
clickable anchor — embedding the target page directly in place on your site. You
choose it on a field's Manage display and set the width and height of the
generated iframe.

The use case is specific and legitimate: an editor supplies a URL — a form hosted
elsewhere, a dashboard, a document viewer, a booking widget, an external map —
and you want to show it inline instead of sending the visitor away. Making this a
field formatter means the decision lives in Manage display and the editor only
ever supplies a URL, which is simpler than teaching them embed markup and safer
than allowing raw HTML in a text field.

> **Embedding is delegation — treat it with care.** Whatever sits at the embedded
> URL renders inside your site's page and runs its own JavaScript in the
> visitor's browser, and the URL comes from whoever can edit the field. An
> unconstrained iframe formatter effectively lets a content editor embed anything,
> including a phishing page dressed in your site's chrome (a clickjacking / embed
> risk). For any real deployment, plan to: apply the iframe's **`sandbox`**
> attribute so the embedded page cannot script or navigate the parent; constrain
> **which hosts** may be embedded, through the field's own validation or a
> Content‑Security‑Policy `frame-src` directive; and, where you run a consent
> manager, treat the embed as a consent question, since the embedded origin can
> see the visitor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings page** for this module. The width and height are
set per field on **Manage display**, described below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage display**, where you choose the **Iframe** formatter for a
link field.

## How to use it

1. Enable the module.
2. Go to the **Manage display** page for a content type (or other entity) that has
   a link field.
3. In the **Format** column for that link field, choose **Iframe**.
4. Click the settings gear and set the **width** and **height** of the generated
   iframe, then click **Update** and **Save**.
5. Before going live, address the embedding safeguards noted above — a `sandbox`
   attribute and a restriction on which hosts editors may embed.
