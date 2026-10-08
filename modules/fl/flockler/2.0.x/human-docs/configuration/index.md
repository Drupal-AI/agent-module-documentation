# Configuration

Flockler feed is configured through its **block** — there is no separate global
settings form. You place the block, tell it which Flockler feed to show, and set
where it appears.

## Grant the permission

Under **People → Permissions** (`/admin/people/permissions`), grant the Flockler
permission to the roles that should be able to place and manage the feed block
(typically administrators and site builders).

## Place and configure the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Choose the region where you want the social feed to appear and click **Place
   block**.
3. Find and select the **Flockler** feed block.
4. In the block's configuration, enter your **Flockler feed / site identifier** —
   the embed value from your Flockler account that identifies the feed you want to
   display.
5. Set the usual block visibility and region options as needed, then **Save
   block**.

The block will now render your Flockler feed in that region.

## Notes

- **The identifier is a public embed value.** It is the same identifier Flockler
  provides for embedding a feed on any website, not a private API secret, so it
  does not require Key/secret handling.
- **It is third-party content over an outbound connection.** The feed's posts come
  from Flockler and are curated there — what appears is controlled in your Flockler
  account, and the browser (or your site) reaches out to Flockler to render it.
  Review Flockler's terms and be mindful that you are surfacing external content on
  your pages.
