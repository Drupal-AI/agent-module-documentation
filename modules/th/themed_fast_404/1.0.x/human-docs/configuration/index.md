# Configuration

Themed Fast 404 has a short settings form and one crucial operational habit:
**the static 404 page is a snapshot generated on cron**, so most changes here only
take effect after cron runs again (or after you press the rebuild button on the
form).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Themed Fast 404**, or navigate directly to
   `/admin/config/system/themed_fast_404`.

## The fields

### Use system 404 path

*(checkbox, default off)* By default the module renders and scrapes its own
`/page-not-found` page. Tick this to have it use the 404 page you've already
configured in core instead — that is, the path set at **Configuration → System →
Basic site settings** under *Default 404 (not found) page*
(`system.site:page.404`). Leave it off if you're happy letting this module supply
the page body via the field below; turn it on if you already have a designed 404
page elsewhere on the site and just want its output cached as the fast 404.

### Base URL

*(text, default empty)* The URL prefix the module uses when it fetches the 404
page over HTTP during cron. Normally you can leave this blank — the module works
out an absolute URL from the current request. But cron often runs from the
command line with no host information, and on some hosts that means it can't build
a valid URL. If your generated file keeps coming out empty, set this to your
site's real address (for example `https://example.com`) so cron knows where to
fetch the page from.

> **Why an empty file happens:** the cron fetch is silenced, so if the URL is
> unreachable (a wrong Base URL, HTTP basic-auth, or a self-signed certificate on
> the internal hostname) the module writes an *empty* file rather than throwing an
> error — and visitors then see a blank 404 body. After the first cron run, check
> that the file isn't empty:
>
> ```bash
> find web/sites/default/files -name 'page-not-found-*.html' -size -1c
> ```
>
> Anything listed is an empty (broken) file.

### 404 page body

*(text, default "The requested page could not be found.")* The content rendered
by the module's own `/page-not-found` controller — this is what you're branding.
It's used when *Use system 404 path* is off. You can put HTML here, e.g. a
heading and a link to search:

```
<h1>Not found</h1><p>Try the search box, or head back to the home page.</p>
```

Both **Base URL** and **404 page body** are translatable config, so a multilingual
site can give each language its own wording (edit the translations the usual way
under the configuration-translation UI).

## Save and regenerate

After changing any setting, click **Save configuration**. Saving triggers a
rebuild, but it's good practice to run cron as well so every language's static
file is refreshed:

```bash
drush cron
```

You should **regenerate** (run cron, or press the form's rebuild button) after any
of these: editing the 404 body, a theme change, a CSS/JS aggregation flush, adding
a language, or toggling *Use system 404 path* / *Base URL*. The file is only a
snapshot, so until you regenerate, 404s keep serving the old markup.

## Good to understand before deploying

- **The fast 404 now matches *every* missing path**, not just asset-looking URLs
  as core's default does. The module deliberately widens this. Only `/styles/`
  (image derivatives) and `/system/files/` (private files) are excluded. If your
  site serves other custom file/download routes, be aware core will answer 404s on
  those with the static HTML rather than your own handler — factor that into your
  routing.
- **The behaviour change is immediate on enable**, before any static file exists.
  That's exactly why the [installation](../installation/index.md) step tells you
  to run cron right after enabling — otherwise 404s briefly fall back to core's
  plain default HTML.
