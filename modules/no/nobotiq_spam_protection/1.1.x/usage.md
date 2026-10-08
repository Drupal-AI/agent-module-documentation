<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NoBotIQ Spam Protection provides spam protection via the nobotiq.com API.

---

NoBotIQ Spam Protection **provides spam protection via the NoBotIQ API** — checking form submissions/content
against the nobotiq.com anti-spam service and blocking/flagging spam, with Views Bulk Operations support. It stores
credentials via the **Key** module and depends on Views and Views Bulk Operations, and provides its own
permissions.

Use it to add NoBotIQ spam filtering. It is a spam-control/integration feature. Security/data handling: it **sends
submission data to the NoBotIQ API** (egress — may include submitted content/IP; disclose per privacy policy) and
authenticates with an **API key stored via the Key module** (secret handling, a positive). Serve over HTTPS, and
ensure it fails safely (decide fail-open vs fail-closed for your risk). It has no access-control role beyond its
permission. Configure the NoBotIQ API key (via Key).

---

- Provide NoBotIQ spam protection.
- Check submissions against the API.
- Block/flag spam.
- Store credentials via the Key module.
- Provide its own permissions.
- Serve spam control.
- Send submission data to NoBotIQ (egress; content/IP - disclose).
- Store the API key via Key (positive).
- Decide fail-open vs fail-closed + HTTPS.
- Have no access-control role beyond permission.
- Configure the NoBotIQ API key via Key.
- Handle spam protection.
- Check spam.
- Configure the client.
- Block spam.
- Handle the integration.
- Filter submissions.
- Flag spam.
- Secure the key via Key.
- Provide NoBotIQ spam protection.
