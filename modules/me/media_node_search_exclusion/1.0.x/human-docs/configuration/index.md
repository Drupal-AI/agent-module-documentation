# Configuration

The module does nothing until you tell it which field marks media as excluded and
which bundles to watch. Everything is configured on one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Media Node Search Exclusion**, or
   navigate directly to `/admin/config/search/media-node-search-exclusion`.

## Media exclusion field

Choose the **boolean field** on your media entities that holds the "exclude from
search" flag — typically the field provided by the **Search API Exclude Entity**
module. This is the signal the whole workflow keys off: when a media item's value
in this field is true, the module considers that item excluded and propagates the
result to referencing nodes.

## Allowed media bundles

Select which **media bundles** participate in propagation. Limiting this to the
bundles that actually carry restricted or hideable media keeps the module focused
and avoids scanning media types where exclusion is irrelevant.

## Exclusion strategy

Pick how a node's exclusion is decided when it references more than one media item:

- **Exclude the node when *any* referenced media is excluded** — the stricter
  option; a single hidden media item hides the whole page.
- **Exclude the node only when *all* referenced media are excluded** — the more
  permissive option; the page stays searchable as long as at least one referenced
  media item is still visible.

(The module's architecture is extensible, so developers can add a custom rule
service if neither strategy fits — but the two above cover the common cases from
the UI.)

## Processing: inline or queued

Decide whether propagation runs **inline** — immediately as media and nodes are
saved — or is **deferred to a queue**. Inline is simplest and fine for small
sites. For content‑heavy sites where a single media item may be referenced by many
nodes, use the queue so that saves stay fast and the heavy propagation work
happens asynchronously (processed on cron or via a queue runner).

## Debug logging

Enable **debug logging** to trace how the module decides whether each node should
be excluded. This is useful while you are dialling in the field and bundle
settings; turn it off in production once the behaviour is confirmed, to keep the
log quiet.

## Save and propagate

Click **Save configuration**. Note that changing these settings does not
retroactively rewrite existing content on its own — after adjusting the field or
bundles, re‑save the affected media (or run a batch update) so the new rules
propagate to the referencing nodes. From then on, the module keeps things in sync
automatically as media and nodes are saved.
