<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS — Event ships a ready-made **Event content type** with its date, place, image and taxonomy fields, form and view displays, an Event Type taxonomy, a pathauto pattern, schema.org-Event metatag defaults, content-translation settings, and Search-API listing views/facets/blocks — all as installed configuration. It is one component of the Acquia CMS (Acquia Drupal Starter Kit) content model.

---

Acquia CMS is Acquia's Drupal distribution, assembled from small single-purpose feature modules like this one. Rather than a site builder creating an event type from scratch — the start/end/door-time datetime fields, a duration string, a reference to a Place node, an image, an Event Type vocabulary, the widgets, the view modes, the pathauto pattern, the schema.org Event metatag defaults — this module ships that configuration as a unit, so the Event type exists and is editor-ready the moment it is enabled. The type is wired into the family's editorial workflow, scheduler, metatag and search layers through `third_party_settings` that reference `acquia_cms_common`, and its `field_event_place` references the Place type from `acquia_cms_place`. The only PHP is thin install/update glue plus a helper that shifts demo event dates forward on starter-content import; there is no settings page, no drush command, and no runtime request logic. The value and the limitation are the same fact: it is distribution configuration, not a generic feature. It encodes Acquia's opinion of what an Event is and expects its siblings (`acquia_cms_common`, `acquia_cms_place`, optionally the search and Site Studio stacks) to be present. On an Acquia CMS site it is exactly right; on an unrelated site it is a strong set of assumptions to adopt — usable as a starting point, but you inherit the whole model. Because it is configuration, extending it means adding fields and adjusting displays as you would any content type, and it travels with a normal config export.

---
- Add a ready-made Event content type to an Acquia CMS site.
- Author an event with start, end and door-time dates.
- Reference a Place node as the event's venue.
- Capture an event image, categories and tags out of the box.
- Classify events by an Event Type taxonomy vocabulary.
- Show upcoming and past events via the shipped card view blocks.
- Provide a searchable Events listing page at `/events`.
- Filter events by category and event type with Search-API facets.
- Get schema.org Event structured data (start/end/location) automatically.
- Get Open Graph and Twitter Card metatags for event pages.
- Get a date-based pathauto URL pattern for events.
- Schedule event publish/unpublish with the Scheduler integration.
- Run events through the Acquia CMS editorial moderation workflow.
- Enable content translation for event nodes.
- Grant authors/editors the right event permissions automatically on Acquia CMS.
- Standardise event content structure across a site.
- Base a custom event type on Acquia's model.
- Render events with Site Studio slider/card templates when Site Studio is enabled.
- Seed demo events whose dates auto-shift to the future on import.
- Export the Event configuration with the rest of the site.
- Skip building an event content type and its displays by hand.
- Match the Acquia CMS content model for events.
- Use events alongside the rest of the Acquia CMS module family.
