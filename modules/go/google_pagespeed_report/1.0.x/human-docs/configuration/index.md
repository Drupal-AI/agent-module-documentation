# Configuration

Performance Monitoring talks to Google's PageSpeed Insights API, so it needs a
Google API key before it can record anything. The key is billed against your
Google account and should be treated as a secret — never paste it directly into
configuration that gets exported to code or committed to Git.

## Get a PageSpeed Insights API key

1. In the [Google Cloud console](https://console.cloud.google.com/), create (or
   pick) a project.
2. Enable the **PageSpeed Insights API** for that project.
3. Create an **API key** credential and, ideally, restrict it to the PageSpeed
   Insights API to limit abuse if it ever leaks.

## Store the key as a secret (recommended)

Rather than typing the key into a form field that ends up in configuration, keep
it in an environment variable and reference it. With DDEV:

```bash
ddev dotenv set .ddev/.env --pagespeed-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--pagespeed-api-key` becomes the environment variable
`PAGESPEED_API_KEY` inside the web container. Keep `.ddev/.env` out of version
control. If you have the [Key](https://www.drupal.org/project/key) module
installed, you can then create a Key entity backed by that environment variable
and point the module at it, so the secret never lives in exported config.

## Add the key on the settings form

Open the module's settings form (use the **Configure** link next to the module on
the *Extend* page, `/admin/modules`) and enter or select your PageSpeed API key.
Save the form.

## A note on data flow

When the module measures a page it sends a request to Google's PageSpeed Insights
service (outbound HTTPS egress) and stores the returned metrics locally. Be aware
that API usage counts against your Google quota, which can incur cost — avoid
measuring more pages, more often, than you actually need.
