<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebformImporter service

`Drupal\d7_import_webform\Service\WebformImporter` (`src/Service/WebformImporter.php`), service
`d7_import_webform.webform_importer` (args: `entity_type.manager`,
`plugin.manager.webform.handler`, `logger.factory`). API: `import(\DOMDocument): array` returning
`['imported','skipped','errors']`, and `purgeAll(): int`.

## import() flow

For each `<webforms><webform>` (direct children only):
1. `nid`/`title` read; `buildWebformId(title, nid)` → ≤32-char slug (`{title_slug}_{nid}`, or
   `webform_{nid}` fallback). Existing entity by that id → skip.
2. `parseComponents()` → flat list keyed by `cid`, each with `pid`, `form_key`, `name`, `type`,
   `value`, `required`, `weight`, and an `extra` array.
3. `buildElements(components)` → nested D11 elements tree.
4. `parseSettings()` + `mapSettings()` → `[settings, confirmation_type, confirmation_url]`.
5. `Webform::create([...])` with `categories = ['Drupal 7 Import']` and `status` from D7
   `{webform}.status` (open/closed — **not** the node published flag); `setElements()`;
   merge settings over defaults; `save()`.
6. `parseEmailHandlers()` → each becomes an `email` handler created via the handler plugin manager
   and attached with `addWebformHandler()` (each attach re-saves the webform).

## Component mapping (`COMPONENT_TYPE_MAP` / `mapComponent()`)

| D7 type | D11 `#type` | Extra handling |
|---------|-------------|----------------|
| textfield | textfield | `maxlength`→#maxlength, `width`→#size, field_prefix/suffix |
| textarea | textarea | rows, cols, resizable→'vertical' |
| email | email | — |
| number | number | min / max / step |
| select | select / radios / checkboxes | `aslist=0`→radios (checkboxes if multiple); options from `items` |
| hidden | hidden | — |
| fieldset | fieldset / details | collapsible→details, collapsed→`#open:false` |
| markup | webform_markup | `value`→#markup, title dropped |
| date | date | — |
| time | webform_time | — |
| file | webform_document_file | extensions merged from `filtering.types` + `filtering.addextensions`; `filtering.size`→#max_filesize |
| pagebreak | webform_wizard_page | handled in `buildElements()`; nested pagebreaks dropped |
| grid | webform_likert | (listed in map) |

Any other D7 type → `mapComponent()` logs a warning and returns NULL (element skipped). Common
attributes applied to all: `#title` (name), `#required`, `#description` (extra.description),
`#title_display` (D7 `none`→`invisible`), `#default_value` (except markup), `#placeholder`,
`#private`.

## Element nesting & wizard pages (`buildElements`)

- Children grouped by `pid`, each bucket sorted by weight then cid. Root = pid 0.
- No root pagebreak → flat tree via `appendElement()` (recurses into fieldset children).
- Root pagebreaks present → components partitioned into `webform_wizard_page` containers: an
  implicit "Page 1" holds everything before the first pagebreak; each pagebreak opens a new page.
  Empty leading `page_1` is dropped (D7 forms often start with a pagebreak).
- `uniqueKey()` sanitises each key to `^[a-z][a-z0-9_]*`, ≤64 chars, de-duplicated within the form.

## Settings mapping (`mapSettings`)

D7 → D11 Webform settings: `confirmation`→confirmation_message, `submit_text`→form_submit_label,
`submit_limit`/`submit_interval`→limit_user(+interval), `total_submit_limit`/interval→limit_total,
`allow_draft`→draft=DRAFT_AUTHENTICATED, `preview`→preview=DRUPAL_OPTIONAL (+ preview_title/message).
`redirect_url`: `<confirmation>`→confirmation_type `page`; `<none>`→`none`; absolute URL→`url` with
confirmation_url.

## Email handlers (`parseEmailHandlers` / `mapEmailField`)

Each `<emails><email>` → an `email` handler config (`handler_id` = `email_{n}`, status TRUE):
- `to_mail`/`from_mail` via `mapEmailField()`: a numeric value that matches a component cid becomes
  `[webform_submission:values:{form_key}:raw]`; literal addresses/tokens pass through; empty →
  `[site:mail]`.
- `from_name` default `[site:name]`, `subject` default `[webform_submission:source-title]`,
  `body` = D7 template or `_default`, plus `html`, `attachments`.
- `excluded_components` (CSV of cids) resolved via `cidToKey` to `excluded_elements` (keyed by
  form_key).

## Safety note

`unserializeExtra()` decodes the D7 `extra` blob with `@unserialize($raw, ['allowed_classes' =>
FALSE])` — no object instantiation — and retries with recomputed `s:len:` prefixes when XML
`\r\n`→`\n` normalisation broke the byte-length counts.
