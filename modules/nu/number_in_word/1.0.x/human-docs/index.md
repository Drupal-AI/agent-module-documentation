# Number In Word — manual setup guide

**Number In Word** (`number_in_word`) converts a number into its spelled‑out
word representation — for example, `9000` becomes "nine thousand" and `123`
becomes "one hundred twenty‑three". It exposes this as a **service** you call from
your own code or templates, rather than a formatter you configure in the UI.

The problem it solves is a small but recurring one: displaying amounts in words.
That is useful on invoices and receipts, for accessibility (screen readers reading
a spelled‑out figure), and in any content where the written‑out number matters
alongside the digits. Because it is delivered as a service, it slots into custom
modules, preprocess hooks, or Twig where you need a number turned into text.

There is nothing to configure and no dependencies beyond Drupal core. Enable the
module and the service becomes available; it works across Drupal 9, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — this module provides a service, not a
settings form. How to call it is described in "How to use it" below.

## Where it lives in the admin menu

Number In Word adds no admin page. It provides a service you invoke from code:

```php
\Drupal::service('number_in_word.number_in_word')->number_in_word(9000);
```

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. From a custom module, controller, or preprocess function, call the service and
   pass it the number you want spelled out:

   ```php
   $words = \Drupal::service('number_in_word.number_in_word')->number_in_word(9000);
   // $words === "nine thousand"
   ```

   In an object‑oriented service, prefer injecting `number_in_word.number_in_word`
   rather than using the static `\Drupal::service()` call.
3. Use the returned string wherever you need it — rendered in a Twig template, a
   field, an invoice total, or accessible output.
