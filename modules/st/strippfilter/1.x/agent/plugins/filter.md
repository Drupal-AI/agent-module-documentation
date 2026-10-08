<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Strip paragraph tags" filter (`strippfilter`)

## Install & enable

```bash
composer require drupal/strippfilter
drush en strippfilter -y
```

Only dependency is core **`filter`** (`strippfilter.info.yml`, `dependencies: [drupal:filter]`).
Requires `ext-dom` (composer.json) and PHP `>=7.4`; core `^10.2 || ^11`. No sub-modules, no
permissions of its own, no Drush commands, no config.

## The plugin

- Class `StripParagraphTags` in `src/Plugin/Filter/StripParagraphTags.php`, extending core
  `Drupal\filter\Plugin\FilterBase`.
- Annotation:
  - `id = "strippfilter"`
  - `title = @Translation("Strip paragraph tags")`
  - `type = Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_REVERSIBLE`
  - `weight = -10`
- It overrides only `process($text, $langcode)`, returning
  `new FilterProcessResult(strippfilter_process($text))`. There is **no `settingsForm()`**, so the
  filter exposes no options — it is either on or off for a given text format.

## Exact strip behavior (`strippfilter.module`)

`strippfilter_process($text)`:

1. `$dom = Html::load($text);` — parses with Drupal's DOM/HTML5-PHP wrapper (`Drupal\Component\Utility\Html`).
   The reliance on this HTML5-aware loader is why the module requires **Drupal 10.2+**
   (drupal.org/node/3225468).
2. `$paragraphs = $dom->getElementsByTagName('p');`
3. If `$paragraphs->count() === 0` → **return `$text` unchanged**.
4. Otherwise loop every `<p>` and concatenate `strippfilter_inner_html($p)`; return the result.

`strippfilter_inner_html($element)`: for each child node, create a fresh `Html::load('')`, grab its
`<body>`, `appendChild($tmp_dom->importNode($child, true))`, and append `Html::serialize($tmp_dom)`.
So each child of the paragraph is **re-serialized through the DOM** and joined.

Net effect on input containing paragraphs:

- The `<p>` open/close tags are removed, along with **any attributes on them** (e.g. `dir`,
  `title`, `class` that CKEditor 5 leaves after a paste) — this is the whole reason a DOM approach
  is used instead of `str_replace(['<p>', '</p>'], '', $text)` (see the code comment).
- Inline markup **inside** the paragraphs (`<strong>`, `<em>`, `<a>`, text) is preserved.
- **Content that is not inside any `<p>` element is discarded**, and paragraphs are joined with no
  separator. Intended for single-value inline fields, not multi-paragraph body text.

Input with **no** `<p>` element passes through untouched.

## Enable it on a text format

The filter has no config, so you enable it per text format:

UI path: *Administration → Configuration → Content authoring → Text formats and editors*
(`/admin/config/content/formats`) → edit/create a format → tick **Strip paragraph tags** under
*Enabled filters*.

Typical setup (from the project's guidance):

- Create a dedicated format meant for **inline** output.
- Enable *Strip paragraph tags* on it and set its **order** deliberately. The plugin's default
  weight is `-10` (early), but the project page advises putting this filter **last** so it strips
  after other filters (e.g. `filter_html`) have run and produced their final markup.
- Restrict the target fields' *allowed formats* to only this format, and set the form widget to a
  one/two-line textarea (pairs well with the Textarea widget for text fields module).

Config equivalent (filter format YAML, `filter.format.<id>.yml`):

```yaml
filters:
  strippfilter:
    id: strippfilter
    provider: strippfilter
    status: true
    weight: 100   # order it last relative to the format's other filters
    settings: {}
```

## Notes & gotchas

- Do **not** use core's "Strip HTML tags" filter for this goal — it removes the paragraph content
  too, returning empty strings; `strippfilter` keeps the content and removes only the wrapper.
- Because non-paragraph content is dropped when any `<p>` exists, avoid enabling this on a general
  body format; scope it to fields that are meant to be single inline values.
- `strippfilter_help()` provides the module help page (`help.page.strippfilter`) describing the
  CKEditor 5 inline-output use case.
