# Random String Generator — manual setup guide

**Random String Generator** (`rsg`) is a small developer utility for producing
random strings, words, and numbers on demand. It doesn't add an admin page or a
content type — it gives developers three ways to generate random values: a PHP
**service** you can call from custom code, a set of **routes** that return a random
value in the response, and a set of **JavaScript helpers** you can call in the
browser.

Typical uses are generating display codes, sample or placeholder data, temporary
identifiers, or simple one‑off keys. It's meant as a convenience for building
things, not as a security primitive — see the note below before you reach for it to
mint passwords or tokens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it exposes a service, routes,
and JavaScript helpers instead, described in "How to use it" below.

## How to use it

Once enabled, the module gives you three entry points.

**A PHP service** — call `random.string.generator` from your own code:

```php
\Drupal::service('random.string.generator')->string(10);
\Drupal::service('random.string.generator')->word(10);
\Drupal::service('random.string.generator')->number(10);
```

**Routes** — visit a URL to get a generated value, where the number is the length:

```
/random/string/10
/random/word/10
/random/word-small/10
/random/word-small-numeric/10
/random/word-capital/10
/random/word-capital-numeric/10
/random/name/10/username
/random/number/10
/random/generate/10/pattern
```

**JavaScript helpers** — generate values in the browser:

```js
Drupal.generateString(10);
Drupal.generateWord(10);
Drupal.generateWordSmall(10);
Drupal.generateWordSmallNumeric(10);
Drupal.generateWordCapital(10);
Drupal.generateWordCapitalNumeric(10);
Drupal.generateName(10, 'username');
Drupal.generateNumber(10);
Drupal.generateRandom(10, 'patterns');
```

> **Security note:** this is a general‑purpose randomness helper. For anything
> security‑sensitive — passwords, tokens, secrets — make sure you use a
> cryptographically secure source and enough length and character variety. Ordinary
> randomness is fine for display codes, sample data, and non‑secret identifiers.
