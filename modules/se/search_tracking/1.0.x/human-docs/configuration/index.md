# Configuration

Search Tracking has to be told how to recognise your search form before it records
anything. The setup is two parts: describe the form on the configuration page, then
build a view to display the collected data.

## 1. Describe your search form

Go to **Configuration → Search and metadata → Search Tracking → Form config**
(`/admin/config/search/search-tracking/form-config`) as an administrator, and
enter the attributes that identify your search form:

- **Form ID or class** — you choose whether to match your search form by its
  **ID** or by its **class**. Enter the corresponding value so the bundled
  JavaScript can find the form on the page.
- **Input name** — the `name` attribute of the search input element (the text
  field visitors type into). This is how the module knows which field holds the
  search term. A URL parameter can serve the same purpose for searches submitted
  through the address bar.

Getting these values right matters: if the form ID/class or the input name is
wrong, nothing is captured, and a mistake in the entered attributes will produce an
error. Check them against your actual search form's markup.

When a visitor searches, the module's JavaScript reads the entered term and stores
the **keyword**, the **client IP address**, and the **timestamp** in the
`search_tracking` database table.

## 2. Build the display view

The collected data is shown through Views:

1. Go to **Structure → Views** (`/admin/structure/views`).
2. Add a view using the bundled **Search Tracking** view as a starting point.
3. Customise it — fields, filters, sorting, and access — exactly as you would any
   other view, to present searched keywords, IP addresses, and timestamps the way
   you want.

## Stored data

Each submission is stored with the submitter's IP address. Treat the stored IP
addresses as personal data with the retention and access considerations that
implies.
