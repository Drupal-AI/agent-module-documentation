<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrregClient usage

```php
/** @var \Drupal\brreg_api\BrregClient $brreg */
$brreg = \Drupal::service('brreg_api.client');

$company     = $brreg->getCompany('123 456 789');      // GET enheter/123456789
$subunits    = $brreg->getSubdivisions('123456789');   // GET underenheter?overordnetEnhet=...
$candidates  = $brreg->getByName('Equinor');           // GET enheter?navn=Equinor
```

- Input numbers are cleaned with `preg_replace('/[^0-9]/','',$number)`.
- Returns the decoded JSON (`stdClass`); throws `\Exception` on non-200 or empty body.
- Sends `User-Agent: Drupal Brreg API client (...)`. No API key required.