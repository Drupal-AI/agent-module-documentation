# Configuration

DOC to HTML needs configuration before it will convert anything: you must tell it
where LibreOffice lives, choose your conversion options, and then add the widget to
a field. All of the admin forms below require the **Administer DOC to HTML
settings** permission (an administrator by default), and they sit under
**Configuration → Content authoring → DOC to HTML**.

## 1. LibreOffice settings

Go to **Configuration → Content authoring → DOC to HTML → LibreOffice settings**
(`/admin/config/content/doc_to_html/libreoffice-settings`). This is where you point
Drupal at the LibreOffice binary:

- **Base path for LibreOffice** — the directory that contains the LibreOffice
  executable, for example `/usr/bin` (Linux/DDEV) or
  `/Applications/LibreOffice.app/Contents/MacOS` (macOS). Do not include the
  executable name here — just the folder.
- **Command** — the executable name only, with no path separators, for example
  `soffice`, `libreoffice`, or `soffice.exe`.
- **Conversion timeout (seconds)** — how long a single conversion may run before
  the module terminates it. The default is **60** seconds; set it to **0** to
  disable the timeout. (The timeout is enforced via `proc_open`; if `proc_open` is
  unavailable the module falls back to a plain shell call and the timeout cannot be
  enforced.)

## 2. Basic settings

Go to **Configuration → Content authoring → DOC to HTML → Basic settings**
(`/admin/config/content/doc_to_html/basic-settings`). These options control file
handling and how the generated HTML is cleaned up:

- **Public files subfolder** — the folder under the public files directory used for
  the temporary converted HTML files.
- **Enabled upload formats** — tick which formats editors may upload: **DOC**,
  **DOCX**, and optionally **ODT**, **RTF**, and **PPTX**.
- **Normalize to UTF-8** — whether the converted output should be normalized to
  UTF-8.
- **Body extraction regex** — an optional regular expression used to extract the
  meaningful content from LibreOffice's generated HTML.
- **Body regex match index** — which part of the regex match to use: `0` means the
  full match, while `1` or higher selects a specific capture group.

## 3. Test the conversion with the Test Wizard

Before enabling the widget on real fields, validate your setup at
**Configuration → Content authoring → DOC to HTML → Test Wizard**
(`/admin/config/content/doc_to_html/test-wizard`):

1. Upload a sample document in one of the formats you enabled in **Basic settings**.
2. Run the conversion to review each stage — the raw HTML LibreOffice produced, the
   extracted `<body>` segment after your body regex is applied, and the final
   preview after DOM cleanup.
3. Adjust and save your regex settings until the output matches what you expect.

If the wizard reports that LibreOffice cannot be found or times out, revisit the
**LibreOffice settings** above and confirm the binary path and command are correct.

## 4. Add the widget to a field

Once the Test Wizard is happy, enable the upload widget on a text field:

1. Go to the **Manage form display** tab of the content type (or other fieldable
   entity) that has a *Long text* / CKEditor 5 field, for example the node **Body**
   or a custom `text_long` / `text_with_summary` field.
2. Set that field's widget to **DOC to HTML**.
3. Save the form display.

Editors who should be able to use the upload control need the **Use DOC to HTML
widget** permission (**People → Permissions**). When they edit content, they can
upload a document, have it converted, review the HTML in CKEditor 5, and save.

> **A note on how conversion runs.** The module builds the LibreOffice command with
> PHP's `escapeshellcmd()`/`escapeshellarg()` escaping and runs it through
> `proc_open` with the timeout you configured, and it validates each upload's MIME
> type before converting. This is why the LibreOffice binary must be installed and
> reachable on the server, and why the admin settings forms are restricted to
> trusted administrators.
