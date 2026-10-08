# Configuration

Configuring DDB Minimal Record Export is a four-step flow: choose what to export,
load an MDS catalog version, map MDS fields to your Drupal fields, then export. The
whole area lives at **Configuration → Export → DDB Minimal Record**
(`/admin/config/export/ddb-minimal-record`). Mapping, version, and config screens
require the **Administer DDB Minimal Record mapping** permission; the export screens
require **Export DDB Minimal Record LIDO**. A built-in **Help** page sits under the
same menu.

## 1. Choose the entity type and bundle

On the **Settings** form, select the content **entity type** and **base bundle** you
want to export. This choice drives everything else: once set, the module adds
per-entity export routes on that entity type's canonical path (an **MRD Export** tab
and a download route), and export access is restricted to entities that match this
type/bundle.

## 2. Load an MDS catalog version

The MDS field catalog is bundled with the module, and you can keep more than one
version and switch between them:

- **Import** a catalog version to add it.
- **Switch** the active version (CSRF-protected).
- **Delete** a version you no longer need (CSRF-protected).

Store and switch catalog/mapping versions from the settings page as your profile
requirements evolve.

## 3. Map MDS fields to Drupal field paths

Open the mapping dialog for each MDS field and pick the Drupal **field path** that
supplies its value. The field-option list is loaded dynamically (via AJAX) for your
chosen type/bundle and understands nested paths, so you can follow entity-reference
chains and reach file/media properties (for example Object → Media → file URL). You
can also:

- Set **export-side defaults** (institution, metadata rights, language, and so on),
  with optional per-entity field overrides.
- **Export the mapping as JSON** (and the MDS schema as JSON) to copy configuration
  between environments.

On entity forms for the configured type/bundle, mapped fields can display a small
**MR badge** — red for mandatory, yellow for recommended — so editors can see record
completeness at a glance. This badge can be disabled in the settings if you prefer.

## 4. Export

- **Single entity** — open an entity of the configured type/bundle and use its
  **MRD Export** local task (tab). You get a preview of the generated, XSD-validated
  LIDO XML and a download option. Access requires *Export DDB Minimal Record LIDO*
  **and** that the entity matches the configured type/base bundle.
- **Bulk** — go to the **Bulk LIDO Export** screen. Selected entities are queued and
  processed via Drupal's Queue API (cron or queue workers) when the set is large,
  producing a downloadable ZIP / lidoWrap file. Completed jobs are tracked in the
  database, and you can download or delete them.

## Validation

Every export is checked against the bundled digiS MDS profile XSD (LIDO 1.1 / MDS
1.0.1). A settings toggle lets you **fail the export when XSD validation fails**. For
full Schematron rules beyond the XSD, upload the produced XML to the external diLIVa
service.
