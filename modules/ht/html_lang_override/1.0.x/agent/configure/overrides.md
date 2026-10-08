<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Lang Override — configuring overrides

## Global & path overrides
Settings form: `/admin/config/regional/html-lang-override` (route `html_lang_override.settings`, permission `Override HTML lang attribute`; the global toggle/default fields additionally check `Administer HTML lang override settings`).
- **Global:** enable "Override Default HTML lang attribute Globally" and set a Default Language Code — used when no node/path override matches (`HtmlLangManager::getDefaultLang()`).
- **Path map:** a newline-separated list of `path|langcode` entries; `getLangForPath()` matches the exact request path info and returns the code.

## Per-node override
`html_lang_override_form_node_form_alter()` adds a "Custom HTML Lang Attribute" textfield (in an advanced-group details element), shown only to users with `Override HTML lang attribute`. On insert/presave the raw request value is `Html::escape(trim())`-ed and saved via `HtmlLangManager::saveLangForNode()` into the `html_lang_override_node` table; an empty value deletes the row. Node delete removes the row.

## How the attribute is applied
`HtmlLangSubscriber::onRespond()` (on `KernelEvents::RESPONSE`) resolves the code in order:
1. Node on the current route → `getLangForNode(nid)`.
2. Else request path → `getLangForPath(path)`.
3. Else global/default → `getDefaultLang()`.
Then it `preg_replace`s `<html ... lang="...">` in the response body. Only `HtmlResponse` objects are modified.

## Notes for agents
- Values are escaped and capped at 10 chars — safe for the attribute; use valid BCP-47 codes (`en`, `ja`, `pt-br`).
- The regex runs on **every** HTML response body; on very large pages this is a minor cost.
- DB queries in `HtmlLangManager` are parameterized (`merge`/`select`/`delete`) — no raw SQL concatenation.
