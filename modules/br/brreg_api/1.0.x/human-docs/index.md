# Brreg API — manual setup guide

**Brreg API** (`brreg_api`) is a small developer‑oriented service that queries
Norway's Brønnøysund Register Centre (Enhetsregisteret) to look up company and
organization data by number or by name. It is a building block for other code, not
an end‑user feature: it has no admin pages, no forms, no permissions, and no
settings. You enable it and then call its service from your own module or custom
code.

The service — `brreg_api.client` (the `BrregClient` class) — wraps an HTTP client
and calls the public Brreg API at `https://data.brreg.no/enhetsregisteret/api` over
HTTPS. It offers three methods:

- `getCompany($number)` — look up a company by organization number.
- `getSubdivisions($number)` — fetch a company's subdivisions (underenheter).
- `getByName($name)` — search companies by name.

Organization numbers are cleaned automatically (non‑digits are stripped, so
`123 456 789` and `123456789` both work), a descriptive User‑Agent is sent, and the
decoded JSON is returned; a non‑200 or empty response throws an exception. Typical
uses include enriching a form or CRM entity from an org number, validating that an
org number exists, building a name autocomplete, or cross‑checking supplier numbers.

Because the Brreg API is **public and needs no authentication**, there are no
credentials to store. Requests go out over HTTPS with default TLS verification, and
the module exposes no inbound routes of its own — so there is nothing to secure or
configure on the Drupal side. It supports Drupal 8 through 11.

This guide is written for a **human** (in this case, a developer wiring the service
into their own code). For terse, token‑cheap references — including the exact method
signatures — read the sibling [`agent/`](../agent/start.md) docs, especially
[`agent/api/client.md`](../agent/api/client.md).

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.

## Where it lives in the admin menu

Nowhere. Brreg API adds no admin pages, permissions, or settings — it is a service
you call from code, not a screen you configure.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. From your own module or custom code, load the service and call one of its
   methods:

   ```php
   /** @var \Drupal\brreg_api\BrregClient $brreg */
   $brreg = \Drupal::service('brreg_api.client');

   $company    = $brreg->getCompany('123 456 789');   // by org number
   $subunits   = $brreg->getSubdivisions('123456789'); // subdivisions
   $candidates = $brreg->getByName('Equinor');         // by name
   ```

3. Handle the returned decoded JSON, and catch the exception thrown on a non‑200 or
   empty response. No API key is required.
