# Configuration

Setting up External Media has three parts: enter each provider's identifier on the
settings form, decide which roles may import from which provider, and attach the
picker widget to your fields. This page covers the first two; attaching the widget
is described in "How to use it" on the [overview page](../index.md).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → External Media**, or navigate directly to
   `/admin/config/media/external-media`.

You'll see a section for each provider whose supporting code is installed —
Dropbox, Google Drive, OneDrive, or Box. Providers whose class cannot be loaded
are not shown at all.

## Provider client / app IDs

For each provider you're enabling, enter its **client ID** or **app ID** (Box,
Google Drive and OneDrive use these identifiers). These are the public,
browser-side identifiers issued by each provider's developer console when you
register an application there — they are *not* secrets, and it is expected that
they appear in the page delivered to the browser.

Because the client ID is public, the real security work happens on the provider's
side: in each provider's OAuth application configuration, lock down the **allowed
origins** and **redirect URIs** to your own site so the credential can only be
used from where you intend. That is what actually constrains access, not the ID
itself.

> **If a provider does give you a genuine client *secret*,** treat it as a real
> secret: don't paste it into a form that renders to the browser and don't commit
> it. Follow this project's convention — store it in an environment variable with
> `ddev dotenv set .ddev/.env --…`, then surface it through a **Key** entity, and
> reference the Key rather than the raw value.

## Provider availability and permissions

The module creates one permission per available provider, named along the lines
of **"upload from *dropbox*"**, **"upload from *google_drive*"**, and so on. Grant
these at **People → Permissions** (`/admin/people/permissions`) to exactly the
roles that should be allowed to import from each provider. A role without a
provider's permission won't see that provider's picker option.

This per-provider control lets you, for example, enable Google Drive for all
editors but restrict Dropbox to a single editorial role — simply by which
permission each role holds.

## Save

Click **Save configuration**. Then head to a content type's **Manage form
display**, switch a file or image field to the **External Media** widget, and the
cloud picker becomes available to any role you've granted the matching permission.

## About the OAuth return route

The module exposes an intentionally open callback route
(`/external-media/redirect/{external_media}`) that a provider redirects the
browser back into after the user picks a file. It has to be reachable without a
Drupal permission because the provider — not a logged-in Drupal session — is what
triggers it; it is constrained instead by a parameter converter and each
provider's own state validation. You don't configure this route; just be aware
that changes to it are security-relevant.
