<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Prepopulate pre-populates a Webform with external data referenced by a hash in the URL, so the actual values are stored server-side and not disclosed in the link.

---

Webform Prepopulate pre-populates a Webform from an external data source without putting the data in
the URL. Instead of query parameters carrying values (which would leak them in links, logs and
referrers), the module stores the prepopulate values server-side and references them by a hash in the
URL; when the form is opened with that hash, it loads the stored values. It adds a per-session access
limit (default `MAX_HASH_ACCESS = 5`) on how many times a hash may be used, a
`disable_hash_access_limit` per-webform setting, and a `bypass webform prepopulate hash access limit`
permission. It depends on Webform and Webform UI.

Use it when links must pre-fill a form (mail-merge campaigns, personalised invitations) but the
pre-filled data is sensitive and should not appear in the URL. The security intent is exactly to keep
PII out of URLs; when adopting, keep the access limit enabled (it bounds hash guessing/abuse) and
treat the hash as a capability — anyone with the hash can load the stored values, so distribute links
carefully. It provides permissions for administering the feature and bypassing the access limit.

---

- Pre-populate a Webform from external data.
- Reference prepopulate data by a hash.
- Keep pre-filled values out of the URL.
- Store prepopulate values server-side.
- Avoid leaking PII in links/logs/referrers.
- Limit hash access per session (default 5).
- Configure disable_hash_access_limit per webform.
- Bypass the limit via permission.
- Depend on Webform and Webform UI.
- Pre-fill forms for mail-merge campaigns.
- Personalise invitation links.
- Treat the hash as a capability.
- Keep the access limit enabled.
- Distribute prepopulate links carefully.
- Load stored values on form open.
- Bound hash guessing/abuse.
- Administer the feature via permissions.
- Protect sensitive pre-fill data.
- Use for personalised forms.
- Not disclose data in the URL.
