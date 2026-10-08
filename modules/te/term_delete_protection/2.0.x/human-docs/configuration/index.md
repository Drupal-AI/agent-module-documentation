# Configuration

Term Delete Protection has **no dedicated settings page**. You configure it
directly on each vocabulary you want to guard, so protection is always opt-in and
scoped to the vocabularies that matter to you.

## Turn protection on for a vocabulary

1. Log in as a user who can administer taxonomy (an administrator by default).
2. Go to **Structure → Taxonomy** and click **Edit** on the vocabulary you want to
   protect (for example *Tags* or *Categories*).
3. Scroll to the **Term Delete Protection** section on the vocabulary edit form.
4. Tick the referencing **entity types** you want to guard against, then click
   **Save**. A status message confirms the change.

That's it — the terms in that vocabulary are now protected against deletion
whenever they (or their descendants) are referenced by the entity types you chose.

## The "protect against" checkboxes

The section lists every content entity type that has an entity-reference field
pointing at taxonomy terms. This list is built dynamically:

- **Nodes** always appear.
- **Commerce products** appear when Commerce is installed.
- **Paragraphs** appear when Paragraphs is installed.
- Any **custom content entity type** with a taxonomy-reference field appears
  automatically too.

Tick an entity type to say "a term is protected if this kind of content references
it." Leave a type unchecked and references from it won't block deletion. If you
untick everything and save, the vocabulary is no longer protected at all.

Each vocabulary keeps its own independent selection, stored in the module's
`term_delete_protection.settings` configuration (which exports and deploys like any
other Drupal config). Vocabularies you never visit stay completely unprotected.

## What protection does once it's on

When a term in a protected vocabulary is referenced, the module enforces the guard
in four ways at once, so there is no back door to accidental deletion:

- **The term listing** — the *Delete* operation link is removed from the row on the
  vocabulary overview.
- **The term edit form** — the delete button is removed and replaced with a warning
  that lists the content currently using the term, grouped by entity type, linked,
  and showing the five most recent items per term.
- **Direct URL access** — navigating straight to a term's delete-form URL is
  intercepted; you're redirected back to the term with an error message instead of
  the delete form.
- **The overview page** — protected term rows are visually highlighted, with a
  summary warning at the top.

All of this is evaluated live against your current content, so as soon as a term
stops being referenced (for example after you retag or unpublish the content using
it) the term becomes deletable again — no re-saving of settings required.

## Good to know

- **"Referenced" includes descendants.** A parent term is protected whenever any
  child or grandchild term is still in use. This is why a parent term can be
  undeletable even when the parent itself is unused — it keeps hierarchies intact.
- **Only real taxonomy-reference fields count.** Specifically, entity-reference
  fields whose handler targets taxonomy terms.
- **Reference checks respect access.** Queries run with access checking on, so a
  term referenced only by content the current user cannot see may still look
  deletable to that user. Treat the feature as an integrity safeguard for trusted
  editors, not as a security boundary against untrusted users.

## For developers

If you need to answer "is this term (or its descendants) in use?" from your own
code, the module exposes a reusable service,
`term_delete_protection.reference_checker`. Its methods and reference-detection
details are documented in the [`agent/`](../../agent/start.md) docs.
