# How the redirect works (mechanism)

Core pieces: `EventSubscriber\CommerceCartRedirectionSubscriber` (the redirect),
`RedirectionRuleMatcher` (picks the rule), `Entity\RedirectionRule` (rule + condition
evaluation), `Hook\Hooks` (button relabel + help). No controllers, no routing.yml, no public
plugin type — rules are config entities.

## Rule matching (`RedirectionRuleMatcher::getMatchingRule`)

Service `commerce_cart_redirection.rule_matcher`. Loads all **enabled** rules
(`loadByProperties(['status' => TRUE])`), sorts them by weight (`RedirectionRule::sort`), caches
the sorted list per request (product listings render many add-to-cart forms), and returns the
**first** rule whose `applies($order_item)` is TRUE. `RedirectionRule::postSave`/`postDelete`
reset this cache.

`RedirectionRule::applies()`:
- No conditions → TRUE (matches everything).
- Instantiates condition plugins lazily; a **missing** plugin → the rule `applies()` returns
  FALSE (fail closed, logged). Only `commerce_order_item` conditions are evaluated; if all
  configured conditions are non-order-item, it also fails closed.
- Evaluates the kept conditions in a `ConditionGroup` with the rule's `AND`/`OR` operator.

## Two-phase redirect flow

Subscriber listens to two events (`getSubscribedEvents`):

1. **`CartEvents::CART_ENTITY_ADD` → `tryRedirect()`** — fires when an item is added to a cart.
   Returns early if there is no current request (drush/queue/migration adds). Gets the matching
   rule; if none, returns. If the rule's `clear_cart` is on, calls `clearCartAndAdd()`. Resolves
   the redirect URL (`getRedirectionUrl()`), dispatches the alterable `RedirectUrlEvent`, and —
   unless a subscriber blanked the URL — stashes it on the request:
   `$request->attributes->set('commerce_cart_redirection_url', $url)`. It does **not** redirect here.
2. **`KernelEvents::RESPONSE` (priority -10) → `checkRedirectIssued()`** — on response, if that
   attribute is set, issues the redirect. Priority -10 runs after core's
   `RedirectResponseSubscriber` so the rule's redirect intentionally wins over a `?destination`.

Response form handling in `checkRedirectIssued()`:
- **Non-HTML request** (`getRequestFormat() !== 'html'`, e.g. JSON:API / REST decoupled add):
  does **not** redirect — keeps the serialized response and advertises the URL in the
  `X-Commerce-Cart-Redirect` response header, so a headless front end can decide to navigate.
- **Ajax add-to-cart** (`isXmlHttpRequest()` or `_wrapper_format=drupal_ajax`): returns an
  `AjaxResponse` with a `RedirectCommand` (a plain redirect would be followed transparently by
  the Ajax framework and do nothing visible).
- **Otherwise:** `new RedirectResponse($url)`.

## Target URL resolution (`getRedirectionUrl()`)

- `cart` → `Url::fromRoute('commerce_cart.page')`.
- `checkout` (and the default/fallback) → `getCheckoutUrl()`: `commerce_checkout.form` for the
  current cart order **if that route exists**, otherwise `<front>` (the hard dependency on
  commerce_checkout was removed for compatibility with alternative/headless checkouts).
- `other` → the custom URL after token replacement and validation (below); if it fails
  validation, logs a warning and falls back to `getCheckoutUrl()`.

### Custom URL tokens + open-redirect handling

For `other`, the configured `redirect_custom_url` is token-replaced with the item's token data
(`commerce_order_item`, the purchased entity's type, and `commerce_product` for variations),
`['clear' => TRUE]`. Validation after replacement:

- External result → must pass `UrlHelper::isValid(..., TRUE)`; otherwise must start with `/`.
- Open-redirect guard: when the URL was **not** external before replacement but **became**
  external through tokens (tokens like `[current-page:query:*]` resolve from the incoming
  request), it is only accepted if `UrlHelper::externalIsLocal()` confirms it points back at
  this site. This keeps the documented `[current-page:url]` case working while blocking a
  crafted link from turning a local URL into an off-site one. Per the module's own docs, a URL
  that is already external before token replacement is treated as the admin's deliberate target
  and is not restricted this way.
- Any failure logs a warning (channel `commerce_cart_redirection`) and falls back to checkout.

## Clear cart (`clearCartAndAdd()`)

Removes every order item except the one being added, via
`cartManager->removeOrderItem($cart, $order_item, FALSE)` (so other modules, e.g. stock, are
notified), sets the current item quantity to the request quantity, and clears adjustments
(`$cart->setAdjustments([])`) since they are recalculated on the following cart save.

## Button relabel (`Hook\Hooks::formAlter`, `#[Hook('form_alter')]`)

Acts only on add-to-cart forms (those with a `product` in form state and an `OrderItem` entity
form). Merges the rule list cache tags onto the form, finds the matching rule, and if it has
non-empty `button_text`, token-replaces it (`replacePlain`, `['clear' => TRUE]`) and — when the
result is non-empty — swaps the submit label in a `#post_render` callback
(`modifyAtcButtonText`, a `TrustedCallbackInterface` method) so the button keeps the CSS classes
derived from its original text. The replacement is `Html::escape()`d. Purely cosmetic; the real
redirect is done by the subscriber. The `.module` file holds only D10 `#[LegacyHook]` shims that
delegate to this class.

## Developer extension point: `RedirectUrlEvent`

`Event\RedirectUrlEvent` is dispatched (by class name) after the URL is resolved but before the
redirect is issued. Subscribe to it to:
- `setUrl($url)` — change the redirect target, or
- `setUrl('')` — cancel the redirect entirely, keeping default add-to-cart behaviour.
It carries the matched rule (`getRule()`) and the original `CartEntityAddEvent` (`getCartEvent()`).
