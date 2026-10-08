Captures UTM marks into visitor cookies and attaches them to leads exported to Bitrix24.

---

`b24_utm` is a tiny, configuration-free submodule that adds marketing attribution to the base `b24`
integration. On every page it captures the `utm_source`, `utm_medium`, `utm_campaign`, `utm_content`
and `utm_term` query parameters into Drupal visitor cookies. Then, whenever the base module exports a
lead, it implements `hook_b24_push_alter()` to add those stored UTM marks (upper-cased) to the lead's
fields before it is sent to Bitrix24, so leads created from any source (contact form, webform,
commerce order) carry their originating campaign data.

---

- Automatically capture UTM query parameters from incoming page requests.
- Persist captured UTM marks across the visitor's session via Drupal visitor cookies.
- Attach `utm_source` to exported Bitrix24 leads.
- Attach `utm_medium` to exported Bitrix24 leads.
- Attach `utm_campaign` to exported Bitrix24 leads.
- Attach `utm_content` to exported Bitrix24 leads.
- Attach `utm_term` to exported Bitrix24 leads.
- Add campaign attribution to leads from any b24 source module (contact, webform, commerce) with no code.
- Work with zero configuration once enabled.
- Track lead sources in Bitrix24 for marketing reporting.
