# Configuration

Entity Embed has no traditional settings form — you configure it by creating an
**embed button** and then wiring that button into a **text format**. Once both are
done, editors see a new button in their CKEditor toolbar. Plan on two short tasks:
create the button, then enable it on a format.

## 1. Create an embed button

1. Log in as a user who can administer embed buttons and text formats (an
   administrator by default).
2. Go to **Configuration → Content authoring → Text editor embed buttons**
   (`/admin/config/content/embed/button`) and click **Add embed button**.
3. Fill in the button:
   - **Label** — a name editors will recognise, e.g. "Media" or "Node".
   - **Embed type** — choose **Entity**.
   - **Entity type** — the type editors may embed with this button: node, media,
     file, user, taxonomy term, and so on. Tip: create a separate button per entity
     type (e.g. one "Media" button, one "Node" button).
   - **Bundles** — optionally restrict which bundles are selectable. Leave empty to
     allow all bundles of the chosen entity type; tick, for example, only "Image"
     media.
   - **Allowed Entity Embed Display plugins** — limit which display plugins the
     editor may pick (view mode, image formatter, file link, and so on). Leave empty
     to allow all.
   - **Entity browser** *(optional)* — select an Entity Browser (from the contrib
     Entity Browser module) if you want editors to choose from existing entities
     through a browser step, and optionally enable the display‑review step.
   - **Button icon** — upload an icon that will appear in the CKEditor toolbar.
4. **Save**.

## 2. Enable the button and filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on the format your
   editors use (for example *Full HTML* or *Basic HTML*).
2. In the **CKEditor 5 (or CKEditor 4) toolbar**, drag your new embed button from
   the available buttons into the active toolbar.
3. Scroll to **Enabled filters** and tick **Display embedded entities** (the
   `entity_embed` filter). This is the filter that turns the placeholder into a
   rendered entity — without it, nothing embeds.
4. Under **Filter processing order**, make sure *Display embedded entities* runs at
   an appropriate point relative to your HTML‑restricting filters.
5. If you use the **Limit allowed HTML tags** filter, add the `<drupal-entity>` tag
   (with its `data-*` attributes) to the allowed tags so it is not stripped out.
6. **Save configuration**.

## What editors see

With the button on the toolbar and the filter enabled, an editor writing in that
text format sees your embed button. Clicking it opens a dialog where they select an
entity and set per‑embed options such as the display plugin, alignment
(left/right/center), alt text, and a caption. Behind the scenes the button inserts a
`<drupal-entity …>` placeholder, and the filter renders the real entity on output —
so later edits to the source entity appear everywhere it is embedded.

## Note on the one global setting

The only site‑wide flag Entity Embed exposes is `entity_embed.settings:
rendered_entity_mode` in configuration; there is no dedicated admin page for it. All
day‑to‑day setup is done through embed buttons and text formats as above.
