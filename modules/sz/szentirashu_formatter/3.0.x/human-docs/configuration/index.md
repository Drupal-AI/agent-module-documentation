# Configuration

There are two parts to setting this module up: entering your szentiras.eu API key and
default translation on the settings form, then applying the formatter to the field
that holds your references.

## Enter the API key and default translation

1. Log in as a user granted the **Administer szentirashu api** permission.
2. Go to the szentiras.eu Reference Formatter settings form (the
   `szentirashu_formatter.settings` route).
3. Enter your **API key** — the module sends this to szentiras.eu in an `X-API-Key`
   header when it fetches passages. Treat the key as a secret credential.
4. Choose a **default translation** — the Bible translation used when a reference
   does not specify one. The list of available translations is populated from the API
   and cached for 24 hours.

Save the form.

## Add the formatter to a field

1. Go to the **Manage display** screen for the entity whose field holds Bible
   references (for example, for a content type:
   **Structure → Content types → *your type* → Manage display**).
2. Find the text field that stores references and set its **Format** to the
   szentiras.eu reference formatter.
3. Choose the behaviour you want for that display — a **simple link** to
   szentiras.eu, **load text on click**, or **auto-load** all referenced passages
   when the page loads — and set the translation abbreviation to show where relevant.
4. Save the display. Fetched passages are cached permanently per reference, so repeat
   views do not re-hit the API.

## A note on the proxy endpoint and your API quota

The click-to-load and auto-load behaviours use a small proxy route
(`/szentirashu/proxy/{ref}/{translation}`) that returns passage text as JSON. That
route is gated only by the core **Access content** permission, which anonymous
visitors normally have — so it is effectively public. This is not a server-side
request forgery risk: the reference is only URL-encoded into the fixed szentiras.eu
host, there is no arbitrary-URL fetching, and TLS is left at secure defaults. The real
consideration is quota — because the lookups run under your site's API key, anonymous
visitors (or a script hitting the proxy) can consume your szentiras.eu API allowance.
The permanent caching of passages softens this; if you ever see abuse, consider adding
rate limiting in front of the proxy route.
