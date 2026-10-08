# Advanced Insert View — manual setup guide

**Advanced Insert View** (`insert_view_adv`) lets editors embed a Views display
directly inside rich‑text (body) content. Instead of dropping a view only through a
block or a template, an author can place a view right in the middle of a page's
prose — either by typing a short token like `[view:name=display=args]` or by using
the module's CKEditor 5 toolbar button and dialog.

The embed is rendered through Drupal's render **placeholders**, so the surrounding
content stays cache‑friendly and works with BigPipe — the embedded view is
computed at the right moment without breaking the page cache. When it renders, the
module checks the current user's access to that view display and applies any
contextual‑filter arguments you supplied.

Configuration happens per **text format**, not on a dedicated settings page. You
enable the "Advanced Insert View" filter on the formats where you want embedding to
work, and optionally add the CKEditor button so editors do not have to type tokens
by hand. Because embedding a view is powerful, grant the filter only to text
formats used by trusted roles, and make sure every embeddable view has correct
Views access.

The bundled **BUEditor** submodule (`insert_view_adv_bueditor`) adds the same
capability to the BUEditor editor, if you use it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional BUEditor submodule.

## Where it lives in the admin menu

There is no configuration page of its own. You turn it on and tune it per text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

### 1. Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format your editors use (for example *Full HTML*).
2. Under **Enabled filters**, tick **Advanced Insert View**.
3. Configure the filter's settings (they appear lower on the form):
   - **Allowed views** — a whitelist of `view=display` entries editors may embed.
     Leave it empty to allow all views (only do this on trusted formats).
   - **Render as empty** — if off (the default), a view that is not allowed or is
     disabled is left visible as its raw `[view:...]` token; if on, it renders
     nothing.
   - **Hide argument input** — if on, any contextual‑filter arguments an editor
     supplies are ignored, and only the view's default arguments are used.
4. Save the format.

### 2. (Optional) Add the CKEditor 5 button

On the same text‑format form, drag the **Insert View** button into the CKEditor 5
toolbar. Editors can then click it to open a dialog that lists views, displays, and
their contextual filters (with entity‑reference autocomplete), instead of typing
tokens. The button has one option, **Enable live preview**, which shows the
embedded view live inside the editor.

### 3. Embed a view in content

With the filter enabled, an author can embed a view in a body field either by
clicking the toolbar button, or by typing a token such as:

- `[view:latest_articles]` — the view's default display.
- `[view:latest_articles=block_1]` — a specific display.
- `[view:tracker=page=1]` — a display with a contextual argument.

The CKEditor button produces a `<drupal-view>` tag in the stored markup that does
the same thing.

### A note on security

The filter can render arbitrary views, so enable it only on formats granted to
trusted roles, and confirm that every view and display you allow (including its
default display) has correct Views access control.
