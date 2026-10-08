<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filter HTML Plus changes core's HTML filter to allow global whitelisting of HTML attributes.

---

Filter HTML Plus extends **core's "Limit allowed HTML tags" filter** to support **global attribute
whitelisting** — a `<*>` syntax lets you allow an attribute (e.g. `class`, `data-*`) on **all** elements at
once, instead of listing it per tag. It depends on core Filter.

Use it to simplify allowing common attributes site-wide in a text format. It is a text-format/filter feature
and it **works within core's filter_html sanitization** (core still strips disallowed tags/attributes). Its
**security depends on what you whitelist**: never globally allow dangerous attributes — especially event
handlers (`on*`) or `style` — because widening the allow-list widens the XSS surface; keep the global whitelist
to safe presentational attributes. It has no access-control role. Configure the text format's allowed HTML.

---

- Globally whitelist HTML attributes.
- Use a <*> syntax for all elements.
- Allow class/data-* site-wide.
- Extend core's Limit allowed HTML filter.
- Depend on core Filter.
- Simplify per-format attribute config.
- Work within core's filter_html sanitization.
- NEVER globally allow on* or style.
- Keep the whitelist to safe attributes.
- Have no access-control role.
- Configure the allowed HTML.
- Handle attribute whitelisting.
- Whitelist attributes.
- Configure the filter.
- Allow attributes.
- Handle the filter.
- Extend allowed HTML.
- Configure formats.
- Restrict the whitelist.
- Provide global attribute allow.
