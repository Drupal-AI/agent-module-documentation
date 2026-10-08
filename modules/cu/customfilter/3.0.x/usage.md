<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Filter lets a suitably-permitted administrator define their own text-format filters — regular-expression search/replace rules, optionally executing PHP replacement code — through the admin UI, without writing a module.

---

Each **filter** is a `customfilter` config entity (config prefix `customfilter.filters.*`) that becomes a selectable filter on every text format (via `hook_filter_info_alter`, class `CustomFilterBaseFilter`, `type: 2`). A filter is just a container; the work is done by ordered **rules** stored inside it. Every rule has a PCRE `pattern`, a `replacement`, and a `code` flag. When `code` is off, the rule does a plain `preg_replace(pattern, replacement)` (with `$1`/`${1}` backreferences). When `code` is on, the `replacement` textarea is treated as **PHP** and run with `@eval()` inside a `preg_replace_callback`; the code receives the regex `$matches[]` and must assign `$result`, plus a persistent `$vars` stdClass shared across a filter's rules. Rules can nest into **subrules** that re-process the n-th captured substring of their parent. Managing filters and rules is entirely gated behind the `administer customfilter` permission (`restrict access: TRUE`); the filter then only runs on content once a text-format admin enables it on a format. Because rule code is `eval`'d and non-code replacements are inserted verbatim, a filter author is trusted exactly like a Full-HTML/PHP-capable admin — see the permissions doc. The module also ships a Drupal 6/7 → 11 migration source for old-style customfilter data.

---

- Define a site-specific text-format filter without writing a custom module.
- Wrap bare URLs in `<a>` tags with a regex rule.
- Convert `[tokens]` or shortcodes in body text into HTML markup.
- Auto-link `#hashtags` or `@mentions` to search/user pages.
- Replace profanity or banned words with asterisks via a global regex.
- Insert a standard call-to-action block wherever a placeholder string appears.
- Rewrite legacy inline markup (e.g. old BBCode) into modern HTML.
- Add `rel="nofollow"` to outbound links matching a domain pattern.
- Turn `:emoji:` codes into `<img>` emoji.
- Normalise typographic quotes/dashes across content.
- Build a glossary filter that links the first occurrence of defined terms.
- Strip or rewrite tracking query parameters from pasted links.
- Wrap code-like patterns in `<code>` tags.
- Use captured groups (`$1`, `${12}`) to reorder or reformat matched text.
- Compute a replacement dynamically in PHP (e.g. format a matched number, look up a value) when the code flag is on.
- Share state between several rules of one filter using the `$vars` object.
- Process only the n-th captured substring of a match with a nested subrule.
- Chain multiple ordered rules (by weight) into a single named filter.
- Give editors short/long filter **tips** shown under text areas describing what the filter does.
- Toggle per-filter render caching (`cache`) for expensive rules.
- Enable the same custom filter on several text formats at once.
- Migrate legacy Custom Filter rules from a Drupal 6 or 7 site into Drupal 11.
- Prototype a transformation quickly in the UI before hardening it into a real filter plugin.
