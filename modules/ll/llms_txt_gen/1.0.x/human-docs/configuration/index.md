# Configuration

LLMs.txt Gen needs very little setup: you choose which content types are indexed,
and decide how the sections get regenerated (cron, or Drush on demand).

## Open the settings

1. Log in as a user with the **administer llms_txt_gen** permission.
2. Go to **Configuration → Search and metadata → LLMs.txt Gen**
   (`/admin/config/search/llms-txt-gen`).

## Choose which content types to include

The form offers two modes:

- **Only those selected** — the file includes only the content types you tick.
- **All except those selected** — the file includes every content type *except* the
  ones you tick.

**Default behaviour:** if you don't select any content types, **all** content types
are included, regardless of which mode is chosen. So to narrow the output, pick a
mode and then tick the relevant content types.

Within the generated file, content types are listed alphabetically by label, and the
nodes inside each type are listed alphabetically by title. Each node appears as a
markdown link to its `.md` URL, for example
`- [Page title](https://example.com/node/1.md)`.

## Save

Save the form. The next generation run applies your choices.

## Regeneration

You don't have to regenerate by hand — sections rebuild automatically on every cron
run (and once on install), which keeps the file current as content is published. To
rebuild or clear immediately, use Drush:

| Command | Alias | What it does |
|---------|-------|--------------|
| `drush llms-txt-gen:generate` | `llms-gen` | Deletes existing sections, then regenerates one section per content type from published, anonymously‑viewable nodes. |
| `drush llms-txt-gen:delete` | `llms-del` | Deletes all generated sections. |

```bash
drush llms-gen   # rebuild after a bulk content import
drush llms-del   # clear all generated sections
```

## A note on what gets published

Because `/llms.txt` is served publicly, the generator only ever lists **published**
nodes, and it re‑checks each one against an **anonymous** user's view access before
including it — so access‑restricted content is not exposed. Node titles are escaped
to prevent markdown link injection. You don't need to configure any of this; it's
built into how the module generates the file.
