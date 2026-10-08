# Configuration

Stack Reporter's endpoint stays closed until you give it an API key. That key is
what StackReporter (or any authorised caller) must present to read your stack
information.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → System → Stack Reporter**, or navigate directly to
   `/admin/config/system/stack-reporter`.

## Settings

- **API key** — the secret that gates the endpoint. Callers must supply a matching,
  non-empty key to get a response; requests without it are refused. Choose a
  strong, random value and share it only with the monitoring service.
- **Site information / frameworks and libraries** — describe your site's stack by
  entering the relevant site information and selecting the frameworks and libraries
  it uses, so StackReporter has the full picture of what you run.

Save the configuration to apply your changes.

## Using the endpoint

With the key set, callers reach the endpoint at `/api/v1/stack-reporter` and
authenticate by passing the key one of two ways:

- as a query parameter: `?apikey=your_api_key`
- in the JSON request body: `{"apikey": "your_api_key"}`

A successful call returns the site's Drupal, PHP, and (where available) Node.js
versions as JSON.

## Keep the key secret

The response is a version fingerprint of your site — it tells the holder exactly
which Drupal, PHP, and Node versions you are running, which is precisely the sort
of detail an attacker uses to match a site to a known vulnerability. Treat the API
key like a password: give it only to the monitoring service, rotate it if it may
have been exposed, and prefer sending it in the JSON body over the query string
where you can, since URLs are more likely to end up in server logs.

## Troubleshooting

- **Authentication failing?** Double-check the key matches the one saved here, that
  you are using the parameter name `apikey`, and try both the query-parameter and
  JSON-body methods.
- **No Node.js version in the response?** Node detection needs PHP's `exec()`
  function enabled and Node.js installed and accessible on the server. If `exec()`
  is disabled on your host, the Drupal and PHP versions are still returned but the
  Node version is omitted.
