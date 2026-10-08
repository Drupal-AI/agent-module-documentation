# Configuration

Getting Discourse comments (+) working is a few steps: connect Drupal to your
Discourse instance with API credentials, publish content so a Discourse topic
exists, and place the comments block so the discussion shows on the page.

## Step 1 — enter your Discourse credentials

1. Log in as an administrator.
2. Go to **Configuration → Discourse Comments → Discourse comments settings**, or
   navigate directly to
   `/admin/config/discourse_comments/discourse_comments_settings`.
3. Fill in the connection settings:
   - **Discourse API key** and related credentials — the API key (and typically the
     API username / Discourse base URL) that let Drupal talk to your Discourse
     instance's REST API. You create the API key in Discourse under **Admin → API**.
   - **SSO secret key** — required only for the "+" feature that lets visitors log
     in to Discourse via SSO and comment directly from Drupal. This must match the
     connect/SSO secret configured on the Discourse side.
4. Save the form.

> **Keep these secret.** The API key and SSO secret are credentials that grant
> access to your Discourse instance. Avoid committing them to version control — the
> recommended pattern is to store each value in an environment variable and, where
> supported, reference it through a **Key** entity.
>
> **DDEV:** e.g. `ddev dotenv set .ddev/.env --discourse-api-key=<value>` then
> `ddev restart`, keeping `.ddev/.env` out of version control.

## Step 2 — publish a node to Discourse

When you create or edit content that should have Discourse comments, tick the
**"Publish to Discourse"** checkbox on the node edit page **the first time** you
publish it. This creates the corresponding topic in Discourse that the comments
will attach to.

## Step 3 — place the "Discourse comments" block

To actually display the discussion on the page:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Discourse comments** block in the region where you want comments to
   appear (typically the content region, below the node body).
3. Use the block's **Visibility** conditions if you want it only on certain content
   types or pages.

Once placed, the block fetches the associated Discourse topic's posts and shows
them as comments on the corresponding Drupal node.

## A note on egress

Content you publish is **sent to your Discourse instance**, and (with SSO)
visitors' identities are shared between the two systems. Make sure your Discourse
instance and its access controls are set up the way you expect before enabling
this on public content.
