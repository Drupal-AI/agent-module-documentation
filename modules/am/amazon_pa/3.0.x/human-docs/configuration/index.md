# Configuration

Before Amazon PAAPI5 can fetch anything, it needs your Amazon Product
Advertising API credentials.

## Open the settings form

1. Log in as a user with permission to administer the module's settings.
2. Go to the Amazon PAAPI5 settings form (route `amazon_pa.admin_settings`),
   reachable from the admin configuration area.

## What to enter

The form collects the credentials that authenticate your site to Amazon's
Product Advertising API:

- **Access key** — the public part of your Amazon PA-API credential pair.
- **Secret key** — the private half of the pair. This is a secret.
- **Partner / associate tag** — your Amazon Associates tag, used for affiliate
  attribution.

## Keep your keys secret

The **access key** and **secret key** are credentials. Do not paste them into
configuration that gets exported and committed to version control. The
recommended approach is to store them in **environment variables** and have
Drupal read them from there, so the secret never lives in your repository.
Requests to Amazon go over HTTPS.

## Usage notes

- Respect Amazon's **PA-API terms and rate limits** — the API caps how often you
  may call it.
- Product data you fetch is **external data**; Drupal escapes it on display like
  any untrusted content.

## Save

Save the form. With valid credentials in place, the module (and its submodules,
if enabled) can fetch and display Amazon product data.
