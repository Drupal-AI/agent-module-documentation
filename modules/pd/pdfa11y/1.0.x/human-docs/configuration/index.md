# Configuration

PDFa11y is configured in two places: the **settings form**, which controls what is
checked and how strictly, and the **permissions**, which decide who can change the
rules, run checks, and read reports.

## The settings form

Go to **Configuration → Media → PDFa11y**
(`/admin/config/media/pdf-accessibility`). The options are:

- **Automatic checking on upload** — enable or disable analysing PDFs
  automatically when they are uploaded through a media form. With it on, editors get
  immediate feedback.
- **Block or warn** — decide what happens when a PDF fails an accessibility check.
  *Warn* lets the file be saved but flags the problems; *block* prevents saving a
  non‑compliant PDF until it is fixed. Choose according to how strict your
  compliance obligations are.
- **Minimum PDF version** — the lowest PDF version considered acceptable, since some
  accessibility features depend on newer PDF versions.
- **Which checks to run** — turn individual checks on or off. The built‑in checks
  are:
  - **Tagged PDF** — verifies the document has a logical structure tree that screen
    readers can follow.
  - **Document Title** — ensures the PDF has a descriptive title in its metadata.
  - **Document Language** — confirms a document language is declared so assistive
    technology pronounces content correctly.
  - **PDF Version** — validates the file meets the minimum version you set above.

Save the form when you are done. (Developers can add custom checks through the
module's plugin system; those appear here alongside the built‑in ones.)

## Permissions

Under **People → Permissions** (`/admin/people/permissions`), PDFa11y provides four
cleanly separated permissions so you can hand out visibility without handing out
control of the ruleset:

| Permission | What it grants | Give to |
|---|---|---|
| **Administer PDF accessibility settings** *(restricted)* | Change which checks run and all the settings above | Site administrators only |
| **Run PDF accessibility checks** | Manually trigger a check on a PDF | Editors who maintain documents |
| **View PDF accessibility reports** | See the results on media items | Editors and reviewers |
| **View PDF accessibility help** | Read the guidance page on producing accessible PDFs | Anyone who needs the guidance |

Because these are separate, you can, for example, give an editor "run" and "view"
so they can re‑check a replaced document and see the outcome, without letting them
weaken which checks are enforced.

## Reading the reports

Each PDF **media item** has an **Accessibility** tab showing its detailed check
results and remediation suggestions. To audit documents you already have, use the
module's **Drush** command to batch‑check existing PDFs from the command line.

## Batch‑checking existing PDFs

If you enable PDFa11y on an established site, the automatic checks only cover *new*
uploads. Run the module's Drush command to check the PDFs already in your media
library, then review the results on each item's Accessibility tab and prioritise
what to remediate.

> **Guidance:** a companion help page lives at
> `/admin/config/media/pdf-accessibility/help` (governed by the *View PDF
> accessibility help* permission) with advice on creating accessible PDFs — worth
> sharing with your content editors.
