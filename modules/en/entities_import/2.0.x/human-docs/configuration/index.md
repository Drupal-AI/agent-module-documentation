# Configuration

You configure Entities Import by creating one or more **import types** — each
describes an entity to import and how the spreadsheet maps to it — and then
running the import. You can keep several import types side by side for different
content.

## Create an import type

1. Go to **Structure → Entities Import** (`/admin/structure/entities-import`) and
   click **Add Entities Import Type**.
2. **Choose the entity type** you want to import (content or taxonomy).
3. **Unique value fields** — enter the field name(s) used to decide whether a row
   updates an existing entity or creates a new one (for example
   `field_tags,title`). Add multiple fields on separate lines. If a matching
   entity already exists, it is updated rather than duplicated.
4. **Title field name** — the field used to generate the title/name for the
   created content or term. If you leave this blank, the *Unique value fields* are
   used to build the title/name instead.
5. **File/image folder path** — for file or image fields, enter the folder where
   those files will live (for example `article-images`). You list each file's name
   in the spreadsheet, and after the import completes you move the actual files to
   this folder on the server manually.
6. **Save** the import type.

## Run an import

1. Back on the import types list, click **Edit** on your import type — this
   reveals the **Import** button.
2. Prepare your spreadsheet so that **every column matches a field** on the target
   content type or vocabulary. For multilingual imports, include a **`langcode`**
   column with values like `en`. A sample template is included in the module's
   `doc` folder — follow the same structure.
3. Click the **Import** button to create or update the entities using the current
   configuration.

## Notes and cautions

- The spreadsheet's columns must line up with real fields on the entity — mismatched
  columns will not import correctly.
- Supported field types include text, content/taxonomy references, numbers, dates
  and date ranges, files/images, and paragraphs.
- Because a row can **update** an existing entity (matched on the unique value
  fields), double-check those mappings so you do not overwrite entities
  unintentionally.

> **Security reminder.** Restrict the import permission (under **People →
> Permissions**) to trusted users — the import creates and updates content with the
> importer's privileges — and treat the spreadsheet as untrusted input: validate
> its contents before importing.
