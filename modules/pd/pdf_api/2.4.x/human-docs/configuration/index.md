# Configuration

PDF API's only settings page configures the **dompdf** backend. The other three
bundled backends (mPDF, TCPDF, wkhtmltopdf) do not read these settings — they take
their options from the calling code. So this page matters when dompdf is your PDF
engine (which it commonly is, being the pure-PHP option with no external binary).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → PDF API**, or navigate directly to
   `/admin/config/system/pdf-api`.

## Fonts and rendering

- **Default font** *(default `serif`)* — the font family dompdf uses when the HTML
  does not specify one.
- **DPI** *(default `96`)* — the dots-per-inch used to size images and convert
  units. Raise it (for example to `300`) for sharper print output.
- **Font height ratio** *(default `1.1`)* — the ratio used when converting HTML font
  sizes into PDF point sizes.
- **PDF backend** *(default `CPDF`)* — the underlying rendering engine dompdf uses:
  **CPDF**, **GD**, or **PDFLib**. CPDF is the standard choice; GD rasterizes;
  PDFLib requires a license.
- **PDFlib license** — the license key, needed only when the backend above is set to
  **PDFLib**.

## Security toggles

These control what dompdf is allowed to do while rendering. Tighten them on
untrusted content:

- **Enable inline PHP** *(default off)* — allow inline PHP in the HTML. This is a
  security risk; leave it off unless you fully control the source HTML.
- **Enable remote assets** *(default on)* — allow dompdf to load remote images and
  CSS. Turn it off to prevent the renderer from fetching external URLs.
- **Enable inline JavaScript** *(default on)* — allow inline JavaScript in the
  generated PDF.

## Filesystem locations

- **Chroot** *(default `.`)* — the filesystem root(s), relative to the Drupal root,
  that dompdf is permitted to read from. Constrain this to limit which files the
  renderer can access.
- **Font directory** / **Font cache directory** / **Temp directory** *(all default
  `temporary://`)* — where dompdf stores fonts, its font cache, and temporary files.

## Debug flags

A set of checkboxes for troubleshooting a broken PDF layout — for example
**Debug PNG**, **Keep temp files**, **Debug CSS**, and several **Debug layout**
options. Turn the relevant ones on while diagnosing a rendering problem, then turn
them off again for normal operation. (In the shipped defaults, the general
debug flags are off while a few of the fine-grained layout flags are on; adjust as
needed.)

## Save

Click **Save configuration**. Changes take effect on the next PDF that dompdf
generates — no cache rebuild is required.
