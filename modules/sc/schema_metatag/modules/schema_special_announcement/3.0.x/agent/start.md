# schema_special_announcement — agent start

Submodule of **schema_metatag**. Adds **Schema.org/SpecialAnnouncement** structured data as Metatag *Tag*
plugins in the `schema_special_announcement` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, text, category, datePosted, expires, spatialCoverage/announcementLocation, plus URL props (schoolClosuresInfo, publicTransportClosuresInfo, quarantineGuidelines, diseasePreventionInfo, gettingTestedInfo, diseaseSpreadStatistics, governmentBenefitsInfo, newsUpdatesAndGuidelines, travelBans), @type, @id.
- Use for time-bound government/health/education/transit notices.
