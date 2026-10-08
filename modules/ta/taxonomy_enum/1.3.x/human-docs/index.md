# Taxonomy Enum — manual setup guide

**Taxonomy Enum** (`taxonomy_enum`) is a developer's tool that keeps a taxonomy
vocabulary in sync with a PHP enum. It is aimed at the situation where you have a
vocabulary with a fixed, known set of terms and custom code that needs to behave
differently depending on which term is referenced. Instead of hardcoding term
IDs (which differ between environments and break when content is rebuilt), you
reference the terms as typed enum cases in your code — which is both safer and
portable between environments.

Once you define an enum and connect it, the module does the housekeeping for
you. It automatically creates taxonomy terms from the enum's cases, and (if you
choose) deletes the matching terms when you remove cases from the enum. It can
disable the ability to manually create or delete terms in that vocabulary, so
the enum stays the single source of truth. Default field values are stored in
configuration as machine names rather than entity UUIDs, keeping your config
portable. And in code you can read the enum instance straight off a field —
`$entity->get('some_taxonomy_enum_field')->enum` — so branching on a term
becomes a clean PHP comparison. It even ships a migration helper to convert an
existing entity‑reference field:
`\Drupal::service('taxonomy_enum.migration')->migrateField('field_tags', 'node')`.

This is site‑building/developer infrastructure: it manages the term‑to‑enum
relationship and has no content or access‑control role of its own. It depends on
core **Taxonomy** and on the **Taxonomy Machine Name**
(`taxonomy_machine_name`) module, since it uses term machine names to line terms
up with enum cases. It supports Drupal 9.3, 10 and 11, and is used from code
rather than through an admin settings form.

This guide is written for a **human** setting the site up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependency
   with Composer, then enable it.

## How to use it

Because Taxonomy Enum is driven from code, the workflow is: enable it (and the
Taxonomy Machine Name module), define a PHP enum for the fixed set of terms you
want, and connect it to a vocabulary so the module creates the terms from the
enum cases. From then on, add or remove cases in the enum to add or remove
terms, and read the enum off your fields in custom code with `->enum`. To convert
an existing term‑reference field to the enum‑backed approach, use the bundled
`taxonomy_enum.migration` service. The behaviours mentioned above — deleting
terms when cases are removed, and locking manual term creation/deletion — are
configurable, so you can decide how strictly the enum governs the vocabulary.
