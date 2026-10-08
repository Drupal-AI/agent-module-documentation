# CKEditor 5 Link Styles — manual setup guide

**CKEditor 5 Link Styles** (`ckeditor_link_styles`) lets you give editors a set of
named link "styles" — really CSS classes — that they can apply to a link right
inside CKEditor 5's normal **Link** dialog. Define a style called "Button" that
adds the `btn` class, and when an editor adds or edits a link they see a **Button**
checkbox in the link balloon. Tick it and the link gets the class; your theme's CSS
turns it into a button.

The clever part is *where* the control lives. Rather than making editors reach for
the fiddly Styles dropdown (which is awkward and error‑prone on links), each style
you define becomes a checkbox in the same Add/Edit‑link popup they already use. So
applying a call‑to‑action style, an external‑link icon, a download marker, or a
design‑system button variant is a single click in the place they'd expect it.

Everything is configured **per text format** — you can offer a rich set of styles
on *Full HTML* and a minimal set on *Basic HTML*. It coexists happily with Linkit
and Editor Advanced Link (which also extend the Link button), and it automatically
tells the text format to allow `<a class>` so your classes survive filtering. It
has **no site‑wide settings page** and no permissions of its own, so this guide has
no separate configuration page; the "How to use it" section below covers the setup.

The one thing to remember: the classes you name here only *style* links if your
**theme's CSS** actually defines them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

CKEditor 5 Link Styles adds **no admin page of its own**. You configure it while
editing a text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).

## How to use it

1. Go to **Text formats and editors** (`/admin/config/content/formats`) and edit a
   format whose editor is **CKEditor 5** (for example *Full HTML*).
2. Make sure the **Link** button is in the *Active toolbar* — the styles UI only
   appears when the Link button is present.
3. Open the **Link styles** vertical tab and enter **one style per line** using
   this syntax:

   ```
   a.classA.classB|Label
   ```

   For example:

   ```
   a.btn|Button
   a.btn.btn-lg|Large Button
   a.external-link|External link
   a.download|Download
   ```

   Each line is an anchor (`a`) plus one or more dot‑separated classes, then a `|`
   and the friendly **label** editors will see. A line missing the class or the
   label is rejected.
4. **Save**.

Editors using that format now see your styles as checkboxes inside the Link
dialog. Make sure the corresponding CSS (for example a `.btn` rule) exists in your
theme so the styled links actually look the part.
