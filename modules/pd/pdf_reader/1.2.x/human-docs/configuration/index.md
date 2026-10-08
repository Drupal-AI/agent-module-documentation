# Configuration

PDF Reader has no central settings page. It is a **field formatter**, so you
configure it per field on the display screen where the PDF appears.

## Apply the PDF Reader format to a field

1. Make sure the entity has a field that holds a PDF: a **File** field with an
   uploaded PDF, or a **Text (plain)** or **URI** field containing a PDF's URL.
2. Go to the **Manage display** screen for that bundle and view mode — for
   example `/admin/structure/types/manage/article/display`.
3. Find your PDF field and set its **Format** to **PDF Reader**.
4. Click the gear icon on the right to open the formatter settings.
5. Set the options below, click **Update**, then **Save**.

You can repeat this on a different view mode (for example a teaser versus the
full page) with different settings for the same field.

## Formatter options

- **Width** and **Height** — the size of the embedded viewer in pixels. The
  defaults are **600** wide by **780** tall; adjust them to fit your layout.
- **Renderer** — how the PDF is displayed. The choices are:
  - **Google Docs Viewer** *(default)* — renders the PDF through Google's online
    document viewer.
  - **Microsoft Office viewer** — renders it through Microsoft's online Office
    web viewer.
  - **Direct embed** — embeds the PDF using the browser's own built‑in PDF
    viewer, no external service involved.
  - **pdf.js** — the viewer bundled with the module, which also works without any
    external service.
  - **Colorbox** — opens the PDF in a lightbox overlay. This option only appears
    when both the Colorbox and Libraries modules are enabled.
- **Download** — when turned on, a **Download** link is shown alongside the
  embedded viewer so visitors can save the file.
- **Download link placement** — whether that download link appears **above** or
  **below** the viewer.

## Direct‑embed‑only options

These two settings only apply when the renderer is set to **Direct embed**:

- **View fit** — how the PDF is scaled inside the native viewer: **Fit** (fit the
  whole page), **FitH** (fit to width, horizontal), or **FitV** (fit to height,
  vertical).
- **Hide toolbar** — when turned on, the browser's PDF toolbar is hidden for a
  cleaner look.

## Save and reuse

Click **Save** on the Manage display screen to store your settings. Because
everything is stored as standard display configuration, you can export it and
deploy the same PDF display across content types and environments.
