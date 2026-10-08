# Configuration

This module has no ongoing settings to tune — its "configuration" is the import
form you use each time you load a vocabulary from a file.

## Before you start — back up and validate

Because the importer **does not update an existing taxonomy tree**, importing into a
vocabulary that already contains terms can produce duplicates or an unexpected
structure. Two precautions save a lot of trouble:

- **Back up** your database (or at least the target vocabulary) before importing
  into anything that already has content.
- **Validate your CSV** first — check the parent‑child relationships and term names
  are exactly what you intend, and that the file comes from a trusted source.

Where possible, import into a **new, empty vocabulary** to keep things predictable.

## Run the import

1. Go to **Configuration → Taxonomy Importer**.
2. **Select the vocabulary** you want to import the terms into.
3. **Upload your CSV file** describing the terms and their parent‑child hierarchy.
4. Click **Submit**.

The module reads the file and creates the taxonomy terms with their hierarchical
(parent‑child) relationships.

## After the import

- **Review the resulting hierarchy** in **Structure → Taxonomy → *(your
  vocabulary)*** to confirm the terms and nesting came through correctly.
- Because taxonomy terms can drive access, menus, and content organisation, check
  that nothing depending on the vocabulary was disrupted.

## A note on preparing the CSV

The CSV describes terms and their parent‑child relationships. If you're unsure of
the exact column layout the importer expects, prepare a small test file first and
import it into a throwaway vocabulary to confirm the format before running a large
import.
