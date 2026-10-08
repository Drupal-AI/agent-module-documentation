# Configuration

Setting up Highlight Js has two parts: wiring the code button into a text format
so editors can insert code, and choosing which languages, theme, and options the
library uses. There's also a permission to review.

## 1. Add the button and filter to a text format

1. Log in as an administrator and go to **Configuration → Content authoring →
   Text formats and editors** (`/admin/config/content/formats`).
2. Choose a format that **uses CKEditor 5** (for example, *Full HTML* or a custom
   format) and click **Configure**.
3. In the CKEditor 5 toolbar configuration, **drag the Highlight Js icon** from
   the available buttons into the active toolbar.
4. Further down, under the format's filters, **enable the "Highlight Js" filter**
   checkbox.
5. **Allowed HTML tags.** If the format limits allowed tags (anything other than
   Full HTML), make sure `<pre>` and `<code>` are permitted, and that the
   **`class` attribute** is allowed on them — Highlight.js uses classes to mark up
   languages and themes. Without this, the highlighting won't render.
6. Save the format.

## 2. Choose languages, theme, and the copy button

1. Go to **Configuration → Content authoring → Highlight Js**
   (`/admin/config/content/highlight-js`) — this is the `highlight_js.settings`
   form.
2. **Languages.** Highlight.js supports 240+ languages, and some are pre‑selected
   by default. Check the ones your site publishes and **uncheck the rest** — the
   selection here is exactly what appears in the language drop‑down of the
   editor's code dialog, and trimming it keeps the payload small.
3. **Theme.** Pick the colour scheme for highlighted code. Highlight.js offers
   250+ themes; choose one that suits your site's look.
4. **Copy‑to‑clipboard button.** Toggle whether a "copy" button appears on
   rendered code blocks so readers can grab a snippet in one click.
5. Save.

## 3. Set permissions

The settings form is protected by the **`administer highlight_js configuration`**
permission (marked to restrict access). Grant it only to trusted administrator
roles at **People → Permissions → Highlight Js**
(`/admin/people/permissions/module/highlight_js`).

## How editors use it

With the button and filter in place, an editor creating or editing content (in a
CKEditor 5 format) clicks the **Highlight.js icon**. A dialog opens with a
**language** selector and a **Source Code** text area; they paste the code, choose
the language, and insert it. On the saved page the snippet appears
syntax‑highlighted in the theme you selected.
