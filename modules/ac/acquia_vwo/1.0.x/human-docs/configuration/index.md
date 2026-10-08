# Configuration

Acquia VWO's setup is spread across three related pages under **Configuration →
System → Acquia VWO**: the main settings, the visibility rules, and the VWO account
ID. Between them you decide **which account** the script talks to and **which pages**
it loads on.

## Open the settings

Log in as a user with the **Administer Acquia VWO** permission (see below), then go
to **Configuration → System → Acquia VWO** (`/admin/config/system/acquia_vwo`).

## The VWO account ID

On the account-ID page (`/admin/config/system/acquia_vwo/vwoid`), enter your **VWO
account ID**. This is the identifier from your Visual Website Optimizer account that
ties the on-site script to the right VWO project, so experiments you build in VWO run
against your site. Without it the script has nothing to connect to.

## Visibility — which pages carry the script

On the visibility page (`/admin/config/system/acquia_vwo/visibility`), choose **where
the VWO script loads**. Rather than dropping the script on every page, decide
deliberately which pages should carry it — the ones where you actually run
experiments. Loading it only where needed keeps the third-party script off pages that
do not need it, which is both cleaner and lighter.

## Enhanced data capture

Because the module depends on Node and Taxonomy, it passes Drupal's **content
metadata** — content type, taxonomy terms and similar — into VWO automatically on the
pages where the script runs. You do not enter this data by hand; it lets your VWO
experiments and reports **segment by content type or section** (for example, testing
a variant only on Pricing pages). This is the "enhanced data capture" the module is
named for.

## The permission

At **People → Permissions** (`/admin/people/permissions`), assign **Administer Acquia
VWO** to the roles that should manage the integration. As with any configuration
permission, grant it only to roles you trust to manage site settings.

## Two things to arrange before you go live

Neither of these is the module's job, but both belong in any A/B-testing deployment:

- **The VWO script can rewrite the page client-side** before a visitor sees it — that
  is the feature, and it means the VWO account is part of your site's trust boundary.
  Only connect an account you control and trust.
- **VWO sets cookies to bucket visitors**, so on an EU-facing site the script needs
  **consent gating** like any other non-essential tracker. Arrange that with a consent
  tool (for example `usercentrics` or `consent_mode`) and document the VWO cookies in
  your privacy notice.
