# Configuration

PDF using mPDF has one global settings form that sets the **defaults** for every
generated PDF, plus a set of per‑content‑type permissions that control who can
generate them.

## Open the settings form

1. Log in as a user with the **Administer mPDF settings** permission.
2. Go to **Configuration → User interface → mPDF**, or navigate directly to
   `/admin/config/user-interface/mpdf`.

Everything here is a *default*. A per‑call `$settings` array to the conversion
service, or the `hook_mpdf_settings_alter()` hook, can override any of it for a
specific document.

## The settings

### Output

- **Filename** (default `[site:name]-[date:custom:Y-m-d-H-i]`) — the file's name.
  Tokens are replaced, then the result is transliterated and stripped of unsafe
  characters. Tokens like `[node:title]`, `[site:name]`, and `[date:custom:...]`
  work here.
- **Save option** — what happens when a PDF is generated: **open inline in the
  browser**, present a **download dialog**, or **save to the server**.
- **Save scheme** and **Save path** — when saving to the server, which file scheme
  (system default, `public`, `private`, …) and which folder under it (default
  `pdf_using_mpdf`).
- **View mode** (default `full`) — which node view mode is rendered for the
  `Generate PDF` tab.
- **Render as anonymous** (default off) — render the node as the anonymous user
  before conversion, to strip personalized or admin‑only markup.

### Document metadata

- **Title**, **Author**, **Subject**, **Creator** — written into the PDF's
  document properties (all blank by default). Tokens are supported.

### Page layout

- **Page size** (default `A4`), **Orientation** (`P` portrait or `L` landscape).
- **Margins** — top/right/bottom/left plus header and footer margins, in
  millimetres (defaults `16/15/16/15/9/9`, validated as numbers ≥ 0).
- **Font size** (default `12`) and **Default font** (default
  `dejavusanscondensed`, one of mPDF's bundled Unicode fonts — useful for
  non‑Latin scripts).
- **DPI** and **Image DPI** (both default `96`).

### Header and footer

- **Header** (default `<strong>[node:title] - [site:name]</strong>` with a rule)
  and **Footer** (default a rule plus `[node:title]`) — HTML that mPDF renders at
  the top/bottom of each page. They support tokens and mPDF placeholders like
  `{PAGENO}` (page number) and `{DATE ...}`.

### Watermark

- **Watermark option** — a **text** watermark or an **image** watermark.
- **Watermark opacity** (default `0.1`).
- **Watermark text** — the text to stamp (e.g. "DRAFT", "CONFIDENTIAL") when using
  the text option.
- **Watermark image** — an uploaded image (managed file) when using the image
  option.

### Template and CSS

- **Template file** — a Drupal‑root‑relative path to a `.pdf` used as a fixed
  overlay/letterhead. Validated to exist, resolve safely under the Drupal root, and
  end in `.pdf`.
- **CSS from theme** (default on) — pull the active theme's intended CSS into the
  PDF so it matches your site; **CSS from theme (all)** loads *all* of the theme's
  declared library CSS.
- **CSS file** — alternatively, a Drupal‑root‑relative path to a specific `.css`
  file to inject (validated like the template path).

### Protection

- **Password** — if set, the PDF is encrypted and print/copy are restricted (via
  mPDF's `SetProtection`).

## Setting defaults with Drush

The settings live in the single config object `pdf_using_mpdf.settings` under a
nested `pdf_using_mpdf` key, so you generally set them by loading and re‑saving
that array. For example:

```php
// drush php:eval
$c = \Drupal::configFactory()->getEditable('pdf_using_mpdf.settings');
$s = $c->get('pdf_using_mpdf');
$s['pdf_page_size'] = 'Letter';
$s['orientation'] = 'L';
$s['pdf_save_option'] = '1'; // force a download dialog
$c->set('pdf_using_mpdf', $s)->save();
```

## Permissions — who can generate PDFs

The module defines two kinds of permission:

| Permission | Grant to | Controls |
|---|---|---|
| **Administer mPDF settings** | Trusted admins only (restricted permission) | Access to the settings form above. |
| **Generate *(type)* PDF** | Whichever roles should export that content type | The **Generate PDF** tab (`node/{node}/pdf`) for that content type. One permission exists per content type, e.g. *Generate article PDF*. |

A couple of things worth understanding about the per‑type permission:

- The route's access check tests the `generate <type> pdf` permission for the
  node's content type.
- These permissions are **not** marked as restricted; grant them deliberately.
