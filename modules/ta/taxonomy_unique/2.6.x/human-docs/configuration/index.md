# Configuration

Taxonomy Unique has no global settings page. You turn uniqueness on **per
vocabulary**, and the setting is stored with that vocabulary (so it exports with
your configuration for deployment).

## Turn uniqueness on for a vocabulary

1. Go to **Structure → Taxonomy** and edit the vocabulary you want to protect
   (`/admin/structure/taxonomy/manage/<vocabulary>`).
2. Open the collapsed **Taxonomy unique** fieldset.
3. Tick **Terms should be unique.**
4. Optionally fill in **Message to show if term already exists** — the error a
   user sees when they try to save a duplicate. You can use two placeholders:
   - `%term` — the duplicate term name.
   - `%vocabulary` — the vocabulary name.
   If you leave it empty, the module uses its default message:
   *Term "%term" already exists in vocabulary "%vocabulary".*
5. Click **Save**.

Repeat for each vocabulary that should enforce unique term names. Vocabularies you
don't configure are unaffected.

## How the check behaves

- **Scope.** Uniqueness is per **vocabulary + name + language**. The same name may
  still exist in another vocabulary, or in the same vocabulary in a different
  language. Editing a term doesn't collide with itself.
- **When it runs.** The check happens during entity validation at **save time**,
  so it applies to the admin term form, content imports, and REST / JSON:API term
  creation alike.
- **Free‑tagging fields.** The module also blocks an autocomplete "Tags"‑style
  reference field from silently **auto‑creating** a duplicate term, so both
  manually entered and auto‑created terms stay unique.

## Turning it off

To disable it again, edit the vocabulary, untick **Terms should be unique**, and
save.
