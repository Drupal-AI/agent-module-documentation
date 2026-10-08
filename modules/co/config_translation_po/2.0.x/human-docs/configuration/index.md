# Configuration

Config Translation PO has no settings to tune — its "configuration" is the two
tabs it adds for exporting and importing configuration translations. Both live on
the core page at **Configuration → Regional and language → Configuration
translation** (`/admin/config/regional/config-translation`) and both require the
**Translate interface** permission.

## Export configuration strings to a `.po` file

1. Open the **Export** tab
   (`/admin/config/regional/config-translation/export`).
2. Choose the **language** you want to export.
3. Submit. The module walks every translatable configuration object, collects each
   translatable string, and streams the result to your browser as a download named
   `<langcode>.po` (for example `fr.po`).

A few useful details:

- Each string in the file carries a **context** built from its configuration name
  and key path, so identical source strings coming from different config objects
  stay separate and don't collide during translation.
- Exporting the special **system** (source) language gives you an untranslated
  *template* `.po` — all the source strings with empty translations — which is a
  good starting file to hand to a translator for a brand-new language.
- The exported file's PO project header is set to your site name.

## Import a translated `.po` file

1. Open the **Import** tab
   (`/admin/config/regional/config-translation/import`).
2. Upload the translated `.po` file and pick the target language.
3. Submit. The import runs in two passes:
   - First it loads the strings into Drupal's interface-translation (locale)
     string tables, the same way a normal `.po` import does.
   - Then it runs a second batch that writes the translated strings into each
     language's **configuration overrides** (or into active configuration for the
     source language), processing config objects in batches so large sites don't
     time out.

When it finishes you'll have populated configuration translations without clicking
through the per-config forms.

## Typical workflow

1. **Export** the `.po` for a language (or the system template for a new one).
2. Translate it offline in Poedit / Weblate / memoQ, or send it to a translation
   agency — they never need access to your site.
3. **Import** the finished `.po` back in.
4. Optionally keep the `.po` files in version control as reviewable, diff-able
   artifacts, or move them between environments.

## Good to know

- Access to both tabs is exactly core's **Translate interface** trust boundary —
  the module adds no elevated capability.
- The two config objects the importer writes are not schema-typed by this module,
  which is normal for this workflow; the round-trip still works.
- The 2.0.x release changed only core compatibility (now Drupal 10.1.3+, 11, or
  12) and internal API shims — the Export/Import screens behave exactly as before.
