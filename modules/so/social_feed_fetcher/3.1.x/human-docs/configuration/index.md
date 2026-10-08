# Configuration

Social Feed Fetcher needs configuration before it does anything: it has to know
which platforms to pull from and be given valid API credentials for each. Its
settings are stored under the `social_feed_fetcher.settings` configuration.

## Who can configure it

Fetched posts and their management are gated by the **administer socialpost
entity** permission. Grant it (at **People → Permissions**) only to trusted
administrators, since it controls the credentials and the imported content.

## Set up platform credentials

For each social platform you want to display, you must register an application
with that platform and obtain an access token, then enter those details on the
module's settings form. Because the platforms have tightened access over time,
expect the following:

- **Twitter/X** — the free API tier has been closed; API access is now a paid
  product.
- **Instagram** — requires a Facebook app review and a business account.
- **Facebook** — page tokens expire and must be periodically refreshed.

Store each token securely. The recommended pattern on this project is a **Key**
entity backed by an environment variable, never a token pasted into exported
configuration that ends up in version control.

## After configuring

Once a platform is configured, the module fetches posts into Drupal nodes. From
there they behave like any other content — you can theme them, list them in a
View to build the social wall, and include them in site search. Two ongoing
points to keep in mind:

- **Watch for expiring tokens.** When a token lapses, the feed simply stops
  updating; there is no loud error, so periodic checks are worth scheduling.
- **Treat fetched HTML as untrusted.** Post content coming back from a platform
  should be rendered through a text format that limits allowed markup, not passed
  straight into a template.

Also remember that imported posts are other people's content — check each
platform's terms of service before republishing posts at length on your own site.
