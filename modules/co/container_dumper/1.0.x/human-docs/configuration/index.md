# Configuration

Container Dumper has a single setting — the file it dumps the container to — and it
does nothing until you fill it in.

## Open the settings form

1. Log in as a user with the **"administer container dumper settings"** permission.
2. Go to **Configuration → Development → Container Dumper**, or navigate directly to
   `/admin/config/development/container-dumper`.

## Path

The **file to dump the container to**, including the filename, **relative to the
Drupal root**.

- **Choose a location that is not web‑accessible** — for example a private or
  dedicated analysis directory outside your public webroot. The XML describes your
  whole service container, so it should never be reachable over HTTP.
- If the target directory doesn't exist, the module creates it (mode 0775) when it
  writes.
- Leaving the path **empty disables dumping entirely** — that's how you turn the
  feature off again.

## Save

Click **Save configuration**. The container is (re)dumped **after each cache
rebuild** — run `drush cr` (or clear caches in the UI) and the XML file will appear
at your chosen path. Point your static analyser (PHPStan, Psalm, or your IDE) at
that file to resolve Drupal's service types.

## Notes

- Because writes happen at compile time, there is no per‑request performance cost.
- This is a **developer / CI tool** — avoid enabling it on production with a
  web‑accessible path.
