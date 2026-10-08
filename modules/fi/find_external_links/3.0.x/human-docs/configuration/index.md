# Configuration

Find External Links has one settings form, and using it is a two-step rhythm:
choose what to scan, then run the scan and read the report.

## Open the settings form

1. Log in as a user with the **administer find external links** permission.
2. Go to **Configuration → System → Find external links**, or navigate directly to
   `/admin/config/system/find-external-links`.

## The settings

- **Fields to scan** — choose which node fields the module should look through for
  links (typically the **Body** field, but you can include any relevant text
  fields). Only the fields you select here are examined.
- **Ignore strings** — a list of strings (for example your own domains, or a CDN
  domain) that should be skipped. Any link whose URL matches one of these is left
  out of the report, so you can exclude links you don't care about. Internal links
  — those whose `href` starts with `#` or `/` — are always ignored automatically.

Save the form once you've made your selections.

## Run the scan

Running the scan is a **batch process** that walks your content, parses the HTML of
the fields you selected, and records the external links it finds into the module's
own database table. Each run **clears the previous list first**, so the report
always reflects the current content. Re-run the scan whenever your content changes
and you want a fresh inventory.

## Read the report

View the results at `/admin/config/system/find-external-links/list`. The report is
a paged, sortable table listing each external URL alongside its content type and
node ID, with a link to jump to the source node. Use it to review outbound links,
spot unwanted or broken third-party URLs, or support an SEO/compliance audit.

> **Note:** The module only reads your stored content — it never makes an HTTP
> request to the URLs it finds, so scanning does not fetch or follow external
> links.
