# Configuration

Token Filter has no settings page of its own. You enable it per **text format**, on
the standard Text formats and editors screen, and (optionally) add its token browser
button to CKEditor 5. You'll need the **Administer filters** permission (an
administrator by default).

## Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want to enable tokens for (for example
   *Full HTML* or a custom format). Be deliberate about which formats get it — only
   enable it on formats used by trusted roles, since tokens can expose values such as
   the current user's data.
3. Under **Enabled filters**, tick **"Replaces global and entity tokens with their
   values"**.
4. Scroll to **Filter processing order** and drag Token Filter into a sensible
   position — usually **near the end**, after the HTML‑handling filters, so tokens are
   resolved on the final markup. (For instance, place it appropriately relative to
   "Convert line breaks.")
5. Click **Save configuration**.

From now on, any token typed into a field that uses this format is expanded when the
content is rendered — global tokens like `[site:name]` always, and entity tokens like
`[node:title]` when the text is a field on a content entity.

## Add the CKEditor 5 token browser (optional)

If the format uses CKEditor 5, you can give editors a button that opens the standard
token tree so they don't have to remember token names:

1. On the same format's configuration page, find the **CKEditor 5** toolbar
   configuration (the drag‑and‑drop toolbar builder).
2. Drag the **Token browser** item from the *Available buttons* row into the
   **Active toolbar**.
3. Save the format.

Editors will now see a Token browser button in the editor; clicking it lets them pick
a token from the tree and insert it. (This button relies on the Token module, which is
installed as a dependency.)

## Notes

- Token Filter adds **no permissions and no standalone configuration object** — the
  only settings are the per‑format filter and toolbar choices above.
- On sites upgraded from Drupal 7, an existing `filter_tokens` filter is mapped to
  `token_filter` automatically during migration, so legacy token filters carry over.
