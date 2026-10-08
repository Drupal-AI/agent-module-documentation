Adds Schema.org/SpecialAnnouncement JSON-LD structured data via Metatag, marking up time-sensitive announcements (closures, health notices, emergency updates).

---

Schema.org SpecialAnnouncement is a Schema.org Metatag submodule that registers Metatag tag plugins for the `SpecialAnnouncement` type, originally introduced for COVID‑19 and general emergency communications. Enabling it adds a `Schema.org SpecialAnnouncement` group to Metatag configuration where token-driven values render into the page's JSON-LD. It covers the announcement `name`, `text`, `category`, `datePosted`, `expires`, and `spatialCoverage`/`announcementLocation`, plus a large set of specialized URL properties Google supports: `diseasePreventionInfo`, `diseaseSpreadStatistics`, `gettingTestedInfo`, `governmentBenefitsInfo`, `newsUpdatesAndGuidelines`, `publicTransportClosuresInfo`, `quarantineGuidelines`, `schoolClosuresInfo`, and `travelBans`. `@type` and `@id` allow specialization and cross-referencing. It is used by government, health, education, and transit sites to publish machine-readable, time-bound announcements eligible for special-announcement rich results.

---

- Mark up a time-sensitive notice as a `SpecialAnnouncement`.
- Set the announcement `name` and body `text`.
- Categorize the announcement via `category`.
- Record `datePosted` and an `expires` date so it drops off after the event.
- Define `spatialCoverage`/`announcementLocation` for the affected area.
- Link `schoolClosuresInfo` for education notices.
- Link `publicTransportClosuresInfo` for transit disruptions.
- Link `quarantineGuidelines` and `diseasePreventionInfo` for health guidance.
- Link `gettingTestedInfo` for testing details.
- Link `diseaseSpreadStatistics` to a data source.
- Link `governmentBenefitsInfo` for relief programs.
- Link `newsUpdatesAndGuidelines` to an updates page.
- Link `travelBans` information.
- Set the `@type` and a stable `@id`.
- Publish government/emergency announcements with structured data.
- Qualify for special-announcement rich results.
- Auto-expire announcements via the expires property.
- Map announcement fields from editable content via tokens.
- Communicate closures across school, transit, and health sites.
- Keep emergency notices machine-readable for aggregators.
