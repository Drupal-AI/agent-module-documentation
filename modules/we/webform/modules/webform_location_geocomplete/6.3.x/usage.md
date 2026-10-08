DEPRECATED / REMOVED. Legacy Google Maps "Geocomplete" location element for Webform. The module has been removed; only an orphaned JavaScript file remains in this directory.

---

Webform Location Geocomplete provided a location autocomplete element that used the jQuery Geocomplete plugin (built on the Google Maps JavaScript API) to turn an address input into a geocoded field, optionally showing a map and populating latitude/longitude and address-component sub-fields. In current Webform (6.3.x) the module has effectively been removed: this directory contains no `.info.yml` and no PHP — only the leftover behavior script `js/webform_location_geocomplete.element.js`, which binds to `.js-webform-type-webform-location-geocomplete` elements when `$.fn.geocomplete` is available. It cannot be enabled as a module. The jQuery Geocomplete library is unmaintained; sites needing address geocoding should use the maintained Webform Location Places (Algolia Places) history or a modern geocoding contrib solution instead. This entry exists for provenance and migration reference only.

---

- Understand what the removed Geocomplete location element used to do.
- Identify leftover Geocomplete JavaScript during a Webform upgrade.
- Migrate legacy forms off the removed location element.
- Reference the old `.js-webform-type-webform-location-geocomplete` selector.
- Locate forms that referenced the geocomplete location type.
- Plan replacement with a maintained geocoding element.
- Audit a codebase for stale Google Maps Geocomplete integration.
- Document the deprecation/removal path for stakeholders.
- Clean up orphaned assets left after the module's removal.
- Explain to editors why the old location field no longer works.
- Trace how latitude/longitude sub-fields were populated historically.
- Compare against current Webform location options.
- Confirm no active configuration still depends on this element.
- Provide historical context for a form-migration project.
- Verify the leftover script has no runtime effect without the library.
