<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Importer, structure.yml & content assembly

The import is the module's core mechanism. Source: `src/Form/CMSGuideImportContent.php`
(form id `cms_guide_import_content`, route `entity.cms_guide.import`,
`/admin/structure/cms-guide/import`, `_permission: administer cms_guide`).

## Content sources

`getAllContent()` collects entries from:

1. **The `cms_guide` module's own `content/structure.yml`** (source label `Default`). The shipped
   file is an empty list (`[]`) — the contrib module ships no content.
2. **Every `@CMSGuideContent` plugin** (companion modules). For each plugin definition,
   `$this->moduleList->getPath($def['provider'])` gives the module path and
   `$def['structure'] ?? 'content/structure.yml'` the structure file. See
   [content-plugin.md](content-plugin.md).

Entries are keyed by `slug`; `validateContentSlugs()` records any slug that appears in more than
one pack and the form warns that only one will import.

## structure.yml format

A YAML list; each item:

```yaml
- title: First section title      # required
  slug: first-section             # required; unique key + URL slug
  summary: Optional blurb          # optional; shown on the landing list
  content: first-section/intro.md  # optional top-level Markdown, relative to the structure file's dir
  sections:                        # optional sub-sections
    - title: First subsection      # required per section
      content: first-section/sub.md # required per section
```

`getContent()` validation (bad entries are skipped, errors surfaced on the form, not fatal):
- entry missing `slug` or `title` → skipped with a "missing required" error;
- section missing `title` or `content` → that section skipped;
- structure file missing → "structure file not found"; YAML parse error → caught
  (`Symfony\Component\Yaml`), reported, pack skipped.

## Markdown → HTML conversion

`convertContent($path, $module_path, $base)`:
- Resolves the Markdown file relative to the structure file's directory
  (`$module_path . '/' . dirname($structure) . '/' . $content`).
- Replaces the literal placeholder `{{image_path}}` with
  `/<module_path>/<base>/images` so each pack's screenshots resolve from its own module dir
  (`![alt]({{image_path}}/x.png)`).
- Converts with `League\CommonMark\GithubFlavoredMarkdownConverter` (GitHub-flavored Markdown).
- Missing file → empty string + a load error.

`assembleContent()` concatenates the top-level content HTML with each sub-section, prefixing each
sub-section with `<h2 id="section-{anchor}" class="cms-guide__section-heading">{title}</h2>`
(title `htmlspecialchars`-escaped; anchor = lowercased title, non-alphanumerics → `-`, trimmed).
It returns the combined HTML plus a `sections` meta list of `{title, anchor}` used to build the
sidebar's in-page anchor navigation.

## Import / refresh / delete semantics

On submit (`submitForm()`):
- Checkboxes select which slugs to import; the form defaults to all currently-imported slugs
  checked (button label becomes **"Refresh content"** when entries already exist, else
  **"Import content"**).
- **Unchecking** a previously-imported slug → that entry is **deleted** (`array_diff_key` of
  existing vs. included → `deleteEntity()`).
- For each included slug, `getEntityBySlug()` decides **update vs. create** (matched by `slug`).
  Update overwrites `title`, `summary`, `content`, `weight`, `source`, `sections`, and stores
  `imported_content_hash = sha256(assembled_content)`. Weight is assigned by import order.
- The store is the entity storage; content is written with text format **`cms_guide`**.

## Manual-edit detection

`getManuallyEditedEntities()` calls `CMSGuide::hasBeenManuallyEdited()` — compares
`sha256(current content)` against the stored `imported_content_hash`. If an admin edited a guide
page in the UI since the last import, the import form shows a **"Re-importing will overwrite them"**
warning listing those pages (links to their edit forms). Re-import still overwrites.

## Delete-all

`Form/CMSGuideDeleteContent` (`/admin/structure/cms-guide/delete`,
`_permission: administer cms_guide`) loads and deletes **every** `cms_guide` entity.
