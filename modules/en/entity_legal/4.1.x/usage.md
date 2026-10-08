Entity Legal lets you create versioned legal documents (terms & conditions, privacy policy, EULA) that users must accept, and records each acceptance against the specific document version the user agreed to.

---

The module defines a `entity_legal_document` config entity (the document, also a bundle) with one or more
`entity_legal_document_version` content entities (the actual title + rich-text body, one published at a
time, translatable), plus an `entity_legal_document_acceptance` content entity that logs who accepted which
version and when. Each document can require acceptance from **new users** (on the registration form) and/or
**existing users**, and the *delivery method* for each is a pluggable "method" — the module ships five
`EntityLegal` plugins: `message` (status message on every page), `popup` (jQuery-UI modal on all pages until
accepted), `redirect` (force existing users to an acceptance page), `form_link` (checkbox linking to the
document on the register form) and `form_inline` (embedded acceptance on the register form). Acceptance is
recorded via a dedicated form that creates an acceptance entity for the current user against the currently
published version. Documents expose dynamic per-document permissions (`legal view <id>` and
`legal re-accept <id>`), and users with `administer entity legal` or `bypass entity legal acceptance` are
never forced to accept. Titles use tokens (`title_pattern`), the acceptance label is XSS-filtered, and a
validation constraint guarantees only one published version per document. A Views view lists acceptances,
and migrate source/destination plugins support importing legacy documents, versions, and acceptances.
Requires `token`.

---

- Publish a Terms & Conditions document users must accept before using the site.
- Require new users to tick an acceptance checkbox on the registration form.
- Require existing users to (re-)accept an updated policy the next time they browse.
- Keep a full version history of a legal document and switch which version is "published".
- Record an auditable log of exactly which user accepted which version, and when.
- Force re-acceptance only from users who haven't agreed to the current version.
- Show a dismissible-until-accepted popup for a privacy policy on every page.
- Show a persistent status message prompting acceptance of an agreement.
- Redirect users who must accept a document to a dedicated acceptance page.
- Embed the acceptance checkbox inline in the user registration form.
- Link to the full document text from a checkbox on the signup form.
- Gate document visibility with a per-document "view" permission for anonymous/role access.
- Scope which existing-user roles must re-accept via the `legal re-accept <id>` permission.
- Exempt admins/support staff from acceptance with `bypass entity legal acceptance`.
- Translate the document title, body, and acceptance label per language.
- Build the document page title from tokens (e.g. the document label).
- Present different documents to new users vs existing users with different delivery methods.
- Ensure exactly one published version per document via the built-in validation constraint.
- Report on acceptances through the bundled "Legal document acceptances" Views view.
- Migrate legacy legal documents, versions, and acceptances via the provided migrate plugins.
- Automatically delete a user's acceptance records when the user account is deleted.
- Add a custom acceptance delivery method by writing a new `EntityLegal` plugin.
- Alter the available acceptance methods with `hook_entity_legal_document_method_alter()`.
- Provide GDPR/consent-style proof-of-acceptance for compliance audits.
