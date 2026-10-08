# Taxonomy Access Fix — manual setup guide

**Taxonomy Access Fix** (`taxonomy_access_fix`) fills the gaps in Drupal core's taxonomy
permissions. Core is fairly all-or-nothing here: to let someone manage terms you often
end up granting **Administer taxonomy**, which hands over far more than you intended.
This module adds a set of **fine-grained, per-vocabulary** (and "any vocabulary")
permissions for viewing, selecting, creating, editing, deleting, reordering, and
resetting terms — so you can give each role exactly the taxonomy access it needs and
nothing more.

The permissions are unusually precise. Viewing a term's *page* is separate from viewing
its *name/label*; **published** and **unpublished** terms are separate again; and there's
a distinct **select** permission that controls which terms a user can pick in
entity-reference autocomplete/select widgets — without necessarily being able to open
those term pages. That lets you build things like a public glossary where anonymous users
see published term names but can't edit or reorder anything, or a curation workflow where
editors can select terms in a field but not browse the term admin.

It works by replacing core's access handlers for terms and vocabularies, and the term
entity-reference selection plugin, the moment you enable it — so there is **no
configuration**: enabling the module switches the extended checks on, disabling it
switches them off, with no data changes. The vocabulary overview page and term-overview
form are also filtered so users only see the vocabularies and controls they're allowed to
use. Core's **Administer taxonomy** still bypasses every check, and the module guards
itself with clear errors if another module has already replaced the handlers it expects.

Its only dependency is core's **Taxonomy** module.

This guide is written for a **human** assigning permissions in the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact operations each
permission maps to and the handlers/plugins it replaces — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it; that's
   the whole setup.

## How to use it

There's nothing to configure — you use it entirely from the permissions screens:

1. **Enable the module.** The extended, granular permission checks turn on immediately.
2. Go to **People → Permissions** (`/admin/people/permissions`) and look under the
   **Taxonomy Access Fix** provider. (Per-vocabulary permissions are also editable on
   each vocabulary's **Manage permissions** tab.)
3. Grant the specific permissions each role needs — instead of the broad
   **Administer taxonomy** grant.

### The kinds of permission it adds

Each capability comes in a **per-vocabulary** form (e.g. *view terms in tags*) and an
**any-vocabulary** form (e.g. *view any term*):

- **View terms** vs. **view term names** — one grants the full term page, the other only
  the label. Rendering a term label in a referencing entity checks the *name* permission.
- **Published vs. unpublished** — separate permissions for each, for both viewing and
  selecting. Published grants never cover unpublished terms.
- **Select terms** (published / unpublished) — controls which terms appear in
  "Default"-method entity-reference widgets, enforced both in the option list and on
  submit.
- **Create / update / delete any term** — the cross-vocabulary counterparts to core's
  per-vocabulary create/edit/delete permissions.
- **Reorder terms** and **Reset vocabulary** — reorder shows the drag-and-drop weights and
  Save button; reset shows the "Reset to alphabetical" action. They're independent of each
  other.
- **View vocabulary name** — view a vocabulary's label, per vocabulary or for any.

### Good to know

- The **vocabulary overview page** now requires the core *Access the taxonomy vocabulary
  overview page* permission **plus** at least one create/edit/delete/reorder/reset
  permission for that vocabulary — so you can expose the overview to a
  reorder-only role without full admin.
- The **vocabulary list** and **term overview** are filtered to hide vocabularies and
  controls a user can't use.
- **Administer taxonomy** bypasses all of these checks, as before.

The full permission list, the exact operation each one maps to, and the mechanics of what
the module replaces are in the [`agent/`](../agent/start.md) docs.
