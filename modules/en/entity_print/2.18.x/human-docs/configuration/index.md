# Configuration

Configuring Entity Print has two parts:

1. **The settings page** — choose which PDF engine to use and how it renders.
2. **Exposing the link** — give visitors a way to reach the printable version of an
   entity.

This page covers both.

## Part 1 — The Entity Print settings page

### Open the settings page

1. Go to **Configuration → Content authoring → Entity Print**
   (`/admin/config/content/entityprint`).

![The Entity Print settings page with the Entity Print Config and Dompdf Settings sections](../images/settings.png)

### Set the general options

Under the **Entity Print Config** heading at the top of the page:

1. **Enable Default CSS** — leave this ticked to include the module's basic font and
   padding styles in the output. Untick it if you would rather style print output
   entirely from your own theme.
2. **Force Download** — when ticked, the browser is told to *download* the file
   (with a filename based on the entity's title) rather than display it inline.
   Untick it if you would prefer the PDF to open in the browser.
3. **Base URL** — leave this **blank** in almost all cases. It is only needed when
   you generate PDFs from a CLI context (for example, Drush queue workers or other
   background processing), where Drupal cannot work out the site's absolute URL on
   its own.

### Choose the PDF engine

1. Under **PDF**, use the **Select the default PDF engine for printing** dropdown to
   pick the engine. Only engines whose PHP library is installed appear here, so a
   fresh install typically shows just **Dompdf**.
   - **Dompdf** — pure PHP, works with **no system binary**. The easiest choice and
     the default.
   - **wkhtmltopdf** — renders CSS/JS more faithfully, but needs the `wkhtmltopdf`
     **system binary** installed on the server (and the `mikehaertl/phpwkhtmltopdf`
     PHP library).
   - **TCPDF** — another pure-PHP engine, useful where Dompdf's rendering falls
     short.

   If an engine you installed is missing from the list, its PHP library (or, for
   wkhtmltopdf, its system binary) is not available to the site yet.

### Set the per-engine options

Each engine has its own settings section that appears below the dropdown. For
**Dompdf**, the **Dompdf Settings** section lets you set:

1. **Paper Size** — the page size to print the PDF to (for example *Letter* or
   *A4*).
2. **Paper Orientation** — *Portrait* or *Landscape*.
3. **DPI** — the output resolution (default `96`).
4. Further Dompdf options such as **Enable HTML5 Parser** and remote-asset/SSL
   settings, further down the section.

(wkhtmltopdf and TCPDF each show their own equivalent paper-size and orientation
options when selected.)

### Save

1. Click **Save configuration** at the bottom of the page. Your engine choice and
   options take effect for every PDF generated from that point on.

## Part 2 — Expose the PDF / print link

Choosing an engine does not, by itself, put a link on your content. Entity Print
gives you three ways to expose the printable version of an entity — all of which
point at the same URL pattern, **`/print/pdf/node/{id}`** (more generally
`/print/{export_type}/{entity_type}/{id}`):

### Option A — the "View PDF" field on Manage display

1. Go to **Structure → Content types**, pick a content type (for example *Article*),
   and open its **Manage display** tab.
2. In the list of fields, find the disabled **View PDF** row (Entity Print adds one
   to every bundle).
3. Drag it up out of the **Disabled** section into a visible region and choose a
   position.
4. Optionally edit its label inline.
5. Click **Save**. A print link now appears on that content type's display.

### Option B — the Print Links block

1. Go to **Structure → Block layout**.
2. Click **Place block** in the region where you want the link, and choose the
   **Print Links** block (in the *Entity Print* category).
3. In the block settings, toggle which formats to offer (PDF, EPub, Word `.docx`)
   and their link text.
4. Save the block. It renders the enabled links on node pages.

### Option C — a bulk action

Entity Print provides a **"Print"** bulk action for nodes, so you can download a
PDF for a selected node from an administrative or Views listing.

> **Who can see the links?** Access to any `/print/…` URL is controlled by
> permissions. Grant the per-entity-type permission — for example *"Entity print
> access type node"* under **People → Permissions** — to the roles that should be
> able to download PDFs. A separate *"Bypass entity print access"* permission lets a
> trusted role reach the printable version of any entity.

### Try it

With an engine selected and a permission granted, visit a node's printable URL
directly to confirm it works — for example `/print/pdf/node/1`. You should get a PDF
of that node (downloaded or displayed, depending on your **Force Download**
setting). To style the output, add a print CSS library from your theme; to print an
entire View instead of a single entity, enable the `entity_print_views` submodule.
