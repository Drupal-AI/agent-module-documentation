<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Token Debug UI adds one admin form at `/admin/config/development/tokendebug` where you paste text containing tokens, name some real entities as context (`node:17`, `user:1`), and see the text with every token replaced by its actual value — the answer to "what does this token evaluate to right now?" that core's token browser (which only lists what is *available*) does not give.

---

The module is a single `FormBase` (`Drupal\tokendebug\Form\TokenDebugForm`, form id `tokendebug_form`) mounted on the route `tokendebug.form` and gated by the permission `tokendebug:use form`. The form has four inputs: a **Text with tokens** textarea, a **Token data** textarea where each line is an `entity_type:id` pair (e.g. `node:17`), a **Clear unknown tokens** checkbox, and a **Show metadata** checkbox. On validation each data line is parsed by `parseData()`, which splits on the first colon and calls `entityTypeManager->getStorage($type)->load($id)`; a bad entity type or a missing id becomes a form error, otherwise the loaded entity object is keyed by its type into a `$data` array. On submit the form calls the core token service `\Drupal::service('token')->replace($text, $data, ['clear' => $clear], $metadata)` and prints the result as a status message via `Markup::create()`. When **Show metadata** is ticked, the collected `BubbleableMetadata` (cache tags, cache contexts, max-age) is `print_r`'d into a `<pre>` status message so you can see the cacheability the tokens bubbled up. The form also renders a `token_tree_link` element (the browsable token list) whose `#token_types` are the entity types you entered — that theme hook comes from the contrib **token** module, which is why token is a functional dependency even though `tokendebug.info.yml` declares no dependencies. Because it resolves tokens against real, loaded entities and prints the actual values, the form is a data-disclosure surface if reachable by anyone it should not be: it is a development/debugging aid, so keep it out of production module lists (not merely unlinked from the menu) and treat the `tokendebug:use form` permission as high-trust, admin-only.

---

- See what a specific token actually resolves to for a real entity.
- Debug why a meta description built from `[node:field_summary]` comes out empty.
- Distinguish an empty field from a nonexistent or misspelled token name.
- Check that a token even exists for a given entity type.
- Resolve `[node:title]` and `[node:author:name]` against a specific node id.
- Inspect a user's token values by entering `user:1` as data.
- Diagnose a failing Pathauto URL pattern before saving it.
- Verify a token string before pasting it into a Metatag configuration.
- Debug the placeholders in an email or Message template.
- Confirm a custom token provided by your module returns the expected value.
- Browse the available token tree for the entity types you supply.
- See the cache tags, contexts, and max-age a token bubbles up (Show metadata).
- Check whether "Clear unknown tokens" changes the rendered output.
- Troubleshoot a token used in a Views field or rewrite.
- Confirm a token in a Webform handler resolves correctly.
- Test a token against a scheduled or queued message context.
- Reproduce a token that renders differently in a theme.
- Verify multi-entity data (e.g. `node:17` plus `user:3`) in one replacement.
- Teach yourself the token syntax by experimenting interactively.
- Audit an inherited site for a debugging module left enabled in production.
