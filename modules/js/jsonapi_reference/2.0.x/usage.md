<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Reference provides a field for referencing remote data elements retrieved from an external JSON:API.

---

JSON:API Reference provides a field type that references **remote** data elements — instead of
referencing local entities, the field points at data fetched from an external JSON:API endpoint, so
content can reference/display items that live in another system exposed via JSON:API. It is configured at
`jsonapi_reference.json_api_reference_config_form` and provides its own permissions.

Use it to reference remote records (from a headless backend or another Drupal via JSON:API) in local
content. Security-relevant considerations: the field fetches from a remote endpoint configured by an
administrator — store any credentials for that endpoint as secrets, ensure the endpoint is reached over
TLS, and (since the reference resolves to remote data) treat fetched data as external input, escaping it
on output. The remote endpoint is admin-configured (not end-user-supplied), so this is not an open SSRF
surface, but confirm the configured endpoints are trusted. Configure the JSON:API source.

---

- Reference remote data via JSON:API.
- Point a field at an external JSON:API.
- Display remote records in content.
- Configure at the reference config form.
- Provide its own permissions.
- Store endpoint credentials as secrets.
- Reach the endpoint over TLS.
- Treat fetched data as external input.
- Escape remote data on output.
- Reference another system's data.
- Use with headless backends.
- Confirm configured endpoints are trusted.
- Configure the JSON:API source.
- Fetch remote elements.
- Reference cross-system records.
- Handle credentials securely.
- Resolve to remote data.
- Not an open SSRF (admin-configured).
- Display external items.
- Reference via JSON:API.
