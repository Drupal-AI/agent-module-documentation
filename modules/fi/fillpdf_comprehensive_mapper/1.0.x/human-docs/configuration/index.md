# Configuration

FillPDF Comprehensive Mapper has a single, consequential setting: which FillPDF
form acts as the **master** mapping. Choosing it — and every subsequent save of the
master — copies that form's field mapping onto all your other FillPDF forms.

> **This is destructive.** Saving this form overwrites the matching field mappings
> on every *other* FillPDF form with the master's. Make sure you have backed up your
> configuration and that you have deliberately built the form you intend to use as
> the master. See [Installation](../installation/index.md#before-you-configure--back-up).

## Open the settings form

1. Log in as a user with FillPDF's **Administer PDFs** permission.
2. Navigate to **`/admin/config/media/fillpdf/comprehensive-mapper`** (also
   reachable via the module's **Configure** link on the Extend/module list).

## Choose the source form

The form presents a single choice:

- **Comprehensive mapper form (source form)** — select the FillPDF form to use as
  the master. This is stored as `source_form` in the module's configuration.

Build this master form first: it should be the one "exhaustive" PDF that contains
every field mapping you want propagated (the editable PDF fields plus the
entity‑based tokens that fill them). Only the fields whose keys match on another
form are inherited, so a comprehensive master is the point.

## What happens when you save

Saving the settings form immediately kicks off a batch process that:

1. Finds every FillPDF form on the site except the source.
2. Loads the source form's field mappings.
3. Imports those mappings onto each of the other forms — every field whose key
   matches the master inherits the master's mapping.

The same propagation runs again whenever you **edit and save the master form
itself**, so keeping the master current keeps every other form current.

## Re‑propagating later

You don't need to revisit this settings page to re‑apply mappings — just edit and
save the designated master FillPDF form, and its mappings are re‑applied across all
forms automatically.
