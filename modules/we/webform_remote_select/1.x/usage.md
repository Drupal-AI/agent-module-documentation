Adds a Webform element whose select options are fetched at render time from a REST/JSON endpoint you configure on the element.

---

Webform Remote Select ships a single Webform element, **Remote select element** (`webform_remote_select_element`), that behaves like a normal single/multiple select but populates its `#options` by making a server-side HTTP GET to an endpoint URL configured on the element in the Webform builder. The response body is decoded as JSON and mapped into option value/label pairs, optionally drilling into a nested response path and reading a chosen key/value from each item. The endpoint URL supports Drupal tokens, custom request headers can be supplied as JSON, the fetched response can be cached permanently, and the widget can optionally be upgraded to a Select2 autocomplete. Because it extends the core/Webform select handling, it also supports required-state, empty option, multiple-value limits, and unique-value / non-empty validation for multiple selects. The module has no admin settings page, no permissions, and no routes of its own; all behaviour is configured per element inside each Webform.

---

- Populate a country, state/region, or city select from an external geolocation or reference REST API instead of hardcoding option lists.
- Drive a product or SKU picker from a PIM / e-commerce catalog endpoint that returns JSON.
- Build a department, team, or cost-center select sourced live from an internal HR/directory service.
- Offer a list of events, sessions, or appointment slots pulled from a scheduling API at form-render time.
- Present a taxonomy/category select fed by a headless CMS or a separate content repository over REST.
- Populate a "select your store/branch" element from a store-locator service.
- Read options from an endpoint that returns a flat JSON array of strings (each string becomes both option value and label).
- Read options from a JSON array of objects, choosing which field is the option key and which is the label via *Response items key* / *Response items value*.
- Read options from an associative JSON object, mapping its entries into select options.
- Drill into a nested response, e.g. `contentResponse.data.items`, using the dotted *Response data key* path before mapping items.
- Send custom request headers (for example `{'Content-Type': 'application/json'}`) to the endpoint via the *Headers* field.
- Interpolate tokens into the endpoint URL (webform and webform-submission tokens) to vary the request per form or context.
- Cache the endpoint response permanently (keyed by the resolved URL) to avoid re-fetching on every render for slow or rate-limited APIs.
- Turn the element into a Select2-enhanced searchable dropdown for long option lists.
- Show a configurable empty/placeholder option ("- Select -" / "- None -" or a custom label).
- Allow a multiple-value remote select and cap it to a maximum number of selections.
- Optionally allow the same value to be chosen more than once in a multiple remote select (or forbid duplicates, the default).
- Enforce that a multiple remote select contains no empty in-between values.
- Reuse the same remote source across several forms by copying the element configuration.
- Localize/translate the element's endpoint, headers, keys, and empty-option label via Webform's translatable element properties.
- Display the submitted value's human label (resolved back through the remote options) in submission views and emails.
