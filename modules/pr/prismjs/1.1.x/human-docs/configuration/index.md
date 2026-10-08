# Configuration

Setting up Prism Js has two parts: choose the **languages and theme** on the
module's settings page, then add the **Prism Js button** to the toolbar of the text
format(s) that use CKEditor 5.

## Step 1 — Choose languages and theme

1. Go to **Configuration → Content authoring → Prism Js**
   (`/admin/config/content/prism-js`).
2. Set the two options:
   - **Syntax highlighting style (theme)** — the PrismJS colour theme used to render
     code. All available styles ship with the module.
   - **Supported languages** — tick the languages editors may choose when inserting
     a code block. A few are checked by default; **uncheck the ones you won't need**
     to keep the language list (and payload) lean. This list controls only what
     appears in CKEditor 5's "insert source code" dialog.
3. Save.

## Step 2 — Add the button to a CKEditor 5 toolbar

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the text format you want to enable it for (for example *Full HTML*). The format
   must use **CKEditor 5**.
2. In the CKEditor 5 toolbar configuration, drag the **Prism Js** icon into the
   active toolbar. Its configuration (the syntax‑highlighting style and supported
   languages) appears below and reflects your Step 1 choices.
3. Save the format.

## Important: allowed HTML tags

For highlighting to survive, the text format must allow the markup Prism uses:

- If you use anything other than *Full HTML*, make sure the format's **allowed tags**
  include `<pre>` and `<code>`.
- If **Limit allowed HTML tags** is enabled, also allow the **`class` attribute** on
  those tags (for example `<code class>`), because the language is carried in a class
  such as `language-php`.

## Using it as an editor

With the button on the toolbar, an editor clicks the **Prism Js** icon, chooses a
language, and pastes their code. Double‑clicking an inserted code snippet reopens the
source dialog for editing. Because the editor picks the language explicitly, the
rendered highlighting matches what they intended.

> **Tip.** Enable the copy‑to‑clipboard behaviour where available so readers can copy
> exactly what the author wrote — highlighting should never change the code itself.
