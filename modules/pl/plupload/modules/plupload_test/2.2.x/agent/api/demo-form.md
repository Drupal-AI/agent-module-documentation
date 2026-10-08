# The demo form (`PluploadTestForm`)

The whole submodule is one form used as living documentation and as a test fixture.

- **Route:** `plupload.test` → `/plupload-test`, requirement `_access: 'TRUE'`
  (comment: "Do not enable in production").
- **Class:** `\Drupal\plupload_test\PluploadTestForm` (extends `FormBase`).
- **Form id:** `_plupload_test_form`.

## What it builds

```php
$form['plupload'] = [
  '#type' => 'plupload',
  '#title' => 'Plupload',
  '#upload_validators' => ['FileExtension' => ['extensions' => 'zip']],
];
$form['submit']      = ['#type' => 'submit', '#value' => $this->t('Submit')];
$form['ajax_submit'] = ['#type' => 'button', '#value' => $this->t('Ajax submit'),
                        '#ajax' => ['callback' => '::ajaxSubmit']];
```

## Validation

```php
foreach ($form_state->getValue('plupload') as $uploaded_file) {
  if ($uploaded_file['status'] != 'done') {
    $form_state->setErrorByName('plupload',
      $this->t('Upload of %filename failed.', ['%filename' => $uploaded_file['name']]));
  }
}
```

## Submit (the pattern to copy)

```php
$destination = $this->config('system.file')->get('default_scheme') . '://plupload-test';
$this->fileSystem->prepareDirectory($destination,
  FileSystemInterface::CREATE_DIRECTORY | FileSystemInterface::MODIFY_PERMISSIONS);

foreach ($form_state->getValue('plupload') as $uploaded_file) {
  $file_uri = $this->streamWrapperManager
    ->normalizeUri($destination . '/' . $uploaded_file['name']);
  // Move the finished temporary file (uploaded_file['tmppath']) to $file_uri.
  // No File entity is created.
}
```

Injected services: `file_system`, `stream_wrapper_manager`. This is the reference for how to
consume the `plupload` element's descriptor array (`name`, `tmpname`, `status`, `tmppath`) —
see the parent module's `agent/api/element.md`.
