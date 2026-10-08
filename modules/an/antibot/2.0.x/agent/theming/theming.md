# Theming

Theme hook `antibot_no_js` (registered in `antibot_theme()`), template
`templates/antibot-no-js.html.twig`. Rendered inside protected forms to warn visitors who
have JavaScript disabled (wrapped in `<noscript>`).

Available variables:
- `message` — the warning text shown to non-JS users.

Override by copying the template into your theme and adjusting markup/classes
(`antibot-no-js`, `antibot-message`, `antibot-message-warning`).
