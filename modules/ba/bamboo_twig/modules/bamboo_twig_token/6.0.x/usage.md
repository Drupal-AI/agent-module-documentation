<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Token adds a single Twig function, `bamboo_token`, that runs Drupal token replacement from within a template.

---

This submodule of Bamboo Twig registers `bamboo_token(token, data, options)` on the service `bamboo_twig_token.twig.token`, wrapping `\Drupal::token()->replace("[$token]", $data, $options)`. You pass the token name **without** the surrounding brackets (the function adds them), an optional `data` hash supplying objects some tokens need (e.g. `{'node': node}`), and optional `options` flags such as `{'clear': true}`. It returns the replaced string, letting themers pull dynamic values into markup without a preprocess hook.

---

- Print the site name from a template (`bamboo_token('site:name')`).
- Output the site URL or login URL via a token.
- Render a node's title with `bamboo_token('node:title', {'node': node})`.
- Show a node's author name through a token.
- Display the current user's email (`bamboo_token('user:mail', {'user': user}, {'clear': true})`).
- Insert the current date/time using a date token.
- Build a canonical URL from a `node:url` token.
- Show a formatted created date via node tokens.
- Compose an email body fragment with tokens in a template.
- Clear unresolved tokens with the `{'clear': true}` option.
- Output the site slogan token in a header.
- Render a term name from a taxonomy token.
- Include a menu or path token value in markup.
- Provide dynamic meta tag content from tokens.
- Reuse existing token definitions from contrib modules in Twig.
- Insert a one-off token value without adding a preprocess function.
- Build breadcrumb or title strings from entity tokens.
- Surface any custom token your modules define, directly in a template.
