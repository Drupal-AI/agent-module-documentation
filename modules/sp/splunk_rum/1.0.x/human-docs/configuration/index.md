# Configuration

Splunk Real User Monitoring does nothing until you tell it which Splunk
Observability environment to report to. The settings form is where you provide
that information.

## Open the settings form

1. Log in as an administrator.
2. Go to `/admin/config/splunk-rum`.

## Fields

- **Access token** — the Splunk RUM access token for your Splunk Observability
  environment. This is a credential: rather than pasting a long‑lived secret into
  the form and exporting it in configuration, prefer storing it in an environment
  variable (or a Key entity) where the module supports it, and keep it out of
  version control.
- **Application name** — the name your site should report under in Splunk, so you
  can identify this application's data.
- **Environment** — the environment label (for example *production* or *staging*)
  that tags the data, letting you separate metrics by environment in Splunk.

These values are used to build the SignalFx / Splunk RUM JavaScript snippet.

## Save

Save the form. The RUM script is then injected into your pages and begins
collecting real‑user data for Splunk Observability. Remember this only produces
results if the token and environment point at a live Splunk Observability setup.
