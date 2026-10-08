# Configuration

Taxonomy Ordinal needs a short setup sequence before terms start showing ordinal
numbers. The steps below follow the order the module expects.

## 1. Have a nested vocabulary ready

If you do not yet have a taxonomy vocabulary, go to **Structure → Taxonomy**
(`/admin/structure/taxonomy`) and add one, then add some terms in a nested
(parent/child) structure — the hierarchy is what the numbering is built from.

## 2. Enable the module for your vocabulary

1. Go to **Configuration → Content authoring → Taxonomy Ordinal**, or navigate to
   `/admin/config/content/taxonomy-ordinal`.
2. Tick the vocabulary (or vocabularies) you want to use for structuring your
   content.
3. Click **Save configuration**.
4. **Clear the cache fully** afterwards — this step is required for the new field
   and settings to appear.

## 3. Set the index formats on the vocabulary

Open the vocabulary's config page, for example
`/admin/structure/taxonomy/manage/{vid}` (where `{vid}` is your vocabulary's machine
ID). You will find a new **Taxonomy Ordinal** section where you edit the string
formatters. Two special characters control the format:

- **Pipe `|`** separates the term levels (parent, then children). You do not have to
  configure every level — where no formatter is given for a deeper level, the
  ordinal number is simply appended after a leading dot (`.`).
- **`%on`** is the placeholder where the ordinal number itself is injected.

So a formatter like `Chapter %on | Section %on | Article %on` produces output such
as *Chapter IV, Section 12.3, Article A*.

> **Important:** you must **save the configuration at least once**, even if you are
> happy with the default values — the defaults are not written into the section's
> third-party settings until you save.

## 4. Make the ordinal number visible

1. Move to the vocabulary's **Manage display** tab.
2. Move the **Ordinal number** field (this is the formerly hidden *weight* field)
   from the disabled region into the visible region.
3. Click the gear icon to adjust its display style.
4. Repeat this for every view mode where you want the number shown.

Save, and your terms will now display an ordinal structure. You can adjust a term's
ordinal number in the term's edit form, in the **Relation** section.

## 5. (Optional) Extend the numbering to nodes or other entities

To make content that references these terms share the same address structure:

1. Open the **Manage fields** page of your content type, for example
   `/admin/structure/types/manage/{bundle}/fields`.
2. Make sure the content type has an **entity reference** field pointing at terms of
   the enabled vocabulary, with a cardinality of **1** (not multiple values). Add one
   if it does not exist.
3. Add a new field of type **Taxonomy Ordinal**.
4. In that field's settings, set the **taxonomy** option to the entity-reference
   field from step 2 (the one that refers to the enabled vocabulary's terms).
5. Configure the formatters just as you did for the vocabulary above.

Now referencing content picks up its place in the numbered structure automatically.

## Notes on how the numbering behaves

- Numbers are **unique** — you cannot save the same index twice.
- Numbers are **stable** — deleting a term or entity does not renumber the ones that
  follow, so citation references stay valid.
- Automatic weight (ordinal number) changes are suppressed so the numbering does not
  drift on its own.
- Moving a term (or the referencing entity) to a **new parent resets its index to
  zero** (disabled), so you can renumber it deliberately.
