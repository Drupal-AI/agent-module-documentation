<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Content Paragraphs brings Smart Content personalization to Paragraphs. Editors build "smart" component paragraphs whose variation children (`smart_content_paragraph`) are each gated by Smart Content conditions (device, geolocation/region, cookies, node reference, textfields, numbers, selects). At runtime the browser posts collected condition data to a reaction endpoint, which returns which variation(s) to show.

Use it to personalize paragraph-based page components per visitor segment.

---

Install (requires `smart_content`, `paragraphs`, `paragraphs_library`, `geocoder`; the geolocation submodule uses the Google Maps geocoder). Build content types with smart component paragraphs and variation paragraphs carrying condition segment-set references. Region conditions are geocoded server-side (Google Maps API key from the geocoder provider) and stored in a `smart_content_paragraphs_regions` table.

The front-end calls `POST /personalised_content/reactions/{nid}` (permission `access content`) with a JSON body of client values (pages, user-agent-derived OS, lat/long, etc.); `ReactionsController::reaction` loads the node, evaluates each variation's conditions and returns the matching variation paragraph target IDs as JSON. The sub-submodules `pce_device`, `pce_geolocation`, `pce_geobrowser`, `pce_node`, `pce_cookie` provide condition derivatives.

---

- Personalize Paragraphs by visitor segment.
- Wrap variations in "smart" component paragraphs.
- Gate variations with Smart Content conditions.
- Target by device/OS.
- Target by geolocation region (geocoded bounds).
- Target by browser geolocation lat/long.
- Target by cookie values.
- Target by referenced node/page.
- Target by textfield/number/select conditions.
- Resolve variations via a JSON reaction endpoint.
- Return matching variation paragraph IDs.
- Store geocoded region bounds in a custom table.
- Use the Google Maps geocoder for regions.
- Provide condition derivative submodules.
- Support AND/OR condition grouping.
- Work for anonymous visitors.
