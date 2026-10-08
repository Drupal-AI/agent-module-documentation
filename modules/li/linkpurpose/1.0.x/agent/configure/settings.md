<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Purpose settings (`linkpurpose.settings`)

Route `linkpurpose.settings` → `/admin/config/user-interface/linkpurpose`
(form `Drupal\linkpurpose\Form\LinkpurposeSettings`, permission `administer linkpurpose`).
Everything is stored in the single `linkpurpose.settings` config object.

## The seven "purposes"

Each link category is one boolean toggle plus a family of string options. Shipped defaults have
every toggle **on** and a default screen-reader message:

| Toggle (default `true`) | Default `...Message` | Marks |
|---|---|---|
| `purposeExternal` | `Link is external` | off-site links |
| `purposeNewWindow` | `Link opens in new window` | links with `target="_blank"` |
| `purposeDownload` | `Link downloads file` | download links |
| `purposeDocument` | `Link downloads document` | document links (PDF/DOC/…) |
| `purposeApp` | `Link opens app` | app links |
| `purposeMail` | `Link sends email` | `mailto:` links |
| `purposeTel` | `Link opens phone app` | `tel:` links |

For each purpose `X` (e.g. `External`) these companion keys exist (all default `''`):
`purposeX Selector`, `purposeX Class`, `purposeX IconWrapperClass`, `purposeX IconType`
(`html` or `classes`), `purposeX IconPosition` (prepend/append), `purposeX IconClasses`, and
`purposeX Message` (the visually-hidden screen-reader text). Set `...Selector` to restrict a
purpose to matching links; set `...IconType`/`...IconClasses` to use your own icon instead of the
bundled one.

### External-only behaviors

- `purposeExternalNewWindow` (bool, default `false`) — force external links to open in a new window.
- `purposeExternalNoReferrer` (bool, default `false`) — add `rel="noreferrer"` to external links.

## Global options

| Key | Default | Meaning |
|---|---|---|
| `domain` | `''` | Extra comma-separated domains treated as **internal** (the site base URL is always internal). |
| `roots` | `''` | Selector(s) for page regions to scan; the library falls back to `body`. |
| `shadowComponents` | `''` | Selectors of shadow-DOM components to also scan. |
| `ignore` | `#toolbar-administration a` | Links matching these selectors are never marked. |
| `hideIcon` | `''` | Links matching these get the screen-reader hint but **no visible icon**. |
| `noRunIfPresent` | `''` | Skip marking entirely if this selector is found on the page. |
| `noRunIfAbsent` | `''` | Skip marking entirely if this selector is not found. |
| `noIconOnImages` | `false` | Visually hide the icon on links that wrap an image. |
| `insertIconOutsideHiddenSpan` | `''` | Avoid inserting icons into visually-hidden spans. |
| `suppressNoBreak` | `''` | Don't add a no-break wrapper to matched links. |
| `themePreprocess` | `false` | Let the theme preprocess JS before calling the library (attaches `linkpurpose/library` instead of `linkpurpose/init`). |
| `noAggregate` | `false` | Attach the `-noagg` library variants (no JS aggregation). |

## How config reaches the browser

`linkpurpose_page_attachments()` (in `linkpurpose.module`):

1. Adds cache tag `config:linkpurpose.settings` and returns immediately on **admin routes**.
2. Sets `drupalSettings.linkpurpose.domain` = configured `domain` + the site base URL.
3. Copies every **non-empty** config value into `drupalSettings.linkpurpose` (`...Message`
   values are run through `t()`).
4. Attaches `linkpurpose/init` (or `linkpurpose/library` if `themePreprocess`), swapping to the
   `-noagg` variant when `noAggregate` is on.

Because only non-empty values are forwarded, clearing a key restores the library's own default.

## Read / set via drush

```bash
drush cget linkpurpose.settings
drush cset linkpurpose.settings purposeExternalNewWindow true -y
drush cset linkpurpose.settings purposeExternalMessage 'Opens an external site' -y
drush cset linkpurpose.settings purposeTel false -y     # stop marking tel: links
```

In PHP:

```php
\Drupal::configFactory()->getEditable('linkpurpose.settings')
  ->set('purposeExternalNoReferrer', TRUE)
  ->set('roots', 'main')
  ->save();
```
