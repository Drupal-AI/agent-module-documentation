# Configuration

Media Tableau has two things to configure: the **allowed‑hosts whitelist** (which
Tableau domains may be embedded) and the **field formatter** (how a given viz is
displayed). This page covers both.

## Allowed hosts

Open **Configuration → Media → Tableau settings**
(`/admin/config/media/tableau`). You need the **Administer media_tableau allowed
hosts** permission.

The form has a single **Allowed Hosts** textarea — **one host per line**. Only
URLs whose host appears here will be embedded; anything else renders nothing. The
default list contains just:

```
https://public.tableau.com
```

To embed vizzes from your own Tableau Cloud or Tableau Server, add their hosts,
for example:

```
https://public.tableau.com
https://my-org.online.tableau.com
```

Each host is validated when you save:

- It must use the **`https://`** scheme (plain `http://` or other schemes are
  rejected).
- It must be **only the domain** — no path. A trailing `/` is allowed, but
  anything more specific is rejected with a hint to use only the domain.

This whitelist does double duty: it drives which URLs the formatter accepts, and —
if the **CSP** module is installed — Media Tableau automatically appends every
allowed host to the Content‑Security‑Policy `frame-src` directive on non‑admin
pages, so the embeds are not blocked. That happens with no extra setup.

You can also read the current list from the command line:

```bash
drush cget media_tableau.settings allowed_hosts
```

## The field formatter

The **Remote Media - Tableau** formatter (`media_tableau`) is what actually
renders the viz. It applies to a **string** field that holds a Tableau URL —
typically the source field of a Media Remote media type.

Set it on a display: go to the media type's (or entity bundle's) **Manage
display** tab, find the field holding the Tableau URL, and choose **Remote Media -
Tableau** as its **Format**. Click the gear to adjust its settings:

- **API version** (`api_version`, default **latest**) — which version of the
  Tableau Embedding API JavaScript to load: `latest`, `3.6`, or `3.5`. Pin to a
  specific version if you need compatibility; choose `latest` to always track the
  current release.
- **Width** (`width`, default **100%**) — the iframe width, in any CSS unit
  (e.g. `100%`, `900px`).
- **Height** (`height`, default **900px**) — the iframe height, in any CSS unit
  (e.g. `600px`).
- **Toolbar** (`toolbar`, default **off**) — whether to show Tableau's
  interactive toolbar beneath the viz.

Save the display. When an editor enters a Tableau URL that matches an allowed
host, the formatter renders the `<tableau-viz>` embed at the size you chose.
Share‑style URLs (`.../app/profile/…/viz/…`) are automatically rewritten into the
embeddable `.../views/…` form.

## A typical end‑to‑end setup

1. Add the host(s) you need on the **Tableau settings** page.
2. Create a **Remote Media** type with a source string field for the Tableau URL.
3. On that media type's **Manage display**, set the source field to **Remote Media
   - Tableau** and choose your size/toolbar/API options.
4. Editors create media by pasting a Tableau URL, then reference that media from
   content — the dashboard renders inline.
