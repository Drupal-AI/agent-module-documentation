<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories Organisation provides an organisation **entry** type: a structured record for a body or provider, usable as a directory entry in its own right and as the organisation an Open Referral service belongs to.

---

The submodule installs the `localgov_directories_org` node type with the shared directory fields (email, website, files, notes, facet selection, channels) and the `localgov_directory_organisation` field storage that other bundles — notably venues under the Open Referral submodule — use to point at an organisation. It depends on `localgov_directories_location`, so organisations can carry a geocoded location and take part in proximity search and maps like venues do. Default, teaser, `search_result` and other view displays ship so organisations render consistently in channel listings and search. The bundle exists mainly to give Open Referral-compatible data a home: Open Referral models services as belonging to organisations, and without a dedicated bundle a LocalGov site has nowhere to record that relationship. Used on its own, it is simply a directory entry type aimed at listing organisations rather than places or pages.

---

- List voluntary and community sector organisations in a directory.
- Record the organisation that runs a venue or service.
- Publish provider records for a family services directory.
- Give organisations their own searchable, facetable entries.
- Supply the organisation half of an Open Referral dataset.
- Attach documents such as constitutions or policies to an organisation.
- Show organisation contact details and website in search results.
- Filter organisations by facets such as sector or area served.
- Locate organisations on a map alongside venues.
- Support proximity search across organisation records.
- Reuse organisation records across several directory channels.
- Keep organisation notes separate from the public body text.
- Link venues to their operating organisation.
- Provide structured data for aggregation by a partner authority.
- Migrate an existing organisations register into Drupal.
- Let editors maintain organisation records without developer help.
- Combine organisations and venues in a single directory channel.
- Serve as a reference bundle when modelling other entity types.
- Publish organisation data that partner sites can consume.
- Keep organisation and service data normalised rather than duplicated.
