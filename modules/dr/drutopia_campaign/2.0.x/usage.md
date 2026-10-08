<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a Campaign content type and related configuration: background information plus the ability to list demands and updates.

---

Grassroots and advocacy sites need a campaign page that centralises an issue: background, news updates, demands and calls to action. This Drutopia feature installs a Campaign content type with those fields, a campaign_type vocabulary, faceted listing, Search API indexing and SEO defaults.

As a Drutopia base feature it is config-only: enabling it installs the `campaign` content type, its fields, form and view displays (default/teaser/card/full and more), a `campaign_type` classification vocabulary, a Views-based listing, a Pathauto URL pattern, Metatag/SEO defaults, and comment/facet/search configuration where applicable. It ships no PHP routes, controllers, services or permissions of its own — access is governed entirely by core node permissions and the Drutopia editorial roles (contributor/editor/manager) it augments via `config/actions`. Editors add content from the listing's "Add" action link; site builders customise the installed config like any other content type.

---
- Add a campaign/initiative content type to a Drutopia site
- Publish a campaign page explaining an issue
- List a campaign's demands and calls to action
- Post updates related to a campaign
- Classify campaigns with the campaign_type vocabulary
- Attach a responsive hero image/media to a campaign
- Browse the campaign listing view with an 'Add campaign' action
- Facet campaigns by type
- Index campaigns in Search API
- Auto-generate URL aliases via Pathauto
- Emit Metatag SEO metadata for campaigns
- Compose campaign bodies from paragraphs
- Show teaser/card/full view displays for campaigns
- Grant editorial roles campaign permissions
- Link campaigns to related content by shared taxonomy
- Menu-enable campaign pages via menu_ui
