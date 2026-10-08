# Configuration

PDB File Viewer has two layers of settings: a **global** settings form and
**per-display** formatter options on each field.

## Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/config/user-interface/pdb_file_viewer`**.

The fields:

- **Supported extensions** — a space-separated list of the file extensions that
  should be treated as viewable structures (for example `pdb ent cif mol2 sdf`).
- **Allow all extensions** — a switch that, when on, lets the viewer attempt any
  file extension rather than only the listed ones.
- **Library source (CDN or Local)** — whether NGL is loaded from the default public
  CDN (`unpkg.com`) or from a local copy you have placed in the module's
  `libraries/` directory. **For privacy and supply-chain hardening, choose Local** —
  loading scripts from a third-party CDN means every viewer's browser fetches code
  from an external host.

## Per-display formatter options

On a content type's (or other entity's) **Manage display**, set the file field's
format to **PDB File Viewer** and click the gear icon to configure:

- **Show file link** — also display the file name as a download link next to the
  viewer.
- **Show file size** — display the file's size.
- **Maximum file size** — cap rendering to files below a given size in bytes
  (`0` = unlimited). Useful to avoid trying to render very large structures.
- **Return empty** — output nothing when the file's format is not recognized;
  combine this with the **Fallback Formatter** module so unrecognized files fall
  through to another formatter (for example a plain download link).

## How rendering works (and a couple of notes)

The formatter outputs a viewport element and attaches the NGL library plus
`drupalSettings` (the file name, URL, and extension), and NGL fetches and draws the
file **client-side** in the browser. The file itself is a managed Drupal file
entity, so core file-access rules apply — there is no path-traversal or arbitrary
server-side file read here.

One thing worth knowing as an operator:

- **CDN vs. local:** the default CDN source is convenient but sends a request to an
  external host on every view; switch to **Local** to keep asset delivery in your
  control.

## Save

Save the global settings form and the display settings. Reload a page with a
structure file to see your changes.
