# Configuration

Configuring Paragraphs Usage Manager is a two‑part process: first tell it which
entity types to scan, then manage where each paragraph type is allowed — either
one type at a time or from a single global matrix.

## Step 1 — Choose which entity types to scan

1. Log in as a user with the **administer paragraphs usage manager** permission.
2. Go to **Configuration → Content authoring → Paragraphs Usage Manager**.
3. Select which **entity types** should be scanned for paragraph reference fields.
   Restricting discovery to the entity types you actually use keeps the management
   screens focused and fast.
4. **Save the configuration.**

Once saved, the module discovers all `entity_reference_revisions` fields that
target paragraphs on those entity types. It works with any supported fieldable
content entity, including custom entities, and it understands nested paragraphs
(where a paragraph is itself a parent for other paragraphs).

## Step 2 — Manage paragraph usage

After scanning is set up, there are two ways to control usage.

### Per paragraph type — the "Manage usage" tab

Edit a paragraph type (at **Structure → Paragraph types**) and open its **Manage
usage** tab. There you decide, for that single paragraph type, which parent fields
it should be allowed in. This is the quickest way to answer "where can this one
component be used?"

### Globally — the overview matrix

For a bird's‑eye view, open the **global usage matrix**. It lists all paragraph
types against all detected parent fields, so you can grant or revoke usage across
the whole site from one screen instead of editing each field configuration
individually.

## How your changes are applied

The module treats Drupal's native field configuration as the single source of
truth and edits it carefully:

- **Differential updates** — only the relevant paragraph bundle is added or
  removed on a field; other allowed bundles on that field are preserved.
- **Both handler modes** — it supports the Paragraphs selection handler's
  **include** and **exclude** configurations.
- **Widget consistency** — it keeps `target_bundles_drag_drop` in sync so the
  field widget configuration stays consistent.
- **Read‑only safety** — fields that use custom or unsupported selection handlers
  are reported as **read‑only** rather than being overwritten, so the module never
  clobbers configuration it does not fully understand.

Because it only rewrites standard field settings, there is no separate parallel
configuration to keep in step — what you set here is exactly what appears in each
field's normal allowed‑types settings.
