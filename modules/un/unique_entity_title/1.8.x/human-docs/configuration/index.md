# Configuration

Unique Entity Title has no central settings page. Instead, you turn uniqueness on
per bundle with a single checkbox on the content type or vocabulary edit form. Only
node content types and taxonomy vocabularies are supported.

## Enable unique titles on a content type

1. Log in as an administrator and go to **Structure → Content types**
   (`/admin/structure/types`).
2. Click **Edit** on the content type you want to protect (for example Article),
   which opens `/admin/structure/types/manage/<type>`.
3. In the **additional settings** vertical tabs at the bottom of the form, open the
   **Unique entity title settings** section.
4. Tick **Enable unique title for this bundle**.
5. Click **Save**.

From now on, saving a node of that type with a title that already exists in the
same type is rejected with an error like *Title "…" is already in use. It must be
unique.* (The error uses your Title field's label if you have renamed it, for
example "Headline".)

## Enable unique names on a vocabulary

1. Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`).
2. Click **Edit** on the vocabulary you want to protect, which opens
   `/admin/structure/taxonomy/manage/<vid>`.
3. Find the **Unique vocabulary name settings** section.
4. Tick **Require unique term names**.
5. Click **Save**.

Terms in that vocabulary must now have distinct names.

## What the rule does (and doesn't) catch

- It scopes the check to the **same bundle**, so the same title may still exist in a
  different content type or vocabulary.
- It **trims whitespace**, so "Foo " and "Foo" are treated as the same.
- It **ignores empty titles**, leaving required‑field handling to core.
- It **excludes the current entity**, so re‑saving an existing node or term never
  collides with itself.
- Because it validates the field, the rule applies not only on the edit forms but
  also to content created via the entity API, JSON:API, and REST.

## Turning it off

Uncheck the same box and save. Uniqueness is enforced only while the box is ticked,
and you can enable it on some bundles while leaving others unrestricted.
