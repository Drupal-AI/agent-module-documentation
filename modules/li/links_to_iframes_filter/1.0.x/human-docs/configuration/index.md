# Configuration

Getting Links to Iframes Filter working is a two-part job: **define the
mappings** (which link becomes which iframe) and then **enable the filter** on
the text formats where you want the replacement to happen.

## Step 1 — Add link→iframe replacements

1. Log in as a user with the module's mapping-management permission (grant it
   only to trusted users — see the security note below).
2. Go to **Configuration → Content authoring → Links to iframes**
   (`/admin/config/content/links-to-iframes`).
3. Add one or more replacements. Each has two parts:
   - **Link** — the exact URL to match (matching is by the anchor's `href`
     value, exactly).
   - **Iframe** — the iframe embed markup to render in its place.
4. Save the replacements.

Mappings are stored in the module's own database table and the filter uses a
cache tag (`links_to_iframes_filter:mappings`) so changes take effect for
rendered content.

## Step 2 — Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format you want the replacement to apply to.
3. Enable **Replace links with iframes** in the format's filter list.
4. Save the text format.

From then on, any content rendered with that format will have matching links
swapped for their configured iframe markup. Replacement runs **only** where that
text format is applied, so you control exactly where embeds appear by choosing
which roles have access to the format.

## How matching works

- Links are matched by their **exact `href`** — a configured mapping for
  `https://example.com/embed` only replaces anchors whose href is exactly that.
- Replacement happens on output, wherever the enabled format is used.

## Security notes

- The iframe markup you enter is **admin-defined and rendered directly into
  pages**. Restrict who can edit the mappings (the module's permission) to
  trusted administrators.
- The markup comes only from your curated mapping — never from arbitrary
  user-supplied URLs — and matching is limited to the links you configure, which
  keeps the filter's exposure narrow.
- Iframes embed third-party content, so keep the usual privacy and clickjacking
  considerations in mind, and control which roles have a text format that
  includes this filter.
