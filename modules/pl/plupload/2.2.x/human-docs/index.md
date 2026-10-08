# Plupload Integration — manual setup guide

**Plupload Integration** (`plupload`) adds a `plupload` Form API element that wraps
the Plupload JavaScript library, giving Drupal forms a **chunked, multi‑file,
drag‑and‑drop** upload widget. Because it uploads files in chunks, it can move large
files (video, archives, big documents) past the usual PHP `upload_max_filesize` and
`post_max_size` limits — which is its main reason for existing.

This is primarily a **developer tool**: its entire public surface is a single render
element, `#type => 'plupload'`, that you place in a custom form. There is no ready
‑made field widget, no content‑editor UI you point at a content type, and — one
important gotcha — the element does **not** create file entities or move files for
you. After the form is submitted, your submit handler receives an array of
descriptors for the uploaded files (each with a name, a temporary path, and a
status) and is responsible for validating and saving them (for example copying them
to a destination and creating managed `File` entities).

Server‑side validation is applied through Drupal core's file validators via the
element's `#upload_validators` (notably an allowed‑extensions check), and uploaded
filenames are sanitized and transliterated automatically. The upload endpoint is
CSRF‑protected. A bundled `plupload_test` submodule provides a working demo form at
`/plupload-test` so you can try the element quickly.

This guide is written for a **human** — a site builder or developer — setting the
module up. If you want terse, token‑cheap references for an AI coding agent —
including the element's properties and the exact descriptor array your submit
handler receives — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the one setting (`temporary_uri`) and
   when you'd change it.

## Where it lives in the admin menu

Nowhere — the module has no admin settings page (`configure: null`), no permissions
of its own, and no Drush commands. It provides a form element for developers, plus
a single piece of configuration you'd only touch on load‑balanced setups (see
[Configuration](configuration/index.md)).

## How to use it (developers)

Add a `plupload` element to a form built in a custom module:

```php
$form['my_uploads'] = [
  '#type' => 'plupload',
  '#title' => $this->t('Upload files'),
  '#upload_validators' => [
    'FileExtension' => ['extensions' => 'jpg jpeg png pdf zip'],
  ],
];
```

Then, in your submit handler, read the descriptors and save the files yourself:

```php
$files = $form_state->getValue('my_uploads');
foreach ($files as $file) {
  // $file['name']    — the (sanitized) original filename
  // $file['tmppath'] — the full temporary:// URI of the uploaded file
  // $file['status']  — upload status
  // …copy it to a destination and create a managed File entity here.
}
```

Useful element properties include `#autoupload` (start sending bytes as soon as a
file is chosen), `#autosubmit`, `#submit_element`, `#event_callbacks` (wire custom
Plupload JS events for progress/error handling), and `#plupload_settings` (pass
runtime options such as chunk size and filters). The full list is in the agent docs
at [`agent/api/element.md`](../agent/api/element.md). To see it working end‑to‑end,
enable the `plupload_test` submodule and visit `/plupload-test`.
