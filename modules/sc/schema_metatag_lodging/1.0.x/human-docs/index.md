# Schema.org Lodging — manual setup guide

**Schema.org Lodging** (`schema_metatag_lodging`) extends the
[Schema.org Metatag](https://www.drupal.org/project/schema_metatag) framework with
structured data for the lodging industry, so accommodation sites can describe
their offerings in JSON-LD that search engines read. It provides the Schema.org
`LodgingBusiness` properties as a base, with individual **types delivered through
submodules** — currently **Hotel** and **VacationRental**, plus a
**BedAndBreakfast** submodule (the module's roadmap also lists Campground,
Hostel, Motel, and Resort as future additions). Marking up a hotel, B&B, or
rental with the correct Schema.org type helps it become eligible for richer
search results.

It is a purely additive SEO / structured-data module: the JSON-LD it produces
reflects the content already on the page, and it has no content model or
access-control role of its own. It simply contributes the lodging vocabulary,
while Schema.org Metatag assembles and renders the JSON-LD in the page head. It
depends on the Schema.org Metatag module, works on Drupal 9, 10, and 11, and pairs
well with the [BEE Hotel](https://www.drupal.org/project/bee_hotel) module.

There is no separate settings screen for this module. After enabling it (and the
type submodules you want), you configure the lodging fields on your Metatag
defaults or per-entity metatag fields, exactly like any other Schema.org Metatag
type.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable the lodging type submodules you need.

## How to use it

Configuration happens inside the Metatag UI, not a page of this module's own:

1. Install and enable the base module plus the type submodules you want — for
   example `schema_hotel` or `schema_vacationrental` (see
   [Installation](installation/index.md)).
2. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`) and edit (or add) the metatag defaults for the
   entity type and bundle that represents your lodging.
3. Expand the relevant Schema.org lodging fieldset (for example
   **Schema.org: Hotel**) and fill in the field mappings you want to publish,
   typically using **tokens** so each page's values come from its own fields.
4. Save. Schema.org Metatag renders the resulting JSON-LD in the page head.
