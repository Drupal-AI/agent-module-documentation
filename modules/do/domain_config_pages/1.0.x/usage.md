<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Config Pages adds a domain context to Config Pages, so a settings page can hold different values per domain on a Domain-module multi-site.

---

`config_pages` fills a real gap: it gives site builders a fielded settings form — a contact address, a footer notice, a set of social links, an announcement banner — without writing a settings form class, and stores the values as entities editors can change. On a Domain multi-site the obvious next question is per-domain values, since the whole point of Domain is one installation serving several sites, and a footer address that is identical across all of them defeats the arrangement. This supplies the context plugin that makes a config page domain-aware, requiring `config_pages` and `domain`, version **1.0.1** on core `^10 || ^11`. Two things worth attaching. **A per-domain value is a per-domain cache context**, so anything rendering these values must vary by domain or one site will be served another's footer — and because Domain sites share an installation, that failure is a cross-site content leak rather than a cosmetic error, which is why it is worth checking rather than assuming. And **the fallback rule is the design decision**: what a domain with no value of its own gets — the default domain's value, an empty field, or the field's own default — determines whether adding a new domain is safe by default or silently publishes another domain's content. Establish it before creating the second domain, because that is when it is cheap to change.

---

- Set a footer address per domain.
- Give each domain its own contact details.
- Vary an announcement banner by site.
- Configure social links per domain.
- Support a multi-brand installation.
- Set per-domain analytics identifiers.
- Vary a legal notice by market.
- Configure a per-domain phone number.
- Support country-specific settings.
- Give a client site its own values.
- Vary a homepage message per domain.
- Configure per-domain opening hours.
- Support a white-label deployment.
- Set per-domain support email.
- Vary a call-to-action by site.
- Configure per-domain branding text.
- Support a devolved multi-site.
- Set editorial settings per domain.
