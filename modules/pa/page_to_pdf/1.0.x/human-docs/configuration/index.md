# Configuration

Setting up Soapbox PDF is a three‑step job: store your PDF service API key, add a
field to hold the generated PDF, and enable Page to PDF on the content type that
should produce PDFs.

## 1. Store the PDF service API key

Sign up with a supported PDF generator service — **Doppio.sh** (recommended) or
**Browserless.io** — and add its API key to your site's **`settings.php`**.

> **Treat the API key as a secret.** Never commit it to version control. Prefer
> keeping the value in an environment variable and reading it in `settings.php` with
> `getenv()`, rather than pasting the literal key into a tracked file. In DDEV you
> can store it with `ddev dotenv set .ddev/.env --your-key=<value>` (keep
> `.ddev/.env` out of version control) and then read the variable from
> `settings.php`.

## 2. Create a field to store the PDF

The module saves each generated PDF into a field on the node, so create one:

1. Go to **Structure → Content types → *(your content type)* → Manage fields**.
2. Add a field suitable for storing the generated PDF file.
3. Save the field.

## 3. Enable Page to PDF on the content type

Edit the content type and turn on **Page to PDF**, selecting the field you just
created as the **target field** for the generated PDF. Save.

## Prepare the content for print (your responsibility)

The module handles the infrastructure; making the content print well is up to you.
Configure the node's **PDF display** appropriately — for example, replace videos,
accordions, and other non‑print elements with sensible fallbacks, and add front and
back covers to the PDF view as desired. Puppeteer renders the page through headless
Chrome, so most standard HTML and CSS (including print‑specific page breaks) is
respected, and Paged.js arranges the content into a print‑friendly grid.

## A note on what gets rendered

The PDF is produced from the node's own content on your site. Keep the rendered
content controlled, and keep your PDF service account and API key restricted to this
use — the key is a credential that lets requests be run against the managed
rendering service.

## Verify

Save a node of the configured content type and confirm a PDF is generated and stored
in the target field.
