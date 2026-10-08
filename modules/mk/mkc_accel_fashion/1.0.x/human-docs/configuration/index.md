# Configuration

Configuration spans a central settings screen plus the day-to-day management of
size charts, lookbooks and returns.

## Open the settings

Go to **Commerce → Fashion → Settings**
(`/admin/commerce/fashion/settings`) for the module's overall configuration. Save
any changes to apply them.

## Create and assign size charts

At **`/admin/commerce/fashion/size-charts`** you build **SizeChart** entities — a
measurement table with the rows and columns you need — and assign each chart to a
product or a category. Once a product has a chart, the **Size Guide** block can
render it automatically on that product's page.

## Build lookbooks

At **`/admin/commerce/fashion/lookbooks`** you create **Lookbook** entities: give
each a cover image, tag the products it features, and set its publish schedule.
Published lookbooks can be surfaced on landing pages via the **Lookbook** carousel
block, and are also exposed through the module's read APIs.

## Place the storefront blocks

Under **Structure → Block layout**, position the two blocks the module provides:

- **Size Guide** — shows the relevant size chart on product pages.
- **Lookbook** — a featured-lookbook carousel for landing pages.

## Handle returns and exchanges

Customers submit a return or exchange at `/fashion/return-request/{order_id}`. You
process those requests at **`/admin/commerce/fashion/returns`**, where each request
carries a reason code and moves through resolution tracking.

## Test it

Assign a size chart to a product and confirm the Size Guide block renders it;
publish a lookbook and confirm it appears in the carousel; submit a test return and
confirm it shows up in the returns queue for processing.
