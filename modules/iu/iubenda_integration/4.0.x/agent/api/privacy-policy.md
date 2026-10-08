<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Renderer service, token, and page/form integration

## Privacy-policy renderer service

Service **`iubenda_integration.privacy_policy.renderer`** →
`Drupal\iubenda_integration\PrivacyPolicyRenderer` (interface `PrivacyPolicyRendererInterface`).

```php
$renderer = \Drupal::service('iubenda_integration.privacy_policy.renderer');
$link   = $renderer->buildLink('Read our policy');  // GeneratedLink (HTML <a>)
$string = $renderer->buildString();                 // pretext + link + posttext
```

- `buildLink(string $link_text = ''): GeneratedLink` — builds an `<a>` to
  `//www.iubenda.com/privacy-policy/<policy_code>` with classes derived from
  `iubenda_integration_style` (+ `iubenda-embed iubenda-noiframe`, plus `iub-legal-only` /
  `no-brand` per the flags). Falls back to `iubenda_integration_text` when no text is given.
- `buildString(): string` — `trim(pretext) . ' ' . buildLink() . ' ' . trim(posttext)`.

Both read from the `iubenda_integration.settings` config, so a valid
`iubenda_integration_policy_code` must be set for a meaningful link.

## Token

`hook_token_info()` registers **`[site:iubenda_integration]`** ("The Iubenda privacy policy
link"); `hook_tokens()` returns `PrivacyPolicyRenderer::buildString()`. Use it in any
token-enabled text to embed the privacy-policy link.

## Form integration (`hook_form_alter`)

For every form id listed in `iubenda_integration_forms` (newline-separated, via the helper
`iubenda_integration_get_form_ids()`), the module appends a **required** consent element
`iubenda_integration_privacy_policy` of type `iubenda_integration_form_element_type`
(`checkbox`/`radio`), titled by `iubenda_integration_form_element_label`, whose description is the
rendered privacy-policy string. This forces users to accept the policy before submitting those
forms.

## Page attachments & consent locking

- `hook_page_attachments()` — on **non-admin** routes, when `iubenda_integration_policy_code` is
  set, attaches `iubenda_integration/privacy-policy` JS. If `cookie_solution_enable` and a numeric
  `siteId` are set, it builds the `iubendaCookiePolicy` config (GDPR/LGPD/FADP/USPR flags, banner
  buttons/position, `cookiePolicyId` from the policy code) into
  `drupalSettings.iubendaIntegration` and attaches the cookie-solution libraries. If `api_key` is
  set, attaches the consent-solution library. The `iubenda_integration` alter hook lets other
  modules modify the cookie config array before it is attached.
- `IubendaEventSubscriber` (response event, priority -128) runs Iubenda's `\iubendaParser` over
  the page HTML on non-admin, non-XHR responses to lock tagged scripts until consent is given
  (`iubendaParser::consent_given()` / `bot_detected()`).

## Theme

`hook_theme()` defines `block__iubenda_privacy_policy` (template
`block--iubenda-privacy-policy.html.twig`, variables `pre_text` / `link` / `post_text`) used by
the privacy-policy block.
