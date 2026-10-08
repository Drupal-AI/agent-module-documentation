<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The entire module is one hook in `vocabulary_description_length.module`:

```php
function vocabulary_description_length_form_taxonomy_vocabulary_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  if (isset($form['description'])) {
    $form['description']['#type'] = 'textarea';
  }
}
```

- Targets **only** the `taxonomy_vocabulary_form` (add/edit a vocabulary at
  `/admin/structure/taxonomy/add` and `/admin/structure/taxonomy/manage/<vid>`).
- Flips the Description element from core's default `textfield` to a `textarea`, so editors get
  a multi-line box.

## What it does NOT do

- **No storage change.** A vocabulary's description is a plain string in the
  `taxonomy.vocabulary.<vid>` config object regardless — core imposes no length limit, and this
  module adds none. Long descriptions are storable with or without the module; it only makes
  them practical to *type*.
- **No validation, no maxlength, no formatter change.** Front-end rendering of the description
  is untouched.
- **No effect on term descriptions** or any other entity/form — it is scoped to the vocabulary
  form only.

## Reading a vocabulary description (for evals / scripting)

```bash
drush cget taxonomy.vocabulary.tags description
```

Or in PHP: `\Drupal::config('taxonomy.vocabulary.<vid>')->get('description')`, or via the
entity: `Vocabulary::load('<vid>')->getDescription()`.
