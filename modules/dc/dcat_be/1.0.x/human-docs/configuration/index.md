# Configuration

Setting up DCAT-BE has three practical stages: adjust its settings, import the
controlled vocabularies, then create, validate, and export datasets. All of it sits
inside the DCAT admin area and is gated by granular permissions.

## 1. Settings

1. Log in as a user with the **Administer DCAT BE** permission.
2. Go to **Structure → DCAT → Settings → DCAT-BE**, or navigate directly to
   `/admin/structure/dcat/settings/dcat-be`.

The settings form is a Belgium-focused, simplified version of the DCAT export
settings — it exposes the fields relevant to the Belgian profile, including catalog
title/description (translatable via config translation) and the catalog feed's cache
max-age. Save your changes as usual.

## 2. Import the controlled vocabularies

DCAT-BE relies on official controlled vocabularies (Belgif, EU Publications Office,
ADMS, INSPIRE, QUDT) imported as multilingual taxonomy terms. Import them once
before you start creating datasets:

- **In the UI:** go to **Structure → DCAT → Vocabulary import**
  (`/admin/structure/dcat/vocabulary-import`, *Administer DCAT BE*) and run the
  import.
- **With Drush:**

  ```bash
  # Import every vocabulary
  drush dcat-be:import-vocabularies

  # Import a single vocabulary (e.g. EU data themes)
  drush dcat-be:import-vocabulary eu_data_themes

  # Add newly-published terms to existing vocabularies
  drush dcat-be:update-vocabularies

  # See which vocabularies are available
  drush dcat-be:list-vocabularies
  ```

The module fetches only from a fixed list of official HTTPS sources — it never uses
a URL you supply — and falls back to bundled data if a source can't be reached.

## 3. Manage the supporting entities

DCAT-BE adds three reusable entity types you can create from the **Content** area
and reference from datasets/distributions:

- **License** — licensing information.
- **Location** — geographic coverage.
- **Quality Measurement** — data-quality statements.

Each has its own create / edit / delete permissions; grant them to the appropriate
roles at **People → Permissions**.

## 4. Validate datasets

DCAT-BE checks datasets against the profile's cardinality and mandatory-field rules
(including Dutch/French bilingual metadata, which surfaces as validation warnings):

- **In the UI:** open a dataset and use its **validate** tab
  (`/admin/content/dcat/dataset/{id}/validate`). This is read-only and requires the
  *Validate DCAT BE datasets* permission plus view access to the dataset.
- **With Drush** (handy in CI pipelines):

  ```bash
  drush dcat-be:validate-dataset <dataset-id>
  ```

## 5. Export DCAT-BE JSON-LD

- **Whole catalog:** DCAT-BE overrides the base DCAT export feed so the catalog is
  served as DCAT-BE JSON-LD. A dataset's full view also gets a JSON-LD export link.
- **Single dataset via Drush:**

  ```bash
  drush dcat-be:export-dataset <dataset-id> --pretty
  ```

Grant the export permission (*Export DCAT BE datasets* / the relevant DCAT export
permission) to whoever needs to produce or read the output.

## Permissions summary

Set these at **People → Permissions** (`/admin/people/permissions`):

- **Administer DCAT BE** — settings and vocabulary import.
- **Export DCAT BE datasets** and **Validate DCAT BE datasets** — the export and
  validate actions.
- **Administer DCAT BE entities**, plus the full create/edit/delete sets for
  **License**, **Location**, and **Quality Measurement**.
