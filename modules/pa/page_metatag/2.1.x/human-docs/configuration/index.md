# Configuration

Page Metatag's job is to let you set meta tags for your pages and entities. Once the
module and its **Token** dependency are enabled, you configure the meta tags you
want and, where useful, build their values from tokens so they stay dynamic.

## Configure your meta tags

Open the module's meta‑tag settings from the site administration area (as a user
with the appropriate site‑configuration permission) and set the tags you need —
the title, description, and other SEO/social tags that should appear in the page
`<head>`.

## Use tokens for dynamic values

Because Page Metatag depends on the **Token** module, meta‑tag values can include
tokens instead of fixed text. A token is resolved at render time against the page
or entity being viewed — for example, a node's title or summary — so one
configuration produces the right metadata across many pieces of content. Tokens
resolve against data the current request already has access to, so they do not leak
content a visitor could not otherwise see.

When entering a value, look for the **Browse available tokens** helper to pick from
the tokens Drupal exposes rather than typing them from memory.

## Save and check

Save your changes, then load a front‑end page and view its source: the configured
meta tags should appear in the `<head>`, with any tokens replaced by the actual
values for that page.
