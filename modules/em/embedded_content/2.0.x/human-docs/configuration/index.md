# Configuration

Embedded Content has no single settings form. Setting it up means creating a
**button**, wiring that button and the module's **filter** into a text format, and
granting the right **permissions**. This page covers each step. (It assumes a
developer has already provided the component plugins — the module ships none of its
own.)

## 1. Create an Embedded content button

A button is what appears in the CKEditor toolbar and opens the insert dialog.

1. Go to **Configuration → Content authoring → Embedded content**
   (`/admin/config/content/embedded-content/button`).
2. Click **Add** and configure the button:
   - **Label** — the button's name (also used to derive its toolbar item and its
     permission).
   - **Singular label** — the singular name of the thing being embedded (for
     example "component"), shown in the button and dialog.
   - **Modal title** — the heading of the insert dialog.
   - **Submit button text** — the label of the dialog's insert/submit button.
   - **Icon** — raw SVG markup used as the toolbar button's icon.
   - **Conditions** — optionally restrict which component plugins this button may
     insert, as newline-separated glob/regex patterns of plugin ids. Leave empty to
     offer all available plugins.
   - **Dialog settings** — the dialog's width (default `800px`) and height (default
     `auto`).
3. Save. Each button becomes a CKEditor 5 toolbar item named
   `embeddedContent__<button_id>`. Run `drush cr` afterwards so the button's new
   permission (below) appears.

## 2. Wire the button into a text format

A button only works in a text format where **both** its toolbar item and the
module's filter are enabled:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 5**.
2. In the toolbar configuration, drag the button's toolbar item (labelled with your
   button's label) from the available items into the **active toolbar**.
3. Under **Enabled filters**, tick the **Embedded content** filter.
4. Save.

You do **not** need to loosen the format's allowed-HTML — the CKEditor plugin
already declares the `<embedded-content>` tags it needs, which is what keeps this
safe for editors who lack raw-HTML rights.

## 3. Grant permissions

Manage permissions at **People → Permissions** (`/admin/people/permissions`):

- **Administer embedded content** — lets a user create, edit, and delete Embedded
  content buttons (the admin routes above). Grant this to site builders.
- **Use \<label\> embedded content button** — a permission is generated
  automatically for *each* button (for example "Use Components embedded content
  button"). Grant the relevant one to each role that should be allowed to open that
  button's dialog and insert components.

So a typical editor role gets the **Use … embedded content button** permission for
each button they may use, plus access to the text format you wired the button into.
(If a button's permission does not appear yet, rebuild caches with `drush cr`.)

## How editors use it

Once configured, an editor working in that text format clicks the toolbar button,
picks a component from the dialog, fills in its configuration, and inserts it — the
component shows a live preview in the editor and renders as its real, themed markup
on the published page.

## Adding components (developers)

The components themselves are `embedded_content` plugins added in a module — each
implements a `build()` method (its render output), an `isInline()` method, and an
optional configuration form shown in the insert dialog. A button's **Conditions**
field decides which of these plugins it offers. See the
[`agent/`](../agent/start.md) docs for the full plugin anatomy and a minimal
example.
