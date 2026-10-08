<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Brreg API is a thin developer service that queries Norway's Brønnøysund Register Centre (Enhetsregisteret) to look up company/organization data by number or name.

---

The `brreg_api.client` service (`BrregClient`) wraps Guzzle and calls `https://data.brreg.no/enhetsregisteret/api` over HTTPS. It exposes `getCompany($number)` (GET `enheter/{number}`), `getSubdivisions($number)` (GET `underenheter?overordnetEnhet={number}`) and `getByName($name)` (GET `enheter?navn={name}`). Organization numbers are normalised by stripping non-digits, a descriptive User-Agent is sent, non-200 responses throw, and the JSON body is decoded and returned. There is no UI, routes, permissions, or config — it is meant to be consumed from your own code.

The public Brreg API needs no authentication, so there are no credentials to store; requests go out over HTTPS with default TLS verification. No inbound surface.

---
- Look up a Norwegian company by organization number
- Search companies by name
- Fetch a company's subdivisions (underenheter)
- Normalise a spaced org number (123 456 789) automatically
- Enrich a form with registry data from an org number
- Validate that an org number exists in the registry
- Pull a company's official name and address
- Build an autocomplete against Brreg company names
- Cache registry lookups in your own code
- Populate a CRM/company entity from Brreg
- Cross-check supplier org numbers
- Integrate KYC/verification flows
- Retrieve parent/child company relationships
- Handle the public API without storing credentials
- Send a descriptive User-Agent on each request
- Fail fast on non-200 or empty registry responses
- Decode registry JSON into ready-to-use objects
- Feed org data into a Drupal entity or field
- Support both spaced and unspaced org numbers