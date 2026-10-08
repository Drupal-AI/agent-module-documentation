# Configuration

Setting up a legal document has three parts: create the document, add and publish a
version (the actual text), and choose who must accept it and how. You'll also want to
set permissions so the right people can view and are required to accept it.

## Open the admin UI

1. Log in as a user with the **Administer entity legal** permission.
2. Go to **Structure → Legal documents** (`/admin/structure/legal`). This lists all
   your documents; use **Add legal document** to create one.

## Step 1 — Create the document

On the add/edit form you'll set:

- **Administrative label** and **Machine name** — the document's name and its
  internal id (for example *Privacy policy* / `privacy_policy`).
- **Current version** — a picker listing this document's versions. Whichever you
  choose here becomes the single *published* version shown to users (selecting a new
  one automatically unpublishes the previous one). On a brand-new document you'll
  come back to this after adding a version in Step 2.
- **New users** — whether new users must accept during registration, and the
  **method** used to ask them: *Form link* (a checkbox linking to the document) or
  *Form inline* (the acceptance embedded in the registration form).
- **Existing users** — whether already-registered users must accept, and the
  **method**: *Message* (a status message on every page), *Popup* (a modal on every
  page until accepted), or *Redirect* (send them to a dedicated acceptance page).
- **Title pattern** — the page title, built from tokens. The default
  `[entity_legal_document:label]` simply uses the document's label; customize it if
  you want a different title.

When you first save the document, the module automatically creates its rich-text
body field, ready for you to fill in on the version.

## Step 2 — Add a version (the text users see)

A document holds one or more **versions**, and exactly one can be published at a
time. Add one via **Manage** on the document (or
`/admin/structure/legal/manage/{document}/add`). Each version has:

- **Title** — the version's heading.
- **Body** — the full rich-text of the document (with a text format, so output is
  filtered accordingly).
- **Acceptance label** — the text shown next to the acceptance checkbox (for example
  *"I agree to the Terms & Conditions"*). This is XSS-filtered on output.
- **Published** — mark this the live version. The module enforces that only one
  version per document can be published; if the language module is on, versions are
  translatable.

Only the published version is shown to users. If you preview a non-published version
you'll see a warning that it isn't the live one.

When you update your policy, add a **new version** and publish it (rather than
editing the old one). That preserves the history and, for audiences configured to
re-accept, prompts users to agree to the new wording — while your records still show
who accepted the earlier version.

## Step 3 — Permissions

Entity Legal uses permissions both to control who can see a document and to decide
who must accept it. On top of **Administer entity legal** (full management), each
document you create generates two per-document permissions at *People → Permissions*:

- **`legal view <document id>`** — who may view the document. To show a document to
  anonymous visitors, grant this to the *Anonymous user* role.
- **`legal re-accept <document id>`** — which existing users are actually required to
  (re-)accept. An existing user is prompted only when the document requires existing
  users *and* the user holds this permission — so you can scope re-acceptance to
  specific roles.

There is also a **Bypass entity legal acceptance** permission for support/admin staff
who should never be forced to accept anything. Holders of **Administer entity legal**
are likewise always exempt. This is deliberate — don't grant those two broadly if you
want everyone held to the acceptance requirement.

## How acceptance is recorded

When a user ticks the acceptance checkbox and submits, the module creates an
acceptance record for **that user** against the **currently published version** — no
one can accept on another user's behalf. Once a matching record exists for the
published version, the user is considered to have agreed and won't be prompted again
until you publish a newer version. If a user account is deleted, its acceptance
records are cleaned up with it.

## Reporting on acceptances

The module ships an optional **Legal document acceptances** Views listing so you can
report on who accepted what and when. Enable Views and find it among your views, or
build your own report against the acceptance records.

## Migrating legacy data

If you're moving from an older legal-acceptance setup, the module includes migrate
source/destination plugins for importing legacy documents, versions, and
acceptances. See the [`agent/`](../../agent/start.md) docs for details.

## Adding a custom delivery method

The five built-in methods cover most needs, but developers can add a new one by
writing an `EntityLegal` plugin, and can alter the available methods with
`hook_entity_legal_document_method_alter()`. Both are documented in the
[`agent/`](../../agent/start.md) docs.
