# Configure term delete protection

No standalone settings page. Protection is configured **per vocabulary**.

## Enable (UI)

*Structure → Taxonomy → edit a vocabulary* → **Term Delete Protection** section (a `details`, open) →
check the entity types to guard against → *Save*. The checkbox list is built dynamically from entity
types that have a taxonomy-reference field (via `TermReferenceChecker::getAvailableEntityTypes()`); nodes
always appear, Commerce products / paragraphs / other custom types appear when installed. A status message
confirms the save.

## Config object (`term_delete_protection.settings`, schema in `config/schema/…`)

```yaml
vocabularies:
  - vocabulary_id: tags
    protected_entity_types: [node, commerce_product]
```

- Ships as `vocabularies: []` (nothing protected until configured).
- Written by `term_delete_protection_vocabulary_form_submit()` (removes the vocabulary's old entry, then
  re-adds it only if at least one entity type is checked). Read by `term_delete_protection_is_enabled()` /
  `..._get_protected_entity_types()` and by the service.

## The four protection layers (`term_delete_protection.module` + subscriber)

| Layer | Implementation | Effect |
|---|---|---|
| Delete route block | `TermDeleteProtectionSubscriber::onRequest` on `KernelEvents::REQUEST` (priority 28), route `entity.taxonomy_term.delete_form` | If the vocabulary is protected and the term has references, adds an error message and `RedirectResponse` back to the term — the delete form never renders. |
| Operation removal | `hook_entity_operation_alter` | `unset($operations['delete'])` for referenced protected terms in listings. |
| Term edit form | `hook_form_taxonomy_term_form_alter` | Removes `actions.delete`, prepends a warning listing referencing content grouped by entity type (linked, newest-first, 5 per term). |
| Overview highlight | `hook_form_taxonomy_overview_terms_alter` | Adds `term-delete-protected` class to protected rows + a summary warning; attaches `term_delete_protection/overview_styles` CSS. |

All layers gate on `term_delete_protection_is_enabled($vocabulary_id)` and a live
`TermReferenceChecker::checkTermReferences()` result, so protection reflects current content in real time.

## Notes

- "Referenced" = the term itself OR any descendant term is referenced by an enabled entity type. Recursive
  descendant checking is why a parent term can be undeletable even when the parent itself is unused.
- Only `entity_reference` fields whose handler is `default:taxonomy_term` count. Reference queries run with
  `accessCheck(TRUE)`, so a term referenced only by content the current user cannot access may still appear
  deletable to that user.
- These are `taxonomy_vocabulary` / term form alters — the settings are authored by users who can edit
  vocabularies (a trusted admin capability). This is an integrity guard, not an access-control boundary for
  untrusted users.
