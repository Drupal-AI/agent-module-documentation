# Configuration

Configuring Field Long Text Pager has two parts: an optional site-wide **default
settings** page, and the per-field **formatter** you enable on Manage display.

## Set the module defaults (optional)

1. Log in as an administrator.
2. Go to **Configuration → Content authoring → Field Long Text Pager**
   (`/admin/config/content/field_longtext_pager`).
3. Set the default paging behavior — including the **page-break placeholder** the
   module looks for in your content. The default example placeholder is a
   recognizable marker you can insert in the editor; keep it consistent with what
   your text formats and CKEditor plugins produce.
4. Save.

These defaults seed the per-field formatter, so you don't have to re-enter the same
choices on every field.

## Enable paging on a field

1. Go to **Structure → Content types → *(your type)* → Manage display**.
2. Find the long-text field you want to paginate and set its **Format** to **Field
   pager**.
3. Click the field's **gear icon** to open the formatter settings and choose how
   the text should be split and what extras to show:

   - **Split mode** — page-break placeholders, or automatically after a set number
     of **characters**, **words**, or **HTML blocks**.
   - **Pager index field** — show an index of the pages.
   - **Estimated reading time** — display a reading-time estimate.
   - **AJAX paging** — move between pages without a full page reload. Note that
     AJAX results are rendered through the entity's **Full page** view, falling
     back to the **Default** view when a Full view is not available (as is often
     the case for entities such as comments).

4. **Update** the field, then **Save** the display.

## Multiple paged fields on one page

The module automatically increments pager IDs when several entities that use paged
fields appear on the same page, so their pagers don't collide. When you have a
primary paged field that matters most (for example the main body), give it the
**highest** pager ID in its settings so its pager takes precedence in that
scenario.
