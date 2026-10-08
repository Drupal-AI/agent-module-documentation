<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter plugin: convert_url_filter

Source: `src/Plugin/Filter/ConvertUrlFilter.php` (class `ConvertUrlFilter`).

## What it is
A `@Filter` plugin:

- **id:** `convert_url_filter`
- **title:** "Convert internal absolute URLs to relative"
- **type:** `FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE` (transforms rendered output; not reversible to source)
- **default settings:** `filter_hosts = ""`
- extends `FilterBase`, implements `ContainerFactoryPluginInterface`; `create()` injects the
  `request_stack` service (stored as `$this->requestStack`).

`setConfiguration()` defensively re-applies the `filter_hosts` default so the setting is always present.

## Install / enable
1. `composer require drupal/convert_url_filter`, then `drush en convert_url_filter` (depends on core `filter`).
2. Go to Admin → Configuration → Content authoring → Text formats and editors
   (`/admin/config/content/formats`) and edit a format.
3. Enable **"Convert internal absolute URLs to relative"** in the filters list.
4. Under its filter settings, optionally fill the **Hosts** textarea, then save.

There is no module-level settings route; configuration lives on each text format
(`filter.format.<id>` config, under `filters.convert_url_filter.settings.filter_hosts`).

## Setting: `filter_hosts`
- `settingsForm()` renders one `textarea` titled "Hosts".
- Enter additional internal domains, **one per line, without `http(s)://` and without the `www.` prefix**
  (e.g. `my-domain.com`). Description shown to editors matches this.
- Schema: `config/schema/convert_url_filter.schema.yml` defines `filter_settings.convert_url_filter`
  as a mapping with `filter_hosts` (type `string`, label "Hosts").
- The **current request host is always internal** and does not need to be listed.

## Processing logic (`process($text, $langcode)`)
1. `$dom = Html::load($text)` — parse the input HTML into a `DOMDocument`.
2. Build the host list: split `filter_hosts` on newlines (`preg_split("(\r\n?|\n)", …)`),
   lowercase (`mb_strtolower`), drop empties (`array_filter`), then append
   `$this->requestStack->getMainRequest()->getHttpHost()`.
3. For each `<a>` element (`$dom->getElementsByTagName('a')`):
   - Skip if it has no `href` attribute.
   - `parse_url($href)`; if it has a `host` and that host with a leading `www.` removed
     (`preg_replace('/^www\./', …)`, lowercased) is `in_array` the host list, the link matches.
   - For a match, rewrite the href by stripping the leading `scheme://user@www.host:port` with
     `preg_replace('/^(?:https?:\/\/)?(?:[^@\/\n]+@)?(?:www\.)?([^:\/\n]+)(:\d+)?/i', '', $path)`
     and `setAttribute('href', …)`. The remaining path/query/fragment becomes the relative URL.
4. Return `new FilterProcessResult(Html::serialize($dom))`.

## Behavior notes
- Only existing anchor `href` attributes are rewritten; plain-text URLs are **not** linkified, and no new
  markup is generated.
- Links whose host is not in the list (external links) are left untouched.
- A protocol-relative or schemeless href with a matching host still has its host prefix stripped.
- Because the current request host is always added, editors' absolute links to the live domain become
  relative automatically with no configuration.
- The transform affects rendered output only; the stored source text of the field is unchanged.
