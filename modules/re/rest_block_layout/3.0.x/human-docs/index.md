# Block Layout — manual setup guide

**Block Layout** (`rest_block_layout`) is a single REST endpoint for decoupled and
headless front ends that need to reproduce Drupal's block placement without
rendering Drupal's theme. You give it a site path and it tells you which blocks
would be visible in each region on that path — the sidebars, headers, footers and
main-content placement you configured in Drupal — so a React, Vue or Next.js front
end can lay the page out the same way Drupal would.

The endpoint (`GET /block-layout`) takes one query argument, a URL-encoded `path`
that starts with a forward slash. Internally the module matches the route for that
path using Drupal's **access-aware** router, collects the blocks visible per region
for the current user (honouring each block's visibility conditions), and returns
them keyed by region. It also enriches the response with the matched route name, and
— only when the current user actually has *view* access to the resolved entity — the
target entity's payload. That access check means the endpoint respects your content
permissions: a caller who cannot view a node will get the layout but not the node's
data.

A typical call looks like this:

```
GET https://example.com/block-layout?_format=json&path=%2Fnode%2F123
```

The endpoint works in any serialisation format your site has available, and its
responses carry cache metadata (a cache context keyed on the `path` query argument,
plus block-list cache tags) so they cache cleanly per path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   then turn on the REST resource and grant the permission.

There is **no dedicated settings form** for this module. What configuration it needs
— enabling the `block_layout` REST resource and granting the calling permission — is
done through core's REST configuration (most easily with the REST UI module), and is
covered in the installation guide.

## Where it lives in the admin menu

Block Layout adds no admin page of its own. You enable and configure its REST
resource alongside your other REST resources at **Configuration → Web services →
REST** (`/admin/config/services/rest`, provided by the REST UI module), and you
grant the calling permission at **People → Permissions**.
