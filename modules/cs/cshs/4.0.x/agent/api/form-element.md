# Using the `cshs` form element

CSHS registers a reusable render/form element `@FormElement("cshs")`
(`src/Element/CshsElement.php`, extends core `Select`). Use it in any custom form or render
array to get the hierarchical term selector without the Field UI.

```php
$form['category'] = [
  '#type' => 'cshs',
  '#title' => $this->t('Category'),
  '#default_value' => $tid,          // a taxonomy term id (or NULL)
  '#none_value' => 0,                // value representing "no selection"
  '#parent' => 0,                    // restrict tree to this parent term id (0 = whole vocab)
  '#save_lineage' => FALSE,          // return the full ancestor chain
  '#force_deepest' => FALSE,         // require a leaf-term selection
  '#labels' => ['Region', 'Country', 'City'], // per-level labels (optional)
  // Provide the vocabulary via the options builder; the element is meant for
  // taxonomy term references.
];
```

- The submitted value is the selected term id (or the lineage array when `#save_lineage`).
- `#none_value` is used to represent an empty choice; the element checks against it when
  validating the deepest-level requirement.
- The same properties back the field widget — see [../configure/widget.md](../configure/widget.md).
- Options/vocabulary wiring is provided by `src/CshsOptionsFromHelper.php`; term storage
  lookups use `src/TaxonomyStorages.php`.
