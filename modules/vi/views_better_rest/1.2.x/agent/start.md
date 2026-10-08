<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Better REST (views_better_rest) — agent index

Improves **Views REST export** output by normalising values for API consumers. Version **1.2.0**.
Core requirement `^10 || ^11`.

**This release cannot be used on Drupal 11.4 — verified live.**
`UrlNormalizer::normalize()` declares
`: array|string|int|float|bool|\ArrayObject|NULL`, **widening** the `: array` that core's
`ComplexDataNormalizer::normalize()` declares. PHP rejects the incompatible override and **fatals on
class load**:

```
Declaration of Drupal\views_better_rest\Normalizer\UrlNormalizer::normalize(…)
must be compatible with Drupal\serialization\Normalizer\ComplexDataNormalizer::normalize(…): array
```

**The normalizer is a tagged service**, so **every request that builds the `serializer` service
dies** — on this install an unrelated file download returned a PHP fatal instead of a file. The site
appears healthy until something touches serialization.

Cause: core **narrowed the parent's signature** after the module was written. The fix is upstream
and small. Until it lands, treat this as **non-functional on current core**, not merely imperfect.

**The underlying need is real:** a Views REST export emits whatever the field *formatters* produced
— a date as a formatted string, a link as rendered markup, a reference as a label — where an API
client wants an ISO date, a URL and an identifier.
