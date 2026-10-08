# Configuration

Rosetta Translation is configured in two places: the module's settings form, and
one small addition to a Twig template. Both are needed before translation works.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → Regional and language → Rosetta Translation**, or
   navigate directly to `/admin/config/regional/rosetta-translation`.

## The settings, field by field

- **Server endpoint URL** — the address of *your* Rosetta backend server. This is
  where translation requests are sent, so point it only at a server you host and
  trust. Content that gets translated leaves Drupal for this endpoint, so confirm
  that egress is acceptable for your content, and prefer an `https://` URL so the
  traffic is encrypted in transit.
- **Drop‑down element id** — the HTML `id` of the language selector element on your
  page that should drive translation. This must match the id you add to your Twig
  template (see below).
- **Default site language** — the language your content is written in, so the
  widget knows what it is translating *from*.
- **Preferred / supported languages** — the list of languages you want to offer
  visitors in the drop‑down.
- **Rosetta project version** — the version of the `au5ton/rosetta` client the
  module retrieves and uses.
- **Include / exclude rules** — control which parts of the page are translated by
  targeting element classes or tags, so you can keep specific content (code
  samples, brand names, and so on) untranslated.
- **Lazy loading** — load translations on demand for faster initial page loads.

Fill these in and save the form.

## Add the drop‑down element to a Twig template

The settings form only tells the widget which element id to watch — you still have
to put that element on the page. Edit one of your theme's Twig templates
(commonly the header) and add a drop‑down element whose `id` exactly matches the
**Drop‑down element id** you entered above.

Add it **only once per page** — the widget expects a single matching element to
work correctly. When a visitor chooses a different language from that drop‑down,
all applicable content on the page is translated.

## A note on cost and caching

Because you run the backend, you control the bill. The backend can cache
translations so repeated requests don't re‑translate the same content, and the
module's lazy loading keeps pages fast. Tune both on your server and in the
include/exclude rules above to keep translation volume (and cost) in check.
