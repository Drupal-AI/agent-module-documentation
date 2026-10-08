# Configuration

Entity Word has one settings form that controls how the generated Word document
looks and what the downloaded file is named. Everything here applies to every
document the module produces.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Entity Word**
   (`/admin/config/system/entity_word`).

## What you can configure

- **Filename pattern (tokens)** — the name given to the downloaded `.docx` file.
  Because it accepts **tokens** (provided by the Token module), you can build the
  filename from node data — for example the node title — so each download is named
  meaningfully. Tokens are resolved in the current language.
- **Paper size** — the page size for the document (for example A4 or Letter).
- **Margins** — the page margins applied to the document.
- **Font styling** — the **font family**, **color**, and **size** used for the
  title and body text. No CSS or JS is involved; the styling is applied directly
  when the document is built.

Click **Save configuration** to apply. New downloads use the updated settings
immediately.

## What gets exported

Only the node's **title** and **body** are written into the document — the title
as a heading and the body converted from its HTML. Other fields are not included.
Output escaping is enabled for the generated document, so the body content is
safely rendered inside the `.docx`.

## Adding the download link

The settings form controls formatting; to actually offer the download, either rely
on the **Download Word Document** local task tab that appears on nodes, or add a
link to `/entity-word/{node_id}/word` in your node's Twig template where you want
the button.
