Enhanced taxonomy form titles rewrites the page title of the taxonomy term add, edit and delete forms so it names the action, the term and the vocabulary the term belongs to.

---

On sites with many vocabularies, the stock taxonomy term forms give an editor no visual clue about which vocabulary a term lives in — the add/edit/delete pages all show a generic title. This module implements `hook_form_alter()` and, only on the three core term routes (`entity.taxonomy_term.add_form`, `entity.taxonomy_term.edit_form`, `entity.taxonomy_term.delete_form`), replaces `$form['#title']` with a string such as "Edit term Sofa (Vocabulary : Furniture)" or, on the add form, "Add a term (Vocabulary : Furniture)". It has no configuration, no permissions, no settings form, no dependencies to enable beyond core taxonomy, and no runtime cost outside those forms (AJAX/XHR requests are skipped). Install it and the titles change immediately for everyone who can reach the term forms.

---

- See at a glance which vocabulary a term belongs to while editing it in the back office.
- Distinguish add, edit and delete term pages by their title alone.
- Reduce editor mistakes on sites that have dozens of similarly named vocabularies.
- Confirm the target vocabulary before deleting a term.
- Give content editors clearer breadcrumbs-style context on the term add form.
- Improve UX for taxonomy-heavy sites (product attributes, tags, categories, regions).
- Show the term's own label in the edit and delete form titles for quick confirmation.
- Help translators and reviewers know which vocabulary a term is filed under.
- Make screenshots and support tickets self-describing (the vocabulary is in the title).
- Onboard new editors faster on complex information architectures.
- Avoid opening a second tab just to check a term's vocabulary.
- Keep the standard core taxonomy workflow — nothing about term creation changes except the title.
- Deploy safely: no config to export, no schema, nothing to migrate.
- Enable/disable per environment without side effects on stored data.
- Pair with modules that add many vocabularies (commerce attributes, faceted taxonomies).
- Clarify context on modal/overlay term forms that lack surrounding navigation.
- Provide consistent titling across add/edit/delete without a custom theme override.
- Serve editorial teams who manage taxonomy across multiple content models.
- Give admins a lightweight, dependency-free quality-of-life improvement.
- Replace a one-off `hook_form_alter()` snippet you would otherwise write per project.
