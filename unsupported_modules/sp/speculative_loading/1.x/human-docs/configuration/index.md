# Configuration

The module works immediately after enabling, but you can tune how aggressively it
speculates and which links it applies to.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → Development → Performance → Speculative Loading**.

## Choose a mode: Prefetch or Prerender

Pick how the browser should prepare likely-next pages:

- **Prefetch** — the lightweight option. The browser downloads the page's
  resources ahead of time so the navigation is faster, but the page is not built
  until the visitor actually clicks.
- **Prerender** — the full-page option. The browser renders the whole page in the
  background so it can appear instantly on click. This gives the fastest
  experience but is heavier, and **may affect interactive content**. Because
  prerendering actually loads the page, it can trigger analytics and other side
  effects for pages the visitor never visits — so use it only for **safe,
  idempotent** pages, and be careful with anything that has side effects on a GET
  request.

## Choose an eagerness level

Select how eagerly the browser should act on the rules, to balance performance
against resource and bandwidth use:

- **Conservative** — speculate cautiously (fewest pages prepared).
- **Moderate** — a middle ground.
- **Eager** — speculate aggressively (most pages prepared, most bandwidth used).

## Save

Save the configuration; the module updates the speculation-rules markup on your
pages accordingly.

## Excluding specific links

If certain links should never be prerendered — for example ones that perform an
action or have side effects — you can exclude them:

- Add the **`no-prerender`** CSS class to those links.
- For broader control, developers can exclude URL patterns programmatically via
  the module's hook API, or extend behaviour with its plugin system for custom
  rules.
