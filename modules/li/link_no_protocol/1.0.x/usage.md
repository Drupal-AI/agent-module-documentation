Link No Protocol provides a core Link field widget that lets editors type a URL without the `http(s)://` prefix, inferring `https://www.` when the entered host resolves.

---

The module adds one field widget, `link_no_protocol` ("Link No Protocol"), for core `link` fields, subclassing core's `LinkWidget`. It changes the URI input from an HTML5 `url` type to a plain `textfield` (so a browser will not reject a protocol-less value) and overrides `getUserEnteredStringAsUri()`: when the entered string does not start with `http`/`https`, it tentatively prepends `https://www.` and, if the resulting host resolves via `gethostbyname()`/`filter_var(... FILTER_VALIDATE_IP)`, uses that as the URI before handing off to the parent widget's normal processing. It also adds a widget setting `remove_protocol_default_value` (default TRUE) that strips `http://`/`https://` from a field's configured default value so the editor sees a clean, protocol-less default. Choose the widget per field on *Manage form display*. No global config, permissions, routes, config schema, services, or Drush — everything is the widget plugin plus a `hook_help` implementation. Depends only on core `link`.

---

- Let content editors enter `example.com` instead of `https://example.com` in a Link field.
- Select the "Link No Protocol" widget on any Link field via Manage form display.
- Avoid the browser's HTML5 URL-input rejection of protocol-less values.
- Auto-prefix `https://www.` when the entered host resolves to a valid IP.
- Present a cleaner default value by stripping the protocol from the field default.
- Toggle the protocol-stripping of default values per field (`remove_protocol_default_value`).
- Reduce editor friction on marketing/link-heavy content types.
- Keep using all standard core Link field storage and validation (parent widget still runs).
- Provide a familiar "just type the domain" UX like search bars and address fields.
- Migrate an existing Link field to the protocol-less widget without changing stored data format.
- Show a settings summary noting protocol-less entry is allowed.
- Combine with link title settings inherited from the core Link widget.
- Use on both required and optional Link fields.
- Apply to multi-value Link fields (per-delta widget).
- Support entering internal or external URLs (parent widget resolves both).
- Standardize outbound links to `https` when editors omit the scheme.
- Reduce malformed-URL support tickets from non-technical editors.
- Pair with the Markdown module so the module's README renders on its help page.
- Keep the widget behavior scoped to specific content types by only enabling it there.
- Fall back to the entered string unchanged when the inferred host does not resolve.
