Adds Schema.org/Person JSON-LD structured data to your pages via the Metatag module, describing a person (author, staff member, public figure) so search engines can build knowledge-panel and author rich results.

---

Schema.org Person is a submodule of Schema.org Metatag that registers a set of Metatag "tag" plugins in a `Schema.org Person` group. Once enabled, the group appears in your Metatag default and per-entity/bundle configuration (Admin → Config → Search and metadata → Metatag), where each property is a field that accepts plain text or tokens. On render the values are collected and emitted as a `Person` node inside the page's JSON-LD `<script type="application/ld+json">` block. It covers identity properties (name, givenName, familyName, additionalName, alternateName), contact details (email, telephone, address, contactPoint), descriptive data (description, image, gender, birthDate, jobTitle), and relationship links (affiliation, memberOf, worksFor, brand, sameAs, url). The `@type` and `@id` tags let you set the exact type and a stable identifier so the Person can be referenced from other Schema types (e.g. as an Article author or Review author). Because values are token-driven, a single configuration maps across every node of a bundle. It is typically used on author profiles, team/staff pages, and personal sites.

---

- Mark up an author profile node as a `Person` for author rich results.
- Set the person's full `name` from a token like `[user:display-name]`.
- Provide `givenName` and `familyName` separately for precise name parsing.
- Add an `additionalName` (middle name) or `alternateName` (pen name / nickname).
- Expose a contact `email` and `telephone` for the person.
- Attach a postal `address` (nested PostalAddress) for a public figure or professional.
- Add a `contactPoint` for structured contact/customer-service info.
- Publish a profile `image` (headshot) referenced by search engines.
- Describe the person with a `description` biography snippet.
- State `jobTitle` for a staff member or executive.
- Record `gender` and `birthDate` where relevant.
- Link the person's official `url` (homepage or profile URL).
- Add `sameAs` links to social/authority profiles (LinkedIn, Wikipedia, ORCID).
- Declare `affiliation`, `memberOf`, or `worksFor` to connect the person to an organization.
- Associate a `brand` with a personal brand or public figure.
- Set a custom `@type` (e.g. Person) and stable `@id` for cross-referencing.
- Reference this Person `@id` as the author of an Article or Review.
- Drive all values from tokens so one config covers every author node.
- Improve E-E-A-T signals by describing content authors as structured entities.
- Support knowledge-panel eligibility for notable people on the site.
