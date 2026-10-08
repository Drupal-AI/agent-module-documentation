<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories: Venue - Open Referral turns venue entries into Open Referral services and gives every existing venue an organisation record, so venue data can be published in the Open Referral standard. Explicitly experimental.

---

Open Referral models the world as organisations that provide services at locations. LocalGov's venue bundle is closer to a location-with-contact-details, and has no organisation attached — so publishing venues as Open Referral services needs two things: a property mapping that describes a venue as a service, and an organisation for each venue to belong to. This submodule supplies both. It installs `localgov_openreferral.property_mapping.node.localgov_directories_venue` (the mapping) and attaches `localgov_directory_organisation` to the venue bundle (the reference). The interesting part is the backfill: `localgov_directories_venue_or_prepopulate_org()` queries every `localgov_directories_venue` node with `accessCheck(FALSE)`, and for each one whose organisation reference is empty it **creates a new `localgov_directories_org` node** carrying the venue's title, published status and owner, then links it. That means enabling this module on a site with existing venues silently doubles the node count in that area — one organisation per venue — which is exactly why the module description begins with EXPERIMENTAL. It depends on the venue, organisation and facet-mapping submodules plus `localgov_openreferral`.

---

- Publish venue listings as Open Referral services.
- Give every venue an organisation record required by the standard.
- Backfill organisations for a directory that predates Open Referral.
- Share venue data with a regional service finder.
- Meet an open data commitment using a recognised schema.
- Let partners consume venue data without bespoke integration.
- Model the operator of a building separately from the building.
- Prepare a directory for aggregation by a national project.
- Keep venue and organisation records linked automatically.
- Publish opening times and contact details in a standard shape.
- Combine with the facet mapping submodule for full category data.
- Prototype Open Referral publication on an existing venue directory.
- Provide structured service data to a voluntary-sector partner.
- Support cross-authority reporting on community facilities.
- Reduce manual data entry when adopting Open Referral.
- Give each venue an editable organisation record afterwards.
- Expose venue data through the Open Referral API endpoints.
- Align a LocalGov directory with an external service directory.
- Keep the standard mapping in config rather than custom code.
- Migrate towards a service/organisation model incrementally.
