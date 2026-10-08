Commerce Tokens adds token-API replacements for Drupal Commerce stores and currencies, plus "current/default" context tokens that resolve the store, order, product or product variation from the current route.

---

Drupal Commerce ships tokens for orders and products, but there is no straightforward token for the store, its currency, or for "the entity currently being viewed on this route". Commerce Tokens fills that gap. Its single file `commerce_tokens.tokens.inc` implements `hook_token_info()` and `hook_tokens()` to (1) define a `commerce_store` token group (`id`, `name`, `mail`, `default_currency`) and a new `commerce_currency` token type (`id`, `code`, `name`, `symbol`, `fraction-digits`), and (2) register six route-aware token types — `current-commerce-store`, `default-commerce-store`, `current-commerce-order`, `current-commerce-product`, `current-commerce-product-variation` — that pull the relevant entity from `\Drupal::routeMatch()` (or the default store resolver) and delegate to the entity's normal token set. It has no routes, forms, permissions, services or config of its own; you simply reference the tokens wherever the Token API is available (emails, messages, meta tags, Views, Rules/ECA, etc.). Depends only on Commerce.

---

- Insert the store name into an order-confirmation email with `[current-commerce-order:store:name]` or `[default-commerce-store:name]`.
- Put the store contact email in a message template using `[default-commerce-store:mail]`.
- Show the current store's default currency code in a template: `[current-commerce-store:default_currency:code]`.
- Render a price's currency symbol via the new `commerce_currency` type, e.g. `[current-commerce-store:default_currency:symbol]`.
- Display the currency's human name with `[default-commerce-store:default_currency:name]`.
- Reference the store ID in an integration payload with `[current-commerce-store:id]`.
- Build a page title or meta tag from the product currently being viewed: `[current-commerce-product:title]`.
- Use the product variation on a variation route: `[current-commerce-product-variation:sku]`.
- Add the current order number to a breadcrumb or heading: `[current-commerce-order:order_number]`.
- Populate a Metatag pattern on product pages using `[current-commerce-product:...]` tokens.
- Drive a Rules/ECA action off the request's order via `[current-commerce-order:...]`.
- Configure a Views global "Text" area that prints default-store details.
- Send a "your store" notice referencing `[default-commerce-store:name]` from any mail the site sends.
- Show the store email as a support address in a footer block token pattern.
- Expose the number of fraction digits for formatting logic with `[...:default_currency:fraction-digits]`.
- Reference the store on a store-scoped admin route through `[current-commerce-store:name]`.
- Fill a PDF invoice template's header with the default store's name and email.
- Use the current product's fields on the product canonical route without writing custom code.
- Provide currency metadata to a downstream API by tokenizing `[...:default_currency:code]`.
- Add store-aware personalization to transactional emails without a custom token module.
- Combine with the core Token module's tree browser to discover the added tokens in any token-enabled field.
