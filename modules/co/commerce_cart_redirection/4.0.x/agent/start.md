# Commerce Cart Redirection (4.x) — agent index

Redirects a Commerce shopper to **checkout / cart / a custom URL** right after they add a
matching product to the cart. 4.x is a rewrite: behaviour is driven by any number of
`commerce_cart_redirection_rule` **config entities**, each pairing Commerce order-item
**conditions** with a redirect target, optional "Add to cart" button text and an optional
"clear cart first" flag. Enabled rules are evaluated in weight order; the first match wins.
Requires `commerce` + `commerce_product` + `commerce_cart`. No Drush commands, no public
plugin type. Nothing redirects until at least one enabled rule is created.

- **Rules: config entity, form fields, permission, config schema, drush/config** →
  [configure/rules.md](configure/rules.md)
- **How the redirect works (events, matching, URL resolution, token open-redirect guard,
  button relabel, headless header, clear-cart, RedirectUrlEvent for developers)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config entity: `commerce_cart_redirection_rule` (prefix `commerce_cart_redirection.rule.*`);
  config schema in `config/schema/commerce_cart_redirection.schema.yml`. No `config/install`
  defaults — a fresh install has zero rules.
- Admin UI + `configure` route: `entity.commerce_cart_redirection_rule.collection` at
  `/admin/commerce/config/commerce_cart_redirection` (under *Commerce → Configuration → Orders*).
- Permission: `configure commerce_cart_redirection` (`restrict access: true`; it is the entity's
  `admin_permission`, so it also gates add/edit/delete/reorder).
- Redirect is run by `EventSubscriber\CommerceCartRedirectionSubscriber`
  (`CART_ENTITY_ADD` + `KernelEvents::RESPONSE` priority -10), matching via
  `RedirectionRuleMatcher`. Hooks (`form_alter` button relabel, `help`) live in
  `src/Hook/Hooks.php` (`.module` has D10 `#[LegacyHook]` shims only).
- 3.x → 4.x upgrade: `commerce_cart_redirection_post_update_convert_settings_to_rule()`
  converts the legacy `commerce_cart_redirection.settings` object into a "Default" rule.
