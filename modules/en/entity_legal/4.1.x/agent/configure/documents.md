# Configure legal documents

Admin UI: `/admin/structure/legal` (list), add at `/admin/structure/legal/add`. Documents are
`entity_legal_document` **config entities** (config prefix `entity_legal.document.*`); their text lives in
`entity_legal_document_version` **content entities** (bundle = the document id).

## The document (`EntityLegalDocumentForm`)

Fields on add/edit (`entity.entity_legal_document.edit_form`, permission `administer entity legal`):

- **Administrative label** + **Machine name** (`id`).
- **Current version** — a tableselect of this document's versions; the chosen one becomes the single
  published version (via `setPublishedVersion()`, which unpublishes the previous one).
- **New users** tab → `settings.new_users`:
  - `require` (checkbox) → stored as the entity's `require_signup`.
  - `require_method` (select) → which `EntityLegal` plugin of `type = new_users` presents it
    (`form_link` or `form_inline`).
- **Existing users** tab → `settings.existing_users`:
  - `require` → stored as `require_existing`.
  - `require_method` → an `EntityLegal` plugin of `type = existing_users` (`message`, `popup`, `redirect`).
- **Title pattern** (`settings.title_pattern`, default `[entity_legal_document:label]`) — tokenized page title.

Config export shape (schema `entity_legal.document.*`):

```yaml
# entity_legal.document.<id>
id: privacy_policy
label: 'Privacy policy'
require_signup: true
require_existing: false
settings:
  new_users:      { require: true,  require_method: form_inline }
  existing_users: { require: false, require_method: popup }
  title_pattern: '[entity_legal_document:label]'
```

On first save the document auto-creates a `entity_legal_document_text` body field (a
`text_with_summary`/`text_textarea_with_summary` widget, `text_default` formatter, summary hidden) on its
version bundle.

## Versions (`entity_legal_document_version`)

Add a version at `/admin/structure/legal/manage/{document}/add`. Content-entity fields: `label` (title),
`acceptance_label` (the checkbox text, XSS-filtered on output), `published` (bool, constrained to one true
per document by `SingleLegalDocumentPublishedVersion`), the `entity_legal_document_text` body, plus
created/changed. Versions are translatable when the `language` module is on. `render_cache = FALSE`.
Only the published version is shown to users; viewing a non-published version shows a warning.

## Acceptance flow

- The acceptance form (`EntityLegalDocumentAcceptanceForm`, embedded by the method plugins and by
  `EntityLegalDocument::getAcceptanceForm()`) shows the `acceptance_label` checkbox; on submit it creates
  an `entity_legal_document_acceptance` for the **current user** bound to the **published version's** id.
- `EntityLegalDocument::userMustAgree($newUser, $account)` decides if a user must accept:
  new users need `require_signup`; existing users need `require_existing` **and** the
  `legal re-accept <id>` permission. Admins/bypassers are excluded upstream (see permissions doc).
- `userHasAgreed()` is true once an acceptance row exists for the published version.
- Deleting a user deletes their acceptance rows (`entity_legal_user_delete`).

## Reporting

The optional Views view `legal_document_acceptances` ("Legal document acceptances") lists acceptance
records. Migrate plugins under `src/Plugin/migrate/*` import legacy documents, versions, and acceptances.
