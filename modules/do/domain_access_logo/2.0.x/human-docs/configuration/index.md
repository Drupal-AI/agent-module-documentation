# Configuration

Domain Access Logo has a single settings form where you assign a logo to each of
your domains. Everything happens on that one page.

## Open the settings form

1. Log in as a user with the **Administer domains access logos** permission.
2. Go to **Configuration → Domain → Domain Access Logo**, or navigate directly to
   `/admin/config/domain/domain_access_logo`.

## The form, domain by domain

The form is organised around the domain records you have created in the Domain
module. For each domain you will see:

- **The domain it applies to** — each of your configured domains is listed, so
  the settings are scoped per domain rather than site-wide.
- **A logo upload** — choose an image file to use as that domain's logo. The
  image is stored as a normal Drupal managed file in the file system, so you can
  replace it later without redeploying code. Domains you leave without an upload
  simply fall back to the site's default logo behavior.

Upload a logo for each domain that needs its own branding, then click **Save
configuration**.

## What happens after you save

At render time the module resolves the current domain and serves that domain's
logo, keyed on the active domain rather than the active theme. That means the
correct logo appears no matter which theme is in use, and switching themes does
not disturb the per-domain branding.

## A note for deployments

Because the logos are uploaded files rather than configuration values, they are
**not** included in a configuration export (`drush config:export`). When you move
a site between environments, migrate the logo files along with your other
uploaded files rather than expecting them to travel with your config.
