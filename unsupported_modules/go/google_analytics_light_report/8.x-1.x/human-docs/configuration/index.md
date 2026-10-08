# Configuration

Setting up Google Analytics Light Report means connecting it to the Google
Analytics Reporting API, granting the right permissions, and placing the report
blocks (or using the bundled report page).

## Connect to the Google Analytics API

The module reads your analytics data through the `google-api-php-client` library, so
it needs credentials for the Google Analytics Reporting API and the identity of the
analytics property/view you want to report on. Set these up in the Google Cloud
console (create a project, enable the Analytics Reporting API, and create
credentials such as a service account), then provide them to the module along with
the analytics view/property identifier.

### Keep the credentials secure

The API credentials are sensitive — do not commit them in exported configuration.
Prefer storing them in the environment. With DDEV you can keep a value out of Git:

```bash
ddev dotenv set .ddev/.env --galr-api-secret=<value>
ddev restart
```

(The flag `--galr-api-secret` becomes the variable `GALR_API_SECRET`; keep
`.ddev/.env` out of version control.) The module makes **outbound HTTPS** calls to
Google's API, so your host must allow that egress.

## Set permissions

Under **People → Permissions**, assign:

- **View Google Analytics report (light)** — to the roles that should *see* the
  reports (`google analytics report light`).
- **Administer Google Analytics Light Report** — to administrators who manage the
  module (`administer google analytics light report`).

Keep the reports restricted to trusted staff, since analytics figures are usually
internal.

## Place the report blocks

Go to **Structure → Block layout** and place any of the three report blocks in the
regions you want:

- **Users / Sessions / Bounce Rate / Pageviews** summary.
- **Pageviews list**.
- **Top browsers** (pie chart).

Each block has a **duration** setting in its block configuration — choose the
reporting period the block should cover.

## The report page

The module also provides a combined report page at **`/analytics-light-report`**,
which brings the reports (including a line chart) together in one place. Link to it
from your admin navigation for users with the view permission.
