<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Better REST improves the output of Views REST export displays, normalising values into a shape an API consumer can use.

---

A Views REST export produces JSON built from the view's rendered fields, which means the output carries whatever the field formatters produced: a date arrives as the string the formatter chose, a link arrives as rendered markup, an entity reference arrives as a label. That is fine for a feed a human reads and wrong for an API a client parses, which wants an ISO date, a URL and an identifier. Improving the normalisation is a real need, and it is why a whole family of modules exists between Views and a usable API. **This release cannot be used on Drupal 11.4.** `UrlNormalizer::normalize()` declares a return type of `array|string|int|float|bool|\ArrayObject|NULL`, widening the `: array` that core's `ComplexDataNormalizer::normalize()` declares — which PHP rejects as an incompatible override, fataling the moment the class is loaded. Verified on a clean install: instantiating the class produces `Declaration of Drupal\views_better_rest\Normalizer\UrlNormalizer::normalize(…) must be compatible with Drupal\serialization\Normalizer\ComplexDataNormalizer::normalize(…): array`, and because the normalizer is a tagged service, **every request that builds the `serializer` service dies** — which on this install meant an unrelated file download returned a PHP fatal instead of a file. The cause is core narrowing the parent's signature after the module was written, so the fix is upstream and small; until it lands, treat the module as non-functional on current core rather than merely imperfect.

---

- Improve a Views REST export's JSON.
- Return ISO dates from a view.
- Output URLs rather than rendered links.
- Feed a JavaScript client from Views.
- Produce parseable API output.
- Normalise entity references in a feed.
- Build a simple API from a view.
- Improve a mobile app's data feed.
- Return typed values instead of markup.
- Support a decoupled listing.
- Export view results as clean JSON.
- Provide a data endpoint from Views.
- Improve a REST export display.
- Serve structured data to a partner.
- Normalise Url objects in output.
- Support an integration reading a view.
- Produce machine-readable view output.
- Replace rendered markup in a feed.
