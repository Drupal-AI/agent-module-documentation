# Configuration

Pullquote is configured per text format. There's no central settings page — you add
the button to a format's CKEditor 5 toolbar and, optionally, define the style
variants editors can choose from.

## Step 1 — Add the button to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want (for example *Full HTML*).
3. In the CKEditor 5 toolbar drag-and-drop area, drag the **Pullquote** button into
   your active toolbar.
4. Click **Save configuration**.

Saving registers the HTML tags the pullquote markup needs automatically, so there's
no need to edit the allowed-tags list by hand. The module also attaches its small
frontend behaviour and stylesheet on every page — no block placement or extra
setup required.

> **Enable the filter:** because pullquotes are transformed on display by the
> module's filter, make sure that filter is enabled for the format under *Enabled
> filters* on the same configuration page.

## Step 2 — Define style variants (optional)

Style variants let editors pick a predefined look for individual pullquotes from a
toolbar dropdown. Each variant is a CSS class plus a human label.

1. On the same text format's configuration page, open the **plugin settings** for
   the Pullquote button.
2. Add one variant per line in the format `class|Label` — for example:

   ```
   box|Box with background
   accent|Accent color
   ```

3. Click **Save configuration**.

The variants you define appear in the toolbar dropdown so editors can apply them
per quote. Add matching CSS rules for each variant class in your theme so the
styles actually render.

## Styling

The module ships only minimal default styles. To match your design system, add CSS
rules for the `<pullquote>` element (and for each variant class you defined) in your
theme. The automatic **odd/even** classes on pullquotes make it easy to alternate
left/right float direction with CSS alone.

## Using it

When editing content in a configured format, either select a passage and click the
**Pullquote** button to pull it out, or insert a standalone custom quote. Optionally
add a **cite** attribution (hidden in the editor, present in the rendered markup),
and pick a style variant from the dropdown if you defined any.
