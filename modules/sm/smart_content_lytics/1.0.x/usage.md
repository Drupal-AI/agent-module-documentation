<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Content Lytics wires the Lytics CDP into Smart Content's condition system. It derives condition plugins from the Lytics user schema (only fields whitelisted/surfaced by the Lytics API), so site builders can build segments that react to a visitor's Lytics profile attributes and audiences.

Use it to drive on-site personalization from Lytics profiles/segments through the Smart Content framework.

---

Install (requires `smart_content` and `lytics`, and a configured Lytics access token in `lytics.settings`). The deriver `LyticsConditionDeriver` calls the Lytics schema endpoints server-side with the stored token (over HTTPS with default TLS verification) to enumerate available profile fields, then registers a Smart Content condition per allowed field.

Authors then add "Lytics" conditions to segments; at runtime the front-end supplies the visitor's Lytics attribute values for evaluation. No admin routes/permissions are added by this submodule.

---

- Segment visitors on Lytics profile fields.
- Derive Smart Content conditions from the Lytics schema.
- Surface only Lytics API-whitelisted fields.
- Map Lytics field types to condition types.
- Drive personalization from a Lytics CDP.
- Reuse the Lytics access token from lytics.settings.
- Fetch schema over HTTPS with default TLS verification.
- Add a Lytics condition group to Smart Content.
- Evaluate Lytics attributes client-side.
- Extend Smart Content's condition plugin system.
- Require no dedicated admin UI.
- Depend on smart_content and lytics.
- Sort available fields by label.
- Support Drupal 10.
- Pair with the Lytics JS tag for attribute data.
- Enable audience-based content variations.
