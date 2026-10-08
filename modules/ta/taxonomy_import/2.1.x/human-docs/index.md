# Taxonomy Import — manual setup guide

**Taxonomy Import** (`taxonomy_import`) bulk-creates taxonomy terms in an
**existing** vocabulary from a file you upload — either a CSV spreadsheet export
or an XML document. Instead of adding terms one at a time through the term form,
you point the module at a vocabulary, pick a file, and it reads each row into a
new (or updated) term.

The file is read column by column, in a fixed order: the **first** column/tag
becomes the term name, the **second** is the parent term (matched by name, so you
can build a hierarchy), and the **third** is the description. Any extra columns
whose headers match custom fields on the vocabulary are set on the term too. The
module does **not** create the vocabulary for you — it must already exist before
you import into it.

It works on Drupal 8, 9, 10, and 11 and needs nothing beyond Drupal core. Two
small admin pages make up the whole module: an **import** form where you run an
import, and a **settings** form where you tune the allowed upload extensions and
maximum file size.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the import form, the CSV/XML file
   format, and the upload settings, field by field.

## Where it lives in the admin menu

Once enabled, the module adds two pages under **Configuration → Content
authoring**:

- The **import** form at **Configuration → Content authoring → Taxonomy Import**
  (`/admin/config/content/taxonomy_import/import`), gated by the *administer
  taxonomy import* permission.
- The **settings** form at
  `/admin/config/content/taxonomy_import/settings_import_taxonomy`, gated by the
  *administer configure taxonomy import* permission.

## How to use it

1. Create the target vocabulary first, at **Structure → Taxonomy** if it does not
   already exist.
2. Prepare a CSV or XML file with name, parent, and description columns (see
   [Configuration](configuration/index.md) for the exact format, and note the
   module ships sample `CSV_Test.csv` / `XML_Test.xml` files you can copy).
3. Open the import form, choose the vocabulary, decide whether to update existing
   terms or force new ones, upload the file, and submit. You are redirected to the
   vocabulary's term list when it finishes.
