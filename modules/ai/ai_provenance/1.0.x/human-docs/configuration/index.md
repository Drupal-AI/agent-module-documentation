# Configuration

## Open the settings form

1. Log in as a user with the restricted **Administer AI provenance** permission.
2. Go to **Configuration → AI → AI provenance**
   (`/admin/config/ai/provenance`).

## Choose which entity types are tracked

The main setting is picking which entity types should have provenance recorded —
for example nodes, media, or custom entities. Provenance is stored in a dedicated
`ai_provenance_record` content entity rather than as fields on the tracked
entities themselves, which means:

- one queryable store across all your content types,
- per-revision and per-field granularity, and
- access control on the provenance data that is independent of the content.

## The disclosure gradient

Each record expresses AI involvement on a four-step gradient (backed by core's
Options):

| Value | Public disclosure |
|---|---|
| `generated` | AI-generated content |
| `ai_assisted` | Created with AI assistance |
| `human_reviewed` | AI-generated, reviewed by a human |
| `human_written` | Written by a human (not labelled unless you opt in) |

By default, human-written content is left unlabelled unless you choose to disclose
it too.

## Manage records

The records collection is at **Reports → AI provenance**
(`/admin/reports/ai-provenance`), gated by **Administer AI provenance**. This is
where you review and manage recorded provenance.

## Front-end badges

Users with the separate **View AI provenance** permission see the transparency
badge on the front end — both a human-visible label and machine-readable output
for downstream consumers. This is what satisfies the EU AI Act text-transparency
obligations (effective August 2026), and it complements `ai_decision_log`, which
records *why* a decision was made.
