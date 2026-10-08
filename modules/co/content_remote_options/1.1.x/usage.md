<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Remote Options provides an **options (select) field whose choices are fetched from a remote endpoint**
over HTTP/REST, instead of a hard-coded allowed-values list. The field storage defines an endpoint and JSON
key/value mapping, and the widget renders the fetched options as a select.

Use it when a field's option list lives in an external service (a catalogue, a taxonomy service, another site)
and should stay in sync without manual re-entry. Responses are cached per entity/bundle/field/language.
---
- No hard dependencies beyond core; enable with `ddev drush en content_remote_options`.
- Add the field to a bundle; in **field settings** configure the **endpoint** URL, headers, and the JSON
  `data_key`/`data_value` mapping.
- A relative endpoint starting with `/` is resolved against the current site host.
- The widget fetches options via `\Drupal::httpClient()->get()` (Guzzle) and builds the select list.
- Results are cached (`content_remote_options:{entity}:{bundle}:{field}:{langcode}`) to avoid per-request calls.
- The endpoint is **field configuration** set by a site builder — not request-supplied — so it is not an
  open SSRF proxy.
---
- Populate a select field from an external REST endpoint.
- Keep option lists in sync with an authoritative external source.
- Map JSON response fields to option key/value via `data_key`/`data_value`.
- Send custom headers (e.g. auth) with the request.
- Use a relative path resolved against the site host.
- Cache fetched options per entity/bundle/field/language.
- Alter options programmatically via `hook_content_remote_options__options_alter()`.
- Avoid manually maintaining allowed-values lists.
- Support associative or flat JSON option shapes.
- Reuse across multiple fields/bundles.
- Fall back to empty options on a failed/invalid response.
- Integrate with any JSON-returning service.
- Support D8–D10 sites.
- Configure entirely through the field UI.
- Keep the endpoint under admin control (not user input).
- Uses Guzzle defaults (TLS verification on) — no `verify => false`.
