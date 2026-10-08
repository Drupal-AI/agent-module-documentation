# Configuration

ShURLy's setup is mostly about permissions — deciding who can create links and who can
edit them — plus optional rate limiting to stop abuse.

## Set up permissions first

Go to **People → Permissions** and grant the ShURLy permissions deliberately. The set
includes:

- **`create short URLs`** — the core capability to make a new short link.
- **`enter custom URLs`** — allows choosing a custom vanity slug rather than an
  auto-generated one.
- **`view own URL stats`** — lets a user see their own links and click counts at
  `/myurls`.
- **`edit own URLs`** and **`edit all URLs`** — control who may change a link's
  destination.
- **`administer short URLs`** — full administration.

Because a short link points your own domain at an arbitrary destination, **treat
`create short URLs` (and especially `enter custom URLs`) as reputation-bearing
permissions.** Anyone who holds them can publish a link on your domain that redirects
anywhere — which is precisely what a phishing campaign wants. Remember too that
destinations can be edited after a link has been shared, so grant *edit* permissions
just as carefully. Give these to people you would trust to publish on the site, and no
wider.

## The settings form

The admin settings form is the **`shurly.admin`** route. Its main job is **per-role
rate limiting**: you can limit a role to *X* requests every *Y* minutes, which is the
main defence against someone (or something automated) generating short links or
hitting the API in bulk. Configure sensible limits before opening creation up to less
trusted roles.

## Creating and managing links

- Users create a new short URL at **`/shurly`**, entering the long URL and an optional
  custom short URL. You can also expose the "Create a short URL" block instead.
- Users review their own links at **`/myurls`** (needs *view own URL stats*).
- Administrators see everyone's links at the ShURLy admin overview, which is a Views
  listing.

Auto-generated slugs draw from `A–Z`, `a–z`, and `0–9`, deliberately skipping the
ambiguous `0`, `1`, `l`, `I`, and `O`. Slugs are case-sensitive to maximise the number
of available combinations, and custom slugs may include UTF-8 characters and glyphs.

## Known rough edge

The edit route `/shurly/edit/{rid}` returns a server error (HTTP 500) to anonymous
requests when the id is not a number, because the access check does not handle that
case cleanly. It fails closed (it does not grant access), but it is noisy — worth
knowing if you see 500s in your logs from crawlers hitting that path.
