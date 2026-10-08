<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Gmap Field adds a Webform element that shows a Google Map and records the latitude and longitude of the point a user clicks, so a form can capture a location.

---

Some forms need a place, not an address: report a pothole here, mark where a photo was taken, pick a delivery point. Typing coordinates is hopeless and geocoding an address is imprecise; letting the user click a map is the natural interaction. This module provides that as a Webform element — drop it into a form, and submissions carry the clicked lat/long.

The dependency to plan for is Google Maps itself. The element renders a Google Map, which means the JavaScript Maps API, which means a Google Maps API key and the billing account behind it — Google's Maps Platform is a paid service past a free tier. The module has a settings page for its configuration; the key and quota are a Google-side concern the site takes on. That is the real cost of adopting it, more than the code.

Two things worth confirming for any map-embedding element. First, where the API key is configured and how it is restricted — a Maps key should be limited by HTTP referrer so it cannot be lifted from your pages and spent elsewhere. Second, that embedding the Maps API fits the site's privacy posture, since it loads third-party Google script on every page containing the form. For collecting a location on a webform, though, it is the direct tool.

---

- Collect a location on a webform.
- Let a user click a map to set a point.
- Capture latitude and longitude.
- Report a location on a form.
- Mark where a photo was taken.
- Pick a delivery point on a map.
- Add a map element to a webform.
- Store coordinates in a submission.
- Geolocate a form submission.
- Configure a Google Maps API key.
- Restrict the Maps key by referrer.
- Budget for Google Maps billing.
- Collect field-report coordinates.
- Map an incident location.
- Add a pick-a-place question.
- Confirm the privacy impact of embedding Maps.
- Use lat/long downstream.
- Build a "report here" form.
- Capture precise points, not addresses.
- Place a map on a contact form.