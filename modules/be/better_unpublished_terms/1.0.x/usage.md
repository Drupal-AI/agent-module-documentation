Better Unpublished Terms lets users who can create, edit, or delete terms in a vocabulary also view and reference the unpublished terms in that vocabulary, without granting them full `administer taxonomy`.

---

Drupal core gives granular create/edit/delete permissions per vocabulary but has no granular control over who may view or reference *unpublished* taxonomy terms — core effectively limits that to users with `administer taxonomy`. This module swaps in its own taxonomy-term access control handler (`BetterTermAccessControlHandler`) and its own entity-reference selection plugin (`BetterUnpublishedTermSelection`) so that any user holding `create terms in <vocab>`, `edit terms in <vocab>`, or `delete terms in <vocab>` implicitly gains the ability to view unpublished terms of that vocabulary and to select/reference them (including terms they create inline via Inline Entity Form). Published terms continue to require only `access content`; users without any of the relevant permissions still cannot see unpublished terms. It is drop-in: enable it and the behavior applies site-wide with no configuration.

---

- Let content editors who can edit a vocabulary also preview its unpublished terms on the term page.
- Allow a workflow where terms are created unpublished and only referenced by editors until an admin publishes them.
- Reference an unpublished term from a node's entity-reference field while the term is still in draft.
- Create an unpublished term inline (via Inline Entity Form) on a parent entity and immediately reference it.
- Give a "taxonomy manager" role visibility of unpublished terms without handing them `administer taxonomy`.
- Keep unpublished terms out of autocomplete/select widgets for anonymous and low-privilege users.
- Preserve core's rule that published terms need only `access content` to view.
- Hide unpublished terms from users who have no create/edit/delete permission in the vocabulary.
- Support per-vocabulary scoping — permission in one vocabulary does not reveal unpublished terms in another (via the reference selection handler).
- Let editors validate and submit newly created unpublished terms through IEF forms they are allowed to manage.
- Model a moderation-style flow for taxonomy using the term published flag plus vocabulary permissions.
- Avoid custom access hooks by delegating to per-vocabulary term permissions you already assign.
- Apply consistent unpublished-term access across term pages, entity-reference formatters, and reference widgets.
- Let JSON:API / entity-reference consumers honor the same broadened access rules automatically.
- Enable draft-then-publish taxonomy curation on editorial sites.
- Give merchandising/editorial teams working vocabularies where terms are staged unpublished.
- Restrict unpublished-term reference selection to appropriately permissioned users on multi-author sites.
- Support Inline Entity Form workflows where child terms and the parent entity are edited together.
- Continue to allow `administer taxonomy` users full view/reference access to all terms.
- Provide a lightweight alternative to writing a custom taxonomy access control handler.
