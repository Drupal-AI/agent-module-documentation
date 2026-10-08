# Add Content by Bundle — manual setup guide

**Add Content by Bundle** (`add_content_by_bundle`) adds a small but handy piece to
Views: an "add content" link or button you can drop into a view's header or footer
that points straight at the add form for a specific bundle. If you have a view that
lists articles, you can give editors an **Add article** button right there on the
listing — no hunting through the Content menu.

It improves on core's generic empty‑area "add content" link because it targets one
exact bundle and can be styled as a proper button. It works with more than nodes:
it can link to add a **taxonomy term** of a chosen vocabulary, an **ECK** entity, a
**Group** content item (when the Group module is installed), or any custom content
entity that declares an add form. The link is access‑checked automatically, so it
only appears to users who are actually allowed to create that bundle.

The button can open the add form in place — as a **modal dialog** or an **off‑canvas
tray** — so editors never leave the listing. You can pass extra query parameters to
prepopulate fields (with support for Views argument tokens like
`{{ arguments.user_id }}`), pick a specific form mode when Form Mode Control is
installed, and optionally redirect anonymous visitors to the login page instead of
hiding the link.

There is no admin settings page and no permissions of its own — everything is
configured per view, right inside the Views UI. This guide is written for a
**human** clicking through the admin UI. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (Views is the only dependency).

## Where it lives in the admin menu

There is no dedicated settings page. You use the module from within the **Views UI**
at **Structure → Views** (`/admin/structure/views`), where it appears as an area
handler called **Add Content by Bundle link** that you add to a view's header or
footer.

## How to use it

1. Edit the view you want the button on (**Structure → Views → your view**).
2. In the **Header** or **Footer** section, click **Add**, tick **Add Content by
   Bundle link** (in the "add" category), and click **Apply**.
3. Configure the options:
   - **Entity type** and **Bundle** — what the link creates (for example a node of
     type *article*, or a term in a chosen vocabulary).
   - **Label** — the button text, e.g. *Add article* (defaults to *Add a new entry*).
   - **CSS classes** — defaults to `button button--action button--primary`, which
     renders it as a Drupal action button. Change or clear these to restyle it.
   - **Target** — leave blank for a normal page load, or choose **modal** or
     **off‑canvas tray** to open the add form over the view. Set a **width** in
     pixels for the dialog.
   - **Destination** — by default the user returns to the view after saving; turn
     this on to suppress that behavior.
   - **Extra parameters** — one `key|value` per line to prepopulate the form; Views
     argument tokens are supported.
   - **Login redirect** — show anonymous users a "Login to add…" link instead of
     nothing.
   - **Group** / **Form mode** — extra options that appear when the Group or Form
     Mode Control modules are installed.
4. Click **Apply**, then **Save** the view.

Tip: the standard Views area **"Display even if view has no results"** checkbox lets
the button show on an empty listing, and you can add several of these areas to one
view — one button per content type it displays.
