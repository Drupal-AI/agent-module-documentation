<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Lang Override lets you change the `lang` attribute on the `<html>` element without changing Drupal's interface language — globally, for specific request paths, or for individual nodes.

---

A kernel response subscriber (`HtmlLangSubscriber`) runs on every HTML response and, in priority order, uses: a per-node language (if the current route has a node with a stored override), then a per-path override (from a newline-separated `path|lang` list in config), then the global default (either the configured override or the site default language). It rewrites the attribute with a `preg_replace` on the response body's `<html ... lang="...">`. Per-node values are captured by a `hook_form_node_form_alter()` that adds a "Custom HTML Lang Attribute" field (visible to users with the "Override HTML lang attribute" permission) and saved on entity insert/presave into a dedicated `html_lang_override_node` table via `HtmlLangManager` (which uses parameterized `merge`/`select`/`delete` queries).

Setup: enable the module, visit the settings form at `/admin/config/regional/html-lang-override` (permission "Override HTML lang attribute") to set the global override and per-path mappings, and optionally let node editors set per-node values. Security notes: submitted language codes are passed through `Html::escape()` before storage and output (max length 10), so the attribute cannot be broken out of for XSS; database access is parameterized. The per-node edit permission is not marked restricted, but since values are escaped this is low risk. Be aware the subscriber runs a regex over every HTML response body (a small performance cost).
---
- Set the site-wide `<html lang>` to a specific code regardless of UI language.
- Override the html lang attribute for a particular URL path.
- Set a custom html lang attribute on an individual node.
- Serve `lang="en"` on pages while keeping a different interface language.
- Improve accessibility by declaring the correct content language.
- Fix SEO issues from an incorrect html lang attribute.
- Map several paths to different language codes via config.
- Let node editors choose a per-page language code.
- Fall back to the site default language when no override applies.
- Enable a global override toggle with a chosen default language code.
- Restrict per-node overrides to users with the override permission.
- Store per-node language codes in a dedicated table.
- Remove a node's override by clearing the field.
- Clean up a node's stored language code automatically on delete.
- Configure path overrides as newline-separated `path|lang` entries.
- Declare `lang="ja"` on a specific landing page.
- Correct the language attribute on mixed-language sites.
- Ensure screen readers announce content in the intended language.
- Apply a language code to a marketing path without a full translation.
- Keep the attribute value safe via Html::escape and a 10-char limit.
