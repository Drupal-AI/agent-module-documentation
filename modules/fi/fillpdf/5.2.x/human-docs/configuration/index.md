# Configuration

FillPDF has two configuration areas: the **global settings** (which backend to use
and where files live), and the **FillPDF forms** themselves (your uploaded PDF
templates and their field mappings). Both require the **administer pdfs**
permission.

## Global settings

Go to **Configuration → Media → FillPDF** (`/admin/config/media/fillpdf`). The
settings are stored in `fillpdf.settings`.

### Backend

Pick the one backend FillPDF should use to parse and fill PDFs — this is the most
important choice:

- **FillPDF Service** — talks to a hosted API. You provide:
  - **Remote protocol** — `https` (recommended) or `http`.
  - **Remote endpoint** — the service host (no protocol).
  - **FillPDF Service API key** — your key. Prefer to supply this via an
    environment variable rather than typing it here and committing it to config;
    see the API-key note in [Installation](../installation/index.md).
    Image filenames are anonymized (hashed) before being sent to the service.
- **FillPDF LocalServer** — posts to a service you self-host. You provide:
  - **Local service endpoint** — its base URL, e.g. `http://127.0.0.1:8085`. The
    settings form pings this endpoint when you save, to confirm it's reachable.
- **pdftk** — runs the local `pdftk` binary. You provide:
  - **pdftk path** — path to the binary (default `pdftk`; e.g. `/usr/bin/pdftk`).
    The form checks the path on save.
  - **Shell locale** — the locale used when escaping shell commands (default
    `en_US.UTF-8`).

### Storage schemes (these affect access and privacy)

- **Template scheme** — where uploaded PDF **templates** are stored. **Private is
  recommended**; leaving it at the system default or choosing public means the
  template file has no access control.
- **Allowed schemes** — the storage schemes a **generated** PDF may be *saved* to
  (default: **private**). `public` is offered but labelled discouraged because it
  provides no access control. A generated PDF is only written to disk if its form's
  chosen scheme is both available and in this allowed list; otherwise FillPDF
  safely falls back to a browser-only download and never silently writes it
  somewhere unexpected.

You can also set these from the command line, for example:

```bash
ddev drush config:set fillpdf.settings backend pdftk -y
ddev drush config:set fillpdf.settings pdftk_path /usr/bin/pdftk -y
ddev drush cr
```

## Create a FillPDF form (upload a template)

Go to **Structure → FillPDF forms** (`/admin/structure/fillpdf`) and upload a
fillable PDF (only `.pdf` files are accepted). On upload, FillPDF saves the file
and parses its AcroForm fields, creating one mapping entry per field. Each uploaded
template becomes a **FillPDF form** with these output settings:

- **Administrative title** — the label shown on the forms overview.
- **Filename pattern** (the *title* field) — the name of the generated PDF; it
  supports tokens, e.g. `Invoice-[node:title].pdf`. FillPDF sanitizes it (spaces to
  underscores, unsafe characters removed) and appends `.pdf`.
- **Default entity type / id** — the entity used when a generate link doesn't
  supply one.
- **Destination path** — an optional token-supported subdirectory (under
  `fillpdf/`) used when saving output.
- **Scheme** — which storage scheme saved output uses (constrained by *Allowed
  schemes* above).
- **Redirect to the generated file** — if set (and saving), send the browser to the
  saved PDF.
- **pdftk only:** **Encryption** (128-bit / 40-bit / none), **permission** flags
  (Printing, Copy contents, Fill in, …), and **owner / user passwords**.

## Map the fields

For each fillable field FillPDF found, open the field's mapping form and set what
gets written into it:

- A **text mapping** — a token or plain-text string (tokens are replaced against
  the entities in the generate request), or
- An **image mapping** — image data, for example from an image field, placed into a
  PDF field.

## Generate a PDF

Visit a link of the form:

```
/fillpdf?fid=<form id>&entity_id=<type>:<id>
```

for example `/fillpdf?fid=3&entity_id=node:42`. Useful query parameters:

- **`entity_id`** / **`entity_ids[]`** — the entity (or entities) whose data fills
  the PDF, written as `type:id` (e.g. `node:42`).
- **`download=1`** — force a download response rather than inline display.
- **`flatten=0`** — keep the PDF's form fields fillable (by default output is
  flattened, baking values in).
- **`sample=1`** — render a blank/sample PDF from the template (administrators
  only).

A common pattern is to offer this as a "Download as PDF" link on a content page so
the current entity is merged on click.

## Who can generate PDFs

Generation is access-checked:

1. **administer pdfs** or **publish all pdfs** → always allowed.
2. A **sample** request → admins only.
3. **publish own pdfs** → allowed only if the user can *view* every entity in the
   request context; if any is not viewable, it's forbidden.
4. Otherwise → forbidden.

So a low-privileged user can only produce PDFs from content they're already allowed
to see. Grant **publish all pdfs** only to trusted roles, since it bypasses those
per-entity view checks.

## Managing forms

Each FillPDF form supports **edit**, **delete**, **export** (its config plus field
mappings), **import**, and **duplicate** — all under **Structure → FillPDF forms**
and gated by **administer pdfs**. Export/import and duplicate make it easy to move a
form between sites or start a new one from an existing one.
