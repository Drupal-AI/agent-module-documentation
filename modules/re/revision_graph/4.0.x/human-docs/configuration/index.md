# Configuration

Revision Graph works with **no configuration** — the only thing you can configure is
the **colour the graph draws each branch (language) in**. If you never open this
form, the graph still works and picks sensible colours on its own.

## Open the settings form

1. Grant the **Administer Revision Graph** permission (`administer revision graph`)
   at **People → Permissions** to the roles that should manage colours. This
   permission gates the settings form only — it does **not** control who can *view*
   the graph (that follows the core "view all revisions" permission on the node).
2. Go to **Configuration → Content authoring → Revision Graph**
   (`/admin/config/content/revision-graph`).

## How the colour of a branch is decided

For each branch (a language), the module picks a colour by working down this list
and using the first rule that applies:

1. An **explicit override** you set for that language on this form.
2. The colour the module already ships for that language code (it has a built-in
   table covering about 95 languages), so most branches are coloured sensibly with
   no input from you.
3. A colour proposed from the **palette** below, chosen by hashing the branch name.
   This is rarely reached, because an ordinary branch is a language code the shipped
   table already covers.

## The two fields

- **Branch colours** — per-branch overrides. Enter one `name|#rrggbb` pair per line,
  where the name is the branch (a language code such as `de` or `fr`) and the value
  is a hex colour, for example:

  ```
  de|#1a7f37
  fr|#a43631
  ```

  An override for a language your site does not have is simply ignored, not an
  error. Colours are normalised to lowercase `#rrggbb` (so `#ABC`, `abc`, and
  `#aabbcc` all become `#aabbcc`).

- **Palette** — the last-resort list of colours (one `#rrggbb` per line) used to
  propose a colour when neither an override nor a shipped language colour applies.
  If you leave it empty, the module falls back to its seven built-in default colours
  — not to a single flat colour.

If you enter an invalid line, the form reports it per line when you save, so you can
fix just that line.

## Save

Click **Save** and reload a Revision Graph tab — the branches redraw in the colours
you set.

## Setting colours from the command line (optional)

The same settings can be set with Drush instead of the form:

```bash
# Override German to a specific colour.
drush config:set revision_graph.settings branch_colors.de '#1a7f37' -y

# Replace the first palette entry (or set the whole 'palette' key at once).
drush config:set revision_graph.settings palette.0 '#a43631' -y
```
