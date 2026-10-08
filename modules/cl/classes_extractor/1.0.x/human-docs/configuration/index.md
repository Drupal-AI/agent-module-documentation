# Configuration

Classes Extractor has a single setting: the **file path** where the extracted list
of classes is written. It is stored in the `classes_extractor.configform`
configuration object and edited through the module's settings form.

## Open the settings form

1. Log in as an administrator (the form requires the *Administer site
   configuration* permission).
2. Go to **`/admin/config/classes-extractor`**, or use the **Configure** link next
   to Classes Extractor on the **Extend** page.

## What you configure

- **Classes Extractor File Path** (required) — the path of the file that
  `drush cec` will write the collected classes into. The form shows your site root
  (`DRUPAL_ROOT/`) as a prefix hint; make sure the file's directory exists and is
  writable by the web/CLI user. This is the only option the module exposes — there
  is no list of modules or sources to choose, because the sources are fixed by the
  built-in extractor plugins.

## What gets collected

The extraction gathers CSS class names already stored in your configuration:

- Classes configured on **Views**.
- Classes on **entity view displays**, including **Display Suite** field/region/
  layout settings and **Layout Builder** section/component settings.
- **Display Suite** global region and field classes (`ds.settings`).
- Classes declared in a text format's **allowed HTML** (the extractor reads the
  format named `basic_editor`).

## Extending the extractor

If the defaults don't cover a source of classes you care about, a developer can
add a custom extractor plugin: create a class in the `Plugin/ClassesExtractor`
namespace annotated with `@ClassesExtractor` and returning class names from
`getClasses()`. It is then picked up automatically after a cache rebuild — no core
changes needed. See the [`agent/`](../../agent/extraction.md) docs for a code
example.

## Running the extraction

Configuration only sets the output path; the work happens on the command line.
After saving, run:

```bash
drush cec
```

to write the file of extracted classes, or fetch the current list as JSON (with
the admin permission) from `GET /api/v1/classes-extractor`.
