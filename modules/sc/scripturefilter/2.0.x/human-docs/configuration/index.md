# Configuration

Scripture Filter is configured as part of a **text format**, so its behaviour
applies to any content created with that format.

## Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the text format you want Scripture references linked in (for example
   *Basic HTML* or *Full HTML*) and click **Configure**.
3. In the **Enabled filters** list, tick the Scripture Filter option to turn it on
   for that format.

## Choose which online Bible to link to

With the filter enabled, its settings let you pick the target Bible that references
should link to. The choices include:

- **NIV** on Bible Gateway (the **default**), plus a number of other English
  translations available from Bible Gateway.
- The **ESV** online Bible.
- The **NET** Bible.

Pick the translation that suits your audience, then **save** the text format.

## Check the filter order

As with any text filter, the order filters run in can matter. If linked references
do not appear as expected, review the **filter processing order** on the same text
format configuration page so Scripture Filter runs at an appropriate point relative
to other filters.

## Result

From then on, any content using that text format will have its Scripture references
(such as "John 3:16") automatically turned into clickable links to your chosen
online Bible when the content is displayed.
