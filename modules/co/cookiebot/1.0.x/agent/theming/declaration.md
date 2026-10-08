# Cookie declaration, block & marketing placeholder

The **cookie declaration** is Cookiebot's auto-generated table of the cookies your site sets.
Cookiebot serves it from `https://consent.cookiebot.com/<CBID>/cd.js`. This module renders it two ways.

## Theme hooks (`cookiebot_theme()`)

- `cookiebot_declaration` — variables `cookiebot_src`, `cookiebot_culture`. Template
  `templates/cookiebot-declaration.html.twig`. Emits the `cd.js` script for the declaration.
- `cookiebot_blocked_element_placeholder` — variables `content`, `attributes`, `inner_attributes`.
  Template `templates/cookiebot-blocked-element-placeholder.html.twig`. Wraps the placeholder
  message shown where a marketing element is blocked pre-consent.

## On a node

Set `cookiebot_show_declaration: true` and `cookiebot_show_declaration_node: "<nid>"`.
`hook_node_view_alter()` then appends the `#theme => 'cookiebot_declaration'` render array to that
node's build (only when the current node id matches). Culture is passed only if
`cookiebot_drupal_culture` is on.

## Cookie declaration block

Block plugin id **`cookie_declaration_block`** (`admin_label` "Cookie declaration block"), in
`src/Plugin/Block/CookieDeclarationBlock.php`. Place it in any region (e.g. via
`drush` or Block layout). It returns nothing while `cookiebot_cbid` is empty; otherwise it renders
the `cookiebot_declaration` theme with `cd.js`. Cache tag: `cookiebot:cbid`.

## Marketing placeholder

When `message_placeholder_cookieconsent_optout_marketing_show` is on, the rendered
`message_placeholder_cookieconsent_optout_marketing` text is passed to JS via
`drupalSettings.cookiebot` and shown under elements Cookiebot blocks. Supports dynamic tokens
`!cookiebot_renew` (→ `javascript:Cookiebot.renew()`) and `!cookiebot_from_src_url` (the blocked
iframe's `data-src`). The `/cookiebot-renew` menu link gets a `cookiebot-renew` class
(`hook_preprocess_menu`) so it reopens the consent dialog.
