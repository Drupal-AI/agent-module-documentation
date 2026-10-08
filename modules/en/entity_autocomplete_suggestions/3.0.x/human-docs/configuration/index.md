# Configuration

The module starts working with sensible defaults the moment it is enabled, so this
form is about tailoring what appears in autocomplete suggestions and how many are
shown.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default) — the form is gated by that permission.
2. Go to **Configuration → Entity Autocomplete Suggestions Config**, or navigate
   directly to `/admin/config/autocomplete-suggestion-configurations`.

## The settings

- **Show entity type** — when enabled, each suggestion includes the entity type
  (for example the content type or vocabulary name), so an editor can tell a *Basic
  page* from an *Article* with the same title. This is **on by default**.
- **Show published/unpublished status** — when enabled, each suggestion is tagged
  *Published* or *Unpublished*. This is **off by default**, meaning unpublished
  content is not flagged (and, per core's selection handler, unpublished items are
  only ever offered to users already permitted to see them). On Drupal 8.8 and
  later this also covers vocabulary/term status, since the published field was
  introduced in that version.
- **Show vocabulary name** — includes the vocabulary name for taxonomy-term
  suggestions.
- **Limit results** — the maximum number of suggestions returned. The default is
  **10**; lower it for a tighter list or raise it if editors need to see more
  matches at once.

After adjusting the options, save the form. Changes take effect immediately — try
typing into an entity-reference autocomplete field to see the new labels.

## A note on status disclosure

Showing the *Unpublished* marker reveals that unpublished content exists. Because
the module reuses the field's selection handler, it only ever shows entities that
handler already returns for the current user — so it does not expose content a user
could not otherwise reach. Still, if you would rather not surface unpublished status
to editors at all, simply leave **Show published/unpublished status** off (its
default).
