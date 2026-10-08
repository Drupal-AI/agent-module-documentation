<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Google Analytics lets each domain on a Domain-module multi-site have its own Google Analytics configuration.

---

The Domain module runs several sites from one installation, and analytics is one of the places where "several sites" and "one installation" collide most obviously. A single measurement id across a group of brand sites mixes their traffic into one property, so nobody can report on a brand; a shared property with hostname filtering can be made to work and requires everyone reporting to remember the filter; and a client site whose analytics belongs to the client cannot share a property with the agency's other clients at all. Per-domain configuration is what makes the arrangement match the organisational reality — each site's data goes where that site's owner expects. Version **3.0.2** requiring `domain`, on `^9 || ^10 || ^11`; note the project is `domain_google_analytics` while the module it ships is **`multidomain_google_analytics`**, so `drush en domain_google_analytics` fails, and it also requires the `domain` module to be present, which is not pulled in automatically. Two things worth attaching. **Per-domain tracking is a per-domain cache context**, so a page cached for one domain must not be served to another with the wrong measurement id embedded — which on a Domain site is a general hazard rather than a specific one, and is worth verifying because a wrong id sends a site's traffic to somebody else's property. And **consent is per-domain too**: the domains may be in different jurisdictions with different requirements, and a consent banner configured once at the installation level is answering a question that has more than one right answer.

---

- Give each domain its own analytics property.
- Separate brand sites' traffic.
- Send a client site's data to the client.
- Configure per-domain measurement ids.
- Avoid mixing multi-site traffic.
- Report on one brand's performance.
- Support an agency's client sites.
- Configure analytics per country domain.
- Separate staging domain tracking.
- Support a multi-brand installation.
- Give a partner site its own property.
- Configure regional analytics separately.
- Avoid hostname filtering in reports.
- Support per-domain measurement plans.
- Track a campaign domain separately.
- Configure analytics for a white-label site.
- Separate internal and public domain tracking.
- Support devolved analytics ownership.
