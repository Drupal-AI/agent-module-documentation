# Settings and the upload route

Plupload has **no admin form and no configure route** (`configure: null`). It ships exactly
one config value.

## `plupload.settings`

```yaml
temporary_uri: 'temporary://'   # scheme/URI where in-progress chunks are written
```

- Schema: `plupload.schema.yml` → `plupload.settings` (a `config_object` with the single
  string `temporary_uri`).
- Read it: `drush cget plupload.settings temporary_uri`
- Set it: `drush cset plupload.settings temporary_uri 'private://plupload-tmp' -y`
- Why change it: in a load-balanced / HA setup, chunks of one file may land on different
  web nodes. Point `temporary_uri` at a **shared** filesystem (e.g. a mounted NFS stream)
  so every chunk of a file is written to the same place before reassembly.

The controller (`\Drupal\plupload\UploadController`) reads this value to decide where to
stream chunks, and the element's value callback builds each descriptor's `tmppath` from it
(`temporary_uri` + fixed `.tmp` filename).

## The upload endpoint

Route `plupload.upload` — path `/plupload-handle-uploads`:

```yaml
requirements:
  _permission: 'access content'
  _csrf_token: 'TRUE'
```

The element sets its own upload URL to this route with a fresh CSRF token, so you normally
never call it directly. Anonymous users need `access content` to upload; tighten this by
gating the *form* that contains the element, not this shared route.

## Library note

`plupload_library_info_alter()` computes `max_file_size` from `Environment::getUploadMaxSize()`
and `chunk_size` from `post_max_size` at runtime, and loads `js/i18n.js` when `locale` is
enabled. These are derived, not stored config.
